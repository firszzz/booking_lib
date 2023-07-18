class GetUserBody {
  final String id;

  GetUserBody(this.id);

  Map<String, dynamic> toApi() {
    return {
      'id': id,
    };
  }
}