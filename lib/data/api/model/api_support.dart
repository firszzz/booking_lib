class ApiSupport {
  final int id;
  final String topic;
  final String textMessage;
  final String statusMessage;
  final int employeeId;

  ApiSupport.fromApi(Map<String, dynamic> map)
      : id = map['id'],
        topic = map['topic'],
        textMessage = map['textMessage'],
        statusMessage = map['statusMessage'],
        employeeId = map['employeeId'];
}