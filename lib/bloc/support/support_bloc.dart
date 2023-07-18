import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/models/support_message.dart';
import '../../internal/dependencies/repository_module.dart';

part 'support_event.dart';

part 'support_state.dart';

class SupportBloc extends Bloc<SupportEvent, SupportState> {
  var supportRepository = RepositoryModule.supportRepository();

  SupportBloc() : super(SupportLoadingState()) {
    on<LoadSupportEvent>((event, emit) async {
      List<SupportMessage> listMessages = [];

      try {
        final data = await supportRepository.getSupports(status: 'active');

        for (var el in data) {
          listMessages.add(el);
        }

        emit(SupportLoadedState(listMessages));
      }
      on DioError catch (e) {
        if (e.response?.statusCode == 404) {
          emit(SupportLoadedState(listMessages));
        }
        else {
          debugPrint(e.toString());
        }
      }
    });

    on<ChangeSupportEvent>((event, emit) async {
      List<SupportMessage> listMessages = [];

      try {
        final data = await supportRepository.getSupports(status: event.choice);

        for (var el in data) {
          listMessages.add(el);
        }

        emit(SupportLoadedState(listMessages));
      }
      on DioError catch (e) {
        if (e.response?.statusCode == 404) {
          emit(SupportLoadedState(listMessages));
        }
        else {
          debugPrint(e.toString());
        }
      }
    });

    on<ChangeStatusEvent>((event, emit) async {
      try {
        await supportRepository.changeStatusSupport(status: event.choice, id: event.id.toString());
      }
      on DioError catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
