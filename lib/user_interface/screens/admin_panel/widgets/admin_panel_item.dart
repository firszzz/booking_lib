import 'package:atb_flutter_demo/resources/app_themes.dart';
import 'package:flutter/material.dart';

import '../../../../resources/styles.dart';

class AdminPanelItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const AdminPanelItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 150,
          decoration: BoxDecoration(
              color: context.theme.cardColor,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                width: 1,
                color: Theme.of(context).shadowColor,
              ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 30.0, left: 15, right: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: AppColorStyles.orange,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
