import 'package:flutter_bloc/flutter_bloc.dart';
import '../../preferences/models/preferences.dart';
import '../../preferences/services/preferences_service.dart';


class PreferencesCubit extends Cubit<Preferences> {
  final PreferencesService _service;

  PreferencesCubit(
      this._service,
      Preferences initialState,
      ) : super(initialState);

  Future<void> changePreferences(Preferences preferences) async {
    await _service.set(preferences);
    emit(preferences);
  }

  Future<void> deleteAllPreferences() async {
    await _service.clear();
    emit(Preferences.defaultValues());
  }
}
