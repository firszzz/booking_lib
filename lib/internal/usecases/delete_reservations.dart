import 'package:atb_flutter_demo/domain/models/reservation.dart';
import 'package:atb_flutter_demo/internal/dependencies/repository_module.dart';
import 'package:atb_flutter_demo/internal/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

class DeleteReservations extends UseCase<void, DeleteReservationsParams> {
  final _reservationsRepository = RepositoryModule.reservationRepository();

  @override
  Future<void> call(DeleteReservationsParams params) async {
    await _reservationsRepository.deleteReservations(id: params.id);
  }

}

class DeleteReservationsParams extends Equatable{
  final String id;

  const DeleteReservationsParams({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}