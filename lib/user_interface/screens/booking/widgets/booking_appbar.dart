import 'package:atb_flutter_demo/cubit/preferences/preferences_cubit.dart';
import 'package:atb_flutter_demo/domain/models/floor.dart';
import 'package:atb_flutter_demo/user_interface/screens/map/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resources/styles.dart';

class BookingAppBar extends StatelessWidget with PreferredSizeWidget {
  const BookingAppBar({
    Key? key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey, super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      /*leading: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapScreen(floor: Floor.fromJson(context.read<PreferencesCubit>().state.floor)),
            ),
          );
        },
        icon: const Icon(
          Icons.map,
          size: 35,
        ),
      ),*/
      title: const Text(
        'Бронирование',
        style: TextStyle(fontSize: 24.0),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: AppColorStyles.orangeGradient,
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: const Icon(
              Icons.filter_alt,
              size: 35,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => _PreferredAppBarSize(kToolbarHeight, 7);

}

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight((toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}
