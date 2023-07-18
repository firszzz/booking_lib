class SupportMessage {
  int id;
  String topic;
  String textMessage;
  String statusMessage;
  int employeeId;

  SupportMessage({
    required this.id,
    required this.topic,
    required this.textMessage,
    required this.statusMessage,
    required this.employeeId
  });

  SupportMessage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        topic = json['topic'],
        textMessage = json['textMessage'],
        statusMessage = json['statusMessage'],
        employeeId = json['employeeId'];
}
