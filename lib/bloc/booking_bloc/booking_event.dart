part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();
}

class LoadBookingEvent extends BookingEvent {
  final int idOffice;
  final int serviceDuration;

  const LoadBookingEvent(this.idOffice, this.serviceDuration);

  @override
  List<Object?> get props => [idOffice, serviceDuration];
}
