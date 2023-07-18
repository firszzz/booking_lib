import 'package:atb_flutter_demo/resources/app_themes.dart';
import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:flutter/material.dart';

class TextUserAvatar extends StatelessWidget {
  final String name;
  final String surname;
  final double fontSize;

  static const double _fontSize = 64.0;

  const TextUserAvatar({
    Key? key,
    required this.name,
    required this.surname,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.theme.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name.characters.first,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            surname.characters.first,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
