import 'package:atb_flutter_demo/internal/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

import '../../domain/models/reservation.dart';
import '../dependencies/repository_module.dart';

class GetConfirmedReservations extends UseCase<List<Reservation>, GetConfirmedReservationsParams> {
  final _reservationsRepository = RepositoryModule.reservationRepository();

  @override
  Future<List<Reservation>> call(GetConfirmedReservationsParams params) async {
    return await _reservationsRepository.getConfirmedReservations(
        id: params.id,
        confirmed: params.confirmed,
    );
  }

}

class GetConfirmedReservationsParams extends Equatable{
  final String id;
  final bool confirmed;

  const GetConfirmedReservationsParams({
    required this.id,
    required this.confirmed,
  });

  @override
  List<Object?> get props => [id, confirmed];

}