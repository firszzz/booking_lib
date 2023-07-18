import 'package:atb_flutter_demo/modules/booking_library/model/booking_service.dart';
import 'package:atb_flutter_demo/modules/booking_library/util/booking_util.dart';
import 'package:flutter/material.dart';

class BookingController extends ChangeNotifier {
  BookingService bookingService;

  BookingController({required this.bookingService, this.pauseSlots}) {
    serviceOpening = bookingService.bookingStart;
    serviceClosing = bookingService.bookingEnd;
    pauseSlots = pauseSlots;
    if (serviceOpening!.isAfter(serviceClosing!)) {
      throw "Service closing must be after opening";
    }
    base = serviceOpening!;
    _generateBookingSlots();
  }

  late DateTime base;

  DateTime? serviceOpening;
  DateTime? serviceClosing;

  List<DateTime> _allBookingSlots = [];

  List<DateTime> get allBookingSlots => _allBookingSlots;

  List<DateTimeRange> bookedSlots = [];
  List<DateTimeRange>? pauseSlots = [];

  List<int> _selectedSlot = [-1];
  bool _isUploading = false;

  List<int> get selectedSlot => _selectedSlot;

  bool get isUploading => _isUploading;

  void _generateBookingSlots() {
    allBookingSlots.clear();
    _allBookingSlots = List.generate(
        _maxServiceFitInADay(),
        (index) => base
            .add(Duration(minutes: bookingService.serviceDuration) * index));
  }

  int _maxServiceFitInADay() {
    ///if no serviceOpening and closing was provided we will calculate with 00:00-24:00
    int openingHours = 24;
    if (serviceOpening != null && serviceClosing != null) {
      openingHours = DateTimeRange(start: serviceOpening!, end: serviceClosing!)
          .duration
          .inHours;
    }

    ///round down if not the whole service would fit in the last hours
    return ((openingHours * 60) / bookingService.serviceDuration).floor();
  }

  bool isSlotBooked(int index) {
    DateTime checkSlot = allBookingSlots.elementAt(index);
    bool result = false;
    for (var slot in bookedSlots) {
      if (BookingUtil.isOverLapping(slot.start, slot.end, checkSlot,
          checkSlot.add(Duration(minutes: bookingService.serviceDuration)))) {
        result = true;
        break;
      }
    }
    return result;
  }

  void selectSlot(int idx) {
    _selectedSlot.add(idx);
    _selectedSlot.removeWhere((element) => element == -1);

    notifyListeners();
  }

  void unselectSlot(int idx) {
    _selectedSlot.remove(idx);
    notifyListeners();
  }

  void resetSelectedSlot() {
    _selectedSlot.removeWhere((element) => element != -1);
    _selectedSlot.add(-1);
    notifyListeners();
  }

  void toggleUploading() {
    _isUploading = !_isUploading;
    notifyListeners();
  }

  Future<void> generateBookedSlots(List<DateTimeRange> data) async {
    bookedSlots.clear();
    _generateBookingSlots();

    for (var i = 0; i < data.length; i++) {
      final item = data[i];
      bookedSlots.add(item);
    }
  }

  List<BookingService> generateNewBookingForUploading() {
    List<BookingService> bookingServiceList = [];

    selectedSlot.sort((a, b) => a.compareTo(b));

    List<List<int>> selectedRange = [[selectedSlot[0]]];

    for (int i = 0; i < selectedSlot.length - 1; i++) {
      selectedSlot[i] + 1 == selectedSlot[i + 1] ?
          selectedRange[selectedRange.length - 1].add(selectedSlot[i + 1]) :
              selectedRange.add([selectedSlot[i + 1]]);
    }

    for (var element in selectedRange) {
      if (element.length > 1) {
        final timeBegin = allBookingSlots.elementAt(element[0]);
        final timeEnd = allBookingSlots.elementAt(element[element.length - 1]);

        BookingService newBookingService = BookingService(
            bookingStart: timeBegin,
            bookingEnd: timeEnd
                .add(Duration(minutes: bookingService.serviceDuration)),
            serviceName: bookingService.serviceName,
            serviceDuration: bookingService.serviceDuration,
            numSeats: bookingService.numSeats
        );
        bookingServiceList.add(newBookingService);
      }
      else {
        final bookingDate = allBookingSlots.elementAt(element[0]);

        BookingService newBookingService = BookingService(
            bookingStart: bookingDate,
            bookingEnd: bookingDate
                .add(Duration(minutes: bookingService.serviceDuration)),
            serviceName: bookingService.serviceName,
            serviceDuration: bookingService.serviceDuration,
            numSeats: bookingService.numSeats
        );
        bookingServiceList.add(newBookingService);
      }
    }

    return bookingServiceList;
  }

  bool isSlotInPauseTime(DateTime slot) {
    bool result = false;
    if (pauseSlots == null) {
      return result;
    }
    for (var pauseSlot in pauseSlots!) {
      if (BookingUtil.isOverLapping(pauseSlot.start, pauseSlot.end, slot,
          slot.add(Duration(minutes: bookingService.serviceDuration)))) {
        result = true;
        break;
      }
    }
    return result;
  }
}
