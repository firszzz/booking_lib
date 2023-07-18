import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/styles.dart';

class GradientSliverAppbar extends StatelessWidget {
  final String title;
  final Gradient gradient;

  const GradientSliverAppbar({
    Key? key,
    required this.title,
    required this.gradient
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      pinned: true,
      backgroundColor: Colors.transparent,
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: AppTextStyles.appBar,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: gradient,
          ),
        ),
      ),
    );
  }
}
