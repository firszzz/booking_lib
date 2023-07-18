import 'package:atb_flutter_demo/domain/models/reservation.dart';
import 'package:atb_flutter_demo/internal/dependencies/repository_module.dart';
import 'package:atb_flutter_demo/internal/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

class GetReservations extends UseCase<List<Reservation>, GetReservationsParams> {
  final _reservationsRepository = RepositoryModule.reservationRepository();

  @override
  Future<List<Reservation>> call(GetReservationsParams params) async {
    return await _reservationsRepository.getReservations(id: params.id);
  }
}

class GetReservationsParams extends Equatable{
  final String id;

  const GetReservationsParams({
    required this.id,
  });

  @override
  List<Object?> get props => [id];

}