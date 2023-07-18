import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/styles.dart';

class ShowError extends StatelessWidget {
  final String textMessage;
  const ShowError({
    Key? key,
    required this.textMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            textMessage,
            style: AppTextStyles.errorMessage,
          ),
        ),
      ),
    );
  }
}
