import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:atb_flutter_demo/user_interface/widgets/profile_clipper.dart';
import 'package:flutter/material.dart';

class ProfileSliverAppbar extends StatelessWidget {
  final Widget avatar;
  final String userName;
  final String role;

  static const double _avatarSize = 160.0;
  static const double _backgroundHeight = 270.0;
  static const Gradient _backgroundGradient = AppColorStyles.orangeGradient;

  const ProfileSliverAppbar({
    Key? key,
    required this.avatar,
    required this.userName,
    required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      pinned: true,
      expandedHeight: 350,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: [
            Stack(
              children: [
                Positioned(
                    child: ClipPath(
                      clipper: ProfileClipper(),
                      child: Container(
                        height: _backgroundHeight,
                        decoration: const BoxDecoration(
                          gradient: _backgroundGradient,
                        ),
                      ),
                    )),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: _avatarSize,
                      height: _avatarSize,
                      child: avatar,
                    ),
                  ),
                ),
              ],
            ),


            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    userName,
                    style: AppTextStyles.profileName,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 13.0),
                    child: Text(
                      role,
                      style: AppTextStyles.profileType,
                    ),
                  ),
                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}
