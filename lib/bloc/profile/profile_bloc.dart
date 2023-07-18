import 'package:atb_flutter_demo/internal/usecases/get_user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/models/user.dart';


part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final _getUser = GetUser();

  ProfileBloc() : super(ProfileLoadingState()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        const storage = FlutterSecureStorage();
        var idEmployee = await storage.read(key: 'idEmployee');

        final data = await _getUser(UserParams(id: idEmployee!));

        emit(ProfileLoadedState(data));
      } catch (e) {
        emit(ProfileErrorState(e.toString()));
      }
    });
  }
}
