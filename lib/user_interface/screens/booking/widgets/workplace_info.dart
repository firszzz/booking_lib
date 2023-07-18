import 'dart:io';

import 'package:atb_flutter_demo/bloc/workplace_info/workplace_info_bloc.dart';
import 'package:atb_flutter_demo/resources/env.dart';
import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../../cubit/preferences/preferences_cubit.dart';

final List<String> imgList = [
  'https://t4.ftcdn.net/jpg/01/24/32/07/360_F_124320798_W4oetcG2UihM99jnXSA231dzDpN8Nz0j.jpg',
];

class WorkplaceInfo extends StatefulWidget {
  static var routeName = '/workplace_info';
  final List<String> imagesList;
  final String workplaceTitle;
  final String description;
  final int idWorkplace;

  const WorkplaceInfo({
    required this.imagesList,
    required this.workplaceTitle,
    required this.description,
    required this.idWorkplace,
    Key? key,
  }) : super(key: key);

  @override
  State<WorkplaceInfo> createState() => _WorkplaceInfoState();
}

class _WorkplaceInfoState extends State<WorkplaceInfo> {
  List<String> images = [];

  NetworkImage getNetworkImage(String url, String authKey) {
    Map<String, String> header = {};
    header["Authorization"] = authKey;
    return NetworkImage(url, headers: header);
  }

  @override
  void initState() {
    images = widget.imagesList;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = WorkplaceInfoBloc()..add(WorkplaceInfoLoadEvent());

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Информация о месте',
            style: AppTextStyles.appBar,
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: AppColorStyles.orangeGradient,
              ),
            ),
          ),
        ),
        body: BlocProvider<WorkplaceInfoBloc>(
          create: (context) => bloc,
          child: BlocBuilder<WorkplaceInfoBloc, WorkplaceInfoState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is WorkplaceInfoInitial) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColorStyles.atbOrange,
                  ),
                );
              }
              if (state is WorkplaceInfoLoadedState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          widget.workplaceTitle,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 50, right: 50, bottom: 40),
                      child: Center(
                        child: Text(
                          'Описание: ${widget.description}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    images.isEmpty ? SvgPicture.asset(
                      'assets/svg/booking_workplace_v2.svg',
                      height: 200,
                    ) :
                    Image(
                      image: getNetworkImage(images[0], state.basicAuth),
                      height: 400,
                    ),
                  ],
                );
              }
              return Scaffold(
                body: Center(child: Text('Something went wrong: $state')),
              );
            },
          ),
        ));
  }
}
