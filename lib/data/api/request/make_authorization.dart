import 'package:atb_flutter_demo/resources/env.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

dynamic authorizeUser(String login, String password) async {
  String basicAuth = 'Basic ${base64Encode(utf8.encode('$login:$password'))}';

  final response = await http.get(
      Uri.parse('${AppUrls.auth}$login'),
      headers: <String, String>{'Authorization': basicAuth});

  if (response.statusCode == 200) {
    final roleChecker = await http.get(
      Uri.parse('${AppUrls.baseUrl}/role-employees/find-name-roles?employeeId=${jsonDecode(response.body)[0]['id']}'),
      headers: <String, String>{'Authorization': basicAuth},
    );

    
    
    final roleData = jsonDecode(roleChecker.body);
    bool isAdmin = false;

    for (var el in roleData) {
      if (el == 'ROLE_ADMIN') {
        isAdmin = true;
      }
    }
    
    return [jsonDecode(response.body), isAdmin];
  }
  else {
    return response.statusCode;
  }
}