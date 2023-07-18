import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/booking_bloc/booking_bloc.dart';
import '../../../cubit/preferences/preferences_cubit.dart';
import '../../../domain/models/office.dart';
import '../../../modules/booking_library/booking_calendar.dart';
import '../../../modules/booking_library/model/enums.dart';

class BookingBlocScreen extends StatefulWidget {
  const BookingBlocScreen({Key? key}) : super(key: key);

  @override
  State<BookingBlocScreen> createState() => _BookingBlocScreenState();
}

class _BookingBlocScreenState extends State<BookingBlocScreen> {
  final now = DateTime.now();
  int serviceDuration = 60;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final preferencesCubit = context.read<PreferencesCubit>();
    int idOffice = Office.fromJson(preferencesCubit.state.office).id;

    final _bloc = BookingBloc()
      ..add(LoadBookingEvent(idOffice, serviceDuration));
    return BlocProvider<BookingBloc>(
        create: (context) => _bloc,
        child: BlocBuilder<BookingBloc, BookingState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is BookingLoadingState) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                      color: AppColorStyles.atbOrange),
                ),
              );
            }
            if (state is BookingLoadedState) {
              BookingService bookingService = BookingService(
                  serviceId: '1',
                  serviceName: 'ATBooking',
                  serviceDuration: serviceDuration,
                  bookingStart: DateTime(now.year, now.month, now.day,
                      int.parse(state.officeTimeBegin[0]), int.parse(state.officeTimeBegin[1])),
                  bookingEnd: DateTime(now.year, now.month, now.day,
                      int.parse(state.officeTimeEnd[0]), int.parse(state.officeTimeEnd[1])),
                  numSeats: state.numSeats);

              return Scaffold(
                appBar: AppBar(
                  title: Text(state.workplace),
                  actions: [
                    PopupMenuButton(
                      onSelected: (val) {
                        setState(() {
                          serviceDuration = val;
                        });
                        _bloc.add(LoadBookingEvent(idOffice, serviceDuration));
                      },
                      icon: const Icon(
                        Icons.watch_later_outlined,
                      ),
                      itemBuilder: (context) => [
                        const PopupMenuItem<int>(
                          value: 15,
                          child: Text('Интервал: 15 минут'),
                        ),
                        const PopupMenuItem<int>(
                          value: 30,
                          child: Text('Интервал: 30 минут'),
                        ),
                        const PopupMenuItem<int>(
                          value: 60,
                          child: Text('Интервал: 1 час'),
                        ),
                      ],
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: AppColorStyles.orangeGradient,
                      ),
                    ),
                  ),
                ),
                body: SafeArea(
                  child: Center(
                    child: BookingCalendar(
                        bookingService: bookingService,
                        convertStreamResultToDateTimeRanges:
                            state.convertStreamResultMock,
                        getBookingStream: state.getBookingStream,
                        uploadBooking: state.setReservation,
                        pauseSlots: state.generatePauseSlots(),
                        hideBreakTime: false,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        pauseSlotText: 'Недоступное время',
                        availableSlotText: 'Свободное время',
                        selectedSlotText: 'Выбранное время',
                        bookedSlotText: 'Забронированное время',
                        bookingButtonText: 'ЗАБРОНИРОВАТЬ',
                        availableSlotColor: const Color(0xff3be8b0),
                        bookedSlotColor: const Color(0xfffc636b),
                        selectedSlotColor: const Color(0xffffe4b5),
                        pauseSlotColor: const Color(0xffc0c0c0),
                        lastDayBooking: state.lastDayBooking,
                        bookingButtonColor: AppColorStyles.atbOrange,
                        locale: 'ru_RU',
                        uploadingWidget: const CircularProgressIndicator(
                            color: AppColorStyles.atbOrange),
                        numSeats: state.numSeats,
                        hideNumSeats: state.hideNumSeats),
                  ),
                ),
              );
            }
            return Scaffold(
              body: Center(child: Text('Something went wrong: $state')),
            );
          },
        ));
  }
}
