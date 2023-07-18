import 'package:flutter/material.dart';

import '../../../../cubit/preferences/preferences_cubit.dart';
import '../../../../resources/styles.dart';

class RestoreButton extends StatelessWidget {
  const RestoreButton({
    Key? key,
    required this.prefCubit,
  }) : super(key: key);

  final PreferencesCubit prefCubit;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Подтверждение"),
              content: const Text(
                  "Вы уверены что хотите сбросить все настройки?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    prefCubit.deleteAllPreferences.call();
                  },
                  child: const Text("Да", style: TextStyle(color: AppColorStyles.atbOrange)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Нет", style: TextStyle(color: AppColorStyles.atbOrange)),
                ),
              ],
            );
          },
        );
      },
      icon: const Icon(Icons.restore),
    );
  }
}
