import 'dart:io';

import 'package:atb_flutter_demo/bloc/map/map_bloc.dart';
import 'package:atb_flutter_demo/cubit/preferences/preferences_cubit.dart';
import 'package:atb_flutter_demo/resources/env.dart';
import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:atb_flutter_demo/user_interface/widgets/show_error.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../domain/models/floor.dart';
import '../../../domain/models/office.dart';
import 'package:http_parser/http_parser.dart';
import '../../../resources/assets.dart';

class MapAdminScreen extends StatefulWidget {
  final int officeId;
  final String mapImage;
  final Floor floor;

  static String routeName = '/map_screen';

  const MapAdminScreen({
    Key? key,
    required this.officeId,
    required this.mapImage,
    required this.floor,
  }) : super(key: key);

  @override
  State<MapAdminScreen> createState() => _MapAdminScreenState();
}

class _MapAdminScreenState extends State<MapAdminScreen> {
  Floor selectedFloor = Floor(id: 1, officeId: 1, floorNumber: 1, mapImage: '');

  NetworkImage getNetworkImage(String url, String authKey) {
    Map<String, String> header = {};
    header["Authorization"] = authKey;
    return NetworkImage(url, headers: header);
  }

  File? image;
  final _picker = ImagePicker();
  String mapImage = '';

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
      setState(() {
        image = File(pickedFile.path);
      });
    } else {
      print('no image selected');
    }
  }

  @override
  void initState() {
    mapImage = widget.mapImage;
    selectedFloor = widget.floor;
    super.initState();
  }

  Future<int> sendImage(File image, String basicAuth, int floorId) async {
    var bytes = image.readAsBytesSync();
    final uri = Uri.parse('${AppUrls.baseUrl}/floors/add-map?id=$floorId');
    var request = http.MultipartRequest('PATCH', uri);
    request.headers['Authorization'] = basicAuth;
    request.headers['Content-type'] = 'multipart/form-data';
    final httpImage = http.MultipartFile.fromBytes('imageFile', bytes, filename: 'imageFile.png');
    request.files.add(httpImage);
    final response = await request.send();
    print(response.statusCode);

    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    final preferencesCubit = context.read<PreferencesCubit>();

    final bloc = MapBloc()
      ..add(LoadMapEvent(
        officeId: widget.officeId,
      ));
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Карты этажей'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppColorStyles.orangeGradient,
            ),
          ),
        ),
        // backgroundColor: Colors.white,
        body: BlocBuilder<MapBloc, MapState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is MapLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MapLoadedState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: DropdownSearch<Floor>(
                      onChanged: (selected) {
                        setState(() {
                          selectedFloor = selected!;
                        });
                      },
                      popupProps: const PopupProps.menu(),
                      items: state.floors,
                      itemAsString: (Floor u) => u.floorNumber.toString(),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        textAlignVertical: TextAlignVertical.center,
                        baseStyle: TextStyle(
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                        ),
                        dropdownSearchDecoration: InputDecoration(
                            prefix: Text('Этаж '),
                            filled: true,
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                      selectedItem: selectedFloor,
                    ),
                  ),
                  (selectedFloor.mapImage == '')
                      ? Column(
                    children: [
                      SvgPicture.asset(
                        AppSvgAssets.map,
                        height: MediaQuery.of(context).size.height / 4,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Карта отсутствует',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  )
                      : Image(
                    image: getNetworkImage(
                        '${AppUrls.baseUrl}/images/${selectedFloor.mapImage}',
                        state.basicAuth),
                    height: 400,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (selectedFloor.mapImage != '')
                        const Text(
                          'Изменить фото: ',
                          style: TextStyle(
                            color: AppColorStyles.atbOrange,
                            fontSize: 18,
                          ),
                        ),
                        if (image == null && selectedFloor.mapImage == '')
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
                      image == null
                          ? Row(children: [
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
                      ],)
                          : SizedBox(
                        width: 75,
                        child: Image.file(
                          image!,
                          width: 75,
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      if (image != null)
                        TextButton(
                          onPressed: () async {
                            var response = await sendImage(
                              image!,
                              state.basicAuth,
                              selectedFloor.id,
                            );

                            if (response == 200) {
                              final snackBar = SnackBar(
                                content: const Text('Запрос успешно выполнен'),
                                action: SnackBarAction(
                                  label: 'OK',
                                  textColor: AppColorStyles.orange,
                                  onPressed: () {},
                                ),
                              );

                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              Navigator.pop(context);
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
                  )
                ],
              );
            } else if (state is MapErrorState) {
              return ShowError(textMessage: state.error);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
