import 'package:atb_flutter_demo/resources/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../resources/paths.dart';
import '../../../../resources/styles.dart';

class LocationItem extends StatelessWidget {
  final String idOffice;
  final String timeWork;
  final String address;
  final VoidCallback onTap;

  const LocationItem({
    Key? key,
    required this.idOffice,
    required this.timeWork,
    required this.address,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: GestureDetector (
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              width: 1,
              color: Theme.of(context).shadowColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    idOffice,
                    style: const TextStyle(
                      // color: AppColorStyles.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_outlined,
                        color: AppColorStyles.secondGray,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        timeWork,
                        style: const TextStyle(
                          color: AppColorStyles.secondGray,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          address,
                          style: AppTextStyles.eventCardDateAndClock,
                        ),
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
