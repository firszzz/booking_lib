class GetBookingBody {
  final String id;

  GetBookingBody(this.id);

  Map<String, dynamic> toApi() {
    return {
      'id': id,
    };
  }
}