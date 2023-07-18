import 'dart:io';

import 'package:atb_flutter_demo/bloc/workplace_info/workplace_info_bloc.dart';
import 'package:atb_flutter_demo/resources/env.dart';
import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class WorkplaceInfoAdmin extends StatefulWidget {
  static var routeName = '/workplace_info';
  final List<String> imagesList;
  final String workplaceTitle;
  final String description;
  final int idWorkplace;

  const WorkplaceInfoAdmin({
    required this.imagesList,
    required this.workplaceTitle,
    required this.description,
    required this.idWorkplace,
    Key? key,
  }) : super(key: key);

  @override
  State<WorkplaceInfoAdmin> createState() => _WorkplaceInfoAdminState();
}

class _WorkplaceInfoAdminState extends State<WorkplaceInfoAdmin> {
  File? image;
  final _picker = ImagePicker();
  List<String> images = [];
  bool uploaded = false;

  Future getImageGallery() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      print('no image selected');
    }
  }

  Future getImageCamera() async {
    final pickedFile =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      print('no image selected');
    }
  }

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

  Future<int> sendImage(File image, String basicAuth, int idWorkplace) async {
    var bytes = image.readAsBytesSync();

    final uri =
        Uri.parse('${AppUrls.baseUrl}/workplaces/add-image?id=$idWorkplace');
    var request = http.MultipartRequest('PATCH', uri);
    request.headers['Authorization'] = basicAuth;
    final httpImage = http.MultipartFile.fromBytes('imageFile', bytes, filename: 'imageFile.png');
    request.files.add(httpImage);
    final response = await request.send();

    return response.statusCode;
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
                    if (images.isEmpty && !uploaded)
                      SvgPicture.asset(
                        'assets/svg/booking_workplace_v2.svg',
                        height: 200,
                    ),
                    if (images.isNotEmpty)
                      Image(
                        image: getNetworkImage(images[0], state.basicAuth),
                        height: 400,
                      ),
                    if (uploaded)
                      SizedBox(
                        height: 400,
                        child: Image.file(
                          image!,
                          height: 400,
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (images.isEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (image == null)
                                const Text(
                                  'Добавить фото: ',
                                  style: TextStyle(
                                    color: AppColorStyles.atbOrange,
                                    fontSize: 18,
                                  ),
                                ),
                              const SizedBox(
                                width: 10,
                              ),
                              if (image == null && !uploaded)
                                  Row(children: [
                                      TextButton(
                                        onPressed: () {
                                          getImageGallery();
                                        },
                                        child: const Icon(
                                          Icons.photo,
                                          color: AppColorStyles.atbOrange,
                                          size: 50,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          getImageCamera();
                                        },
                                        child: const Icon(
                                          Icons.camera_alt,
                                          color: AppColorStyles.atbOrange,
                                          size: 50,
                                        ),
                                      ),
                                    ],),
                              if (!uploaded && image != null)
                                SizedBox(
                                  width: 75,
                                  child: Image.file(
                                    image!,
                                    width: 75,
                                  ),
                                ),
                              const SizedBox(
                                width: 25,
                              ),
                              if (image != null && !uploaded)
                                TextButton(
                                  onPressed: () async {
                                    var response = await sendImage(
                                      image!,
                                      state.basicAuth,
                                      widget.idWorkplace,
                                    );

                                    if (response == 200) {
                                      setState(() {
                                        uploaded = true;
                                      });

                                      final snackBar = SnackBar(
                                        content: const Text('Фото успешно добавлено'),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          textColor: AppColorStyles.orange,
                                          onPressed: () {},
                                        ),
                                      );

                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                    else {
                                      final snackBar = SnackBar(
                                        content: const Text('Что-то пошло не так. Попробуйте снова'),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          textColor: AppColorStyles.orange,
                                          onPressed: () {},
                                        ),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                  },
                                  child: const Icon(
                                    Icons.check,
                                    color: AppColorStyles.atbOrange,
                                    size: 50,
                                  ),
                                ),
                            ],
                          ),
                        ],
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
