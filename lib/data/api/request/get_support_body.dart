class GetSupportBody {
  final String status;

  GetSupportBody(this.status);

  Map<String, dynamic> toApi() {
    return {
      'status': status,
    };
  }
}