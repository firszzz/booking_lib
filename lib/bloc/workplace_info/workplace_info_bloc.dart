
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'workplace_info_event.dart';
part 'workplace_info_state.dart';

class WorkplaceInfoBloc extends Bloc<WorkplaceInfoEvent, WorkplaceInfoState> {
  WorkplaceInfoBloc() : super(WorkplaceInfoInitial()) {
    on<WorkplaceInfoEvent>((event, emit) async {
      const storage = FlutterSecureStorage();
      var login = await storage.read(key: 'login');
      var password = await storage.read(key: 'password');

      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$login:$password'))}';

      emit(WorkplaceInfoLoadedState(basicAuth));
    });
  }
}
