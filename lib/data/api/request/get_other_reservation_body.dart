class GetOtherReservationBody {
  final String id;

  GetOtherReservationBody(this.id);

  Map<String, dynamic> toApi() {
    return {
      'id': id,
    };
  }
}