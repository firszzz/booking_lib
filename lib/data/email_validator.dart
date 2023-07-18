import 'package:email_validator/email_validator.dart';

bool validateEmail(String val) {
  if (val.isEmpty || !EmailValidator.validate(val, true)) {
    return false;
  }
  else {
    return true;
  }
}
