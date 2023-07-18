import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutMeItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData pathToIcon;

  static const double _iconSize = 30.0;

  const AboutMeItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.pathToIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Card(
        elevation: 0,
        child: ListTile(
          // tileColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).shadowColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(7),
          ),
          title: Text(
            title,
            style: AppTextStyles.aboutCardTitle,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              subtitle,
              style: AppTextStyles.aboutCardSubtitle,
            ),
          ),
          trailing: Icon(
            pathToIcon,
            size: _iconSize,
            color: AppColorStyles.secondGray,
          ),
        ),
      ),
    );
  }
}
