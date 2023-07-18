class GetReservationBody {
  final String id;

  GetReservationBody(this.id);

  Map<String, dynamic> toApi() {
    return {
      'id': id,
    };
  }
}