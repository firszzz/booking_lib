import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../resources/paths.dart';
import '../../../../resources/styles.dart';

class EventCard extends StatelessWidget {
  final String timeToStart;
  final String title;
  final String subtitle;
  final String date;
  final String time;
  final bool adminPermissionStatus;
  final VoidCallback onPressed;
  final String? info;

  static const double _elevation = 0.5;
  static const double _iconSize = 20.0;
  static const double _borderRadius = 4;
  static const double _timeToStartHeight = 32;
  static const double _timeToStartBorderRadius = 3.0;

  const EventCard({
    Key? key,
    required this.timeToStart,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.time,
    required this.adminPermissionStatus,
    required this.onPressed,
    this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: _elevation,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(_borderRadius),
            border: Border.all(
              width: 1,
              color: Theme.of(context).shadowColor,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3.2,
                  height: _timeToStartHeight,
                  decoration: BoxDecoration(
                    color: adminPermissionStatus
                        ? AppColorStyles.emerald
                        : AppColorStyles.orange,
                    borderRadius:
                        BorderRadius.circular(_timeToStartBorderRadius),
                  ),
                  child: Center(
                    child: Text(
                      timeToStart,
                      style: AppTextStyles.eventCardTimeToStart,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    title,
                    style: AppTextStyles.eventCardTitle,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTextStyles.eventCardSubtitle,
                ),
                (info == null)
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          info!,
                          style: AppTextStyles.eventCardSubtitle,
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            IconPaths.date,
                            color: Theme.of(context).primaryColor,
                            width: _iconSize,
                            height: _iconSize,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              date,
                              style: AppTextStyles.eventCardDateAndClock,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            IconPaths.clock,
                            color: Theme.of(context).primaryColor,
                            width: _iconSize,
                            height: _iconSize,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              time,
                              style: AppTextStyles.eventCardDateAndClock,
                            ),
                          )
                        ],
                      )
                    ],
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
