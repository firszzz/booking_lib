import 'package:atb_flutter_demo/bloc/admin_office/admin_office_bloc.dart';
import 'package:atb_flutter_demo/bloc/admin_workplace/admin_workplace_bloc.dart';
import 'package:atb_flutter_demo/bloc/office_workplaces/office_workplaces_bloc.dart';
import 'package:atb_flutter_demo/domain/models/floor.dart';
import 'package:atb_flutter_demo/resources/app_themes.dart';
import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../widgets/gradient_elevated_button.dart';
import '../../widgets/show_error.dart';

class CreateWorkplace extends StatefulWidget {
  final OfficeWorkplacesBloc bloc;

  final int ifOffice;
  final List<Floor> floors;

  static const String routeName = 'create_workplace_screen';

  const CreateWorkplace({
    Key? key,
    required this.bloc,
    required this.ifOffice,
    required this.floors,
  }) : super(key: key);

  @override
  State<CreateWorkplace> createState() => _CreateWorkplaceState();
}

class _CreateWorkplaceState extends State<CreateWorkplace> {
  final TextEditingController _infoController = TextEditingController();
  final TextEditingController _numLevelController = TextEditingController();
  final TextEditingController _numSeatsController = TextEditingController();


  bool type = false;
  int _currentValue = 1;
  int _currentFloorLevelValue = 1;
  Floor selectedFloor = Floor(id: 1, officeId: 1, floorNumber: 1, mapImage: '');
  bool hasFocus1 = false;

  final adminWorkplaceBloc = AdminWorkplaceBloc();

  @override
  Widget build(BuildContext context) {
    // List<Floor> floorsData = context.select((OfficeWorkplacesBloc bloc) => bloc.floors);

    return BlocProvider(
      create: (context) => adminWorkplaceBloc,
      child: BlocBuilder<AdminWorkplaceBloc, AdminWorkplaceState>(
        bloc: adminWorkplaceBloc,
        builder: (context, state) {
          if (state is AdminWorkplaceAdding) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is AdminWorkplaceError) {
            return ShowError(textMessage: state.error);
          }
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text('Создать место'),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: AppColorStyles.orangeGradient,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Выберите этаж',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline6,
                      ),
                      const SizedBox(height: 15,),
                      NumberPicker(
                        value: _currentFloorLevelValue,
                        minValue: 1,
                        maxValue: 30,
                        step: 1,
                        itemHeight: 100,
                        axis: Axis.horizontal,
                        onChanged: (value) =>
                            setState(() => _currentFloorLevelValue = value),
                        selectedTextStyle: const TextStyle(
                            color: AppColorStyles.orange, fontSize: 28),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: context.theme.primaryColor),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Количество мест',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline6,
                      ),
                      const SizedBox(height: 15,),
                      NumberPicker(
                        value: _currentValue,
                        minValue: 1,
                        maxValue: 30,
                        step: 1,
                        itemHeight: 100,
                        axis: Axis.horizontal,
                        onChanged: (value) =>
                            setState(() => _currentValue = value),
                        selectedTextStyle: const TextStyle(
                            color: AppColorStyles.orange, fontSize: 28),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: context.theme.primaryColor),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Тип места',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline6,
                      ),
                      const SizedBox(height: 15,),
                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: DropdownSearch<String>(
                          onChanged: (selected) {
                            setState(() {
                              (selected == 'Рабочее место')
                                  ? type = false
                                  : type = true;
                            });
                          },
                          popupProps: const PopupProps.menu(),
                          items: const ['Рабочее место', 'Переговорная'],
                          dropdownDecoratorProps:
                          const DropDownDecoratorProps(
                            textAlignVertical: TextAlignVertical.center,
                            baseStyle: TextStyle(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                            dropdownSearchDecoration: InputDecoration(
                                filled: true,
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                          selectedItem:
                          (type == false)
                              ? 'Рабочее место'
                              : 'Переговорная',
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextField(
                      controller: _infoController,
                      maxLines: 7,
                      decoration: InputDecoration(
                        filled: true,
                        // fillColor: AppColorStyles.white,
                        border: const OutlineInputBorder(),
                        labelText: 'Информация о месте',
                        labelStyle: TextStyle(
                            fontSize: 20,
                            color: hasFocus1 ? AppColorStyles.orange : context
                                .theme.primaryColor
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide(
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),

                  GradientElevatedButton(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 70,
                    text: 'Создать',
                    onPressed: () async {
                      adminWorkplaceBloc.add(
                          CreateWorkplaceEvent(
                            type: type,
                            seatsCount: _currentValue,
                            floorNumber: _currentFloorLevelValue,
                            // floorId: selectedFloor.id,
                            info: _infoController.text,
                            officeId: widget.ifOffice,
                          )
                      );

                      _infoController.text = '';

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Место создано успешно"),
                            duration: Duration(seconds: 2),
                          ));

                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    gradient: AppColorStyles.orangeGradient,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
