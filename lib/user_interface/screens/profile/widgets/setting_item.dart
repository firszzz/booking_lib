import 'package:atb_flutter_demo/resources/app_themes.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final IconData icons;
  final IconStyle? iconStyle;
  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final Widget? trailing;
  final VoidCallback onTap;
  final double borderRadius;

  static const double _iconSize = 27.0;

  const SettingsItem({
    super.key,
    required this.icons,
    this.iconStyle,
    required this.title,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.trailing,
    required this.onTap,
    this.borderRadius = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
      child: Card(
        elevation: 0.5,
        margin: EdgeInsets.zero,
        child: ListTile(
          tileColor: Theme.of(context).cardColor,

          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: context.theme.shadowColor,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          onTap: onTap,
          leading: (iconStyle != null && iconStyle!.withBackground!)
              ? Container(
                  decoration: BoxDecoration(
                    color: iconStyle!.backgroundColor,
                    borderRadius: BorderRadius.circular(iconStyle!.borderRadius!),
                  ),
                  padding: EdgeInsets.all(7),
                  child: Icon(
                    icons,
                    size: _iconSize,
                    color: iconStyle!.iconsColor,
                  ),
                )
              : Icon(
                  icons,
                  size: _iconSize,
                ),
          title: Text(
            title,
            style: titleStyle ?? const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
          ),
          subtitle: (subtitle != null)
              ? Text(
                  subtitle!,
                  style: subtitleStyle ?? TextStyle(/*color: Colors.grey[700]*/),
                  maxLines: 1,
                )
              : null,
          trailing: trailing ?? const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ),
    );
  }
}

class IconStyle {
  Color? iconsColor;
  bool? withBackground;
  Color? backgroundColor;
  double? borderRadius;

  IconStyle({
    iconsColor = Colors.white,
    withBackground = true,
    backgroundColor = Colors.blue,
    borderRadius = 8,
  })  : this.iconsColor = iconsColor,
        this.withBackground = withBackground,
        this.backgroundColor = backgroundColor,
        this.borderRadius = double.parse(borderRadius!.toString());
}
