import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorkplaceItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String numLevel;
  final String pathToImage;

  final VoidCallback onTap;
  final VoidCallback onTapInfo;
  final VoidCallback onLongPress;

  static const double _cardWidth = double.infinity;
  static const double _shadowElevation = 1.0;
  static const double _borderRadius = 9.0;

  const WorkplaceItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.numLevel,
    required this.pathToImage,
    required this.onTap,
    required this.onTapInfo,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: _shadowElevation,
      child: GestureDetector(
        onLongPress: onLongPress,
        onTap: onTap,
        child: Container(
          width: _cardWidth,
          // height: _cardHeight,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).shadowColor,
            ),
            // color: Theme.of(context).primaryColor,
            // borderRadius: BorderRadius.circular(_borderRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.co_present),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            title,
                            style: AppTextStyles.bookingCardTitle,
                          ),
                        ),
                      ],
                    ),


                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.tap_and_play,
                            color: AppColorStyles.secondGray,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                subtitle,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bookingCardSubtitle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_city,
                            color: AppColorStyles.secondGray,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                numLevel,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bookingCardSubtitle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 15.0, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /*IconButton(
                        padding: const EdgeInsets.only(right: 5),
                        constraints: const BoxConstraints(),
                        onPressed: onTapInfo,
                        icon: const Icon(
                          Icons.info_outline,
                          size: 25,
                        ),
                      ),*/

                      SvgPicture.asset(
                        pathToImage,
                        // height: 85,
                        width: MediaQuery.of(context).size.width / 3,
                      ),
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
