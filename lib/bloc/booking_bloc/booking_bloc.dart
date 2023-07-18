import 'dart:convert';

import 'package:atb_flutter_demo/internal/dependencies/repository_module.dart';
import 'package:atb_flutter_demo/resources/env.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../data/api/request/api.dart';
import '../../modules/booking_library/booking_calendar.dart';

part 'booking_event.dart';

part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  var bookingRepository = RepositoryModule.bookingRepository();
  var otherReservationRepository =
      RepositoryModule.otherReservationRepository();
  var officeRepository = RepositoryModule.officeRepository();

  BookingBloc() : super(BookingLoadingState()) {
    on<LoadBookingEvent>((event, emit) async {
      const storage = FlutterSecureStorage();
      var idEmployee = await storage.read(key: 'idEmployee');
      var idWorkPlace = await storage.read(key: 'idWorkPlace');
      var placeType = await storage.read(key: 'placeType');
      var numSeats = await storage.read(key: 'numSeats');
      bool type = placeType!.toLowerCase() == 'true';
      List<DateTimeRange> converted = [];
      int idOffice = event.idOffice;
      List<String> officeTimeBegin = [];
      List<String> officeTimeEnd = [];
      late int lastDayBooking;

      emit(BookingLoadingState());

      try {
        final data =
            await officeRepository.getOfficeInfo(id: idOffice.toString());

        for (var el in data) {
          officeTimeBegin.add(el.timeBegin[0] + el.timeBegin[1]);
          officeTimeBegin.add(el.timeBegin[3] + el.timeBegin[4]);
          officeTimeEnd.add(el.timeEnd[0] + el.timeEnd[1]);
          officeTimeEnd.add(el.timeEnd[3] + el.timeEnd[4]);
          lastDayBooking = el.numDay;
        }
      } catch (e) {
        debugPrint(e.toString());
      }

      try {
        final data =
            await otherReservationRepository.getReservations(id: idEmployee!);

        for (var el in data) {
          if (el.idWorkPlace.toString() != idWorkPlace) {
            var tb = DateTime.parse(el.timeBegin).toLocal();
            var te = DateTime.parse(el.timeEnd).toLocal();

            if (te.isAfter(DateTime.now())) {
              if (!converted.contains(DateTimeRange(start: tb, end: te))) {
                converted.add(DateTimeRange(start: tb, end: te));
              }
            }
          }
        }
      } on DioError catch (e) {
        if (e.response?.statusCode != 404) {
          debugPrint(e.message);
        }
      }

      try {
        final data = await bookingRepository.getBookings(id: idWorkPlace!);

        for (var el in data) {
          var tb = DateTime.parse(el.timeBegin).toLocal();
          var te = DateTime.parse(el.timeEnd).toLocal();

          if (te.isAfter(DateTime.now())) {
            if (!converted.contains(DateTimeRange(start: tb, end: te))) {
              converted.add(DateTimeRange(start: tb, end: te));
            }
          }
        }

        emit(
          BookingLoadedState(
            timeList: converted,
            officeTimeBegin: officeTimeBegin,
            officeTimeEnd: officeTimeEnd,
            lastDayBooking: lastDayBooking,
            numSeats: int.parse(numSeats!),
            workplace: type
                ? "Переговорная №$idWorkPlace"
                : "Рабочее место №$idWorkPlace",
            hideNumSeats: type,
            serviceDuration: event.serviceDuration,
          ),
        );
      } on DioError catch (e) {
        if (e.response?.statusCode == 404) {
          emit(
            BookingLoadedState(
              timeList: converted,
              officeTimeBegin: officeTimeBegin,
              officeTimeEnd: officeTimeEnd,
              lastDayBooking: lastDayBooking,
              numSeats: int.parse(numSeats!),
              workplace: type
                  ? "Переговорная №$idWorkPlace"
                  : "Рабочее место №$idWorkPlace",
              hideNumSeats: type,
              serviceDuration: event.serviceDuration,
            ),
          );
        } else {
          debugPrint(e.message);
        }
      }
    });
  }
}
