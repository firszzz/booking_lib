import 'package:atb_flutter_demo/bloc/admin_office/admin_office_bloc.dart';
import 'package:atb_flutter_demo/resources/app_themes.dart';
import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:atb_flutter_demo/user_interface/widgets/gradient_elevated_button.dart';
import 'package:atb_flutter_demo/user_interface/widgets/show_error.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

class CreateOfficeScreen extends StatefulWidget {
  static const String routeName = 'create_office';

  const CreateOfficeScreen({Key? key}) : super(key: key);

  @override
  State<CreateOfficeScreen> createState() => _CreateOfficeScreenState();
}

class _CreateOfficeScreenState extends State<CreateOfficeScreen> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _timeZoneController = TextEditingController();

  String timeBegin = '08:00';
  String timeEnd = '22:00';
  int _currentValue = 1;

  int numDay = 1;

  bool cityHasFocus = false;
  bool addressHasFocus = false;

  final adminOfficeBloc = AdminOfficeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => adminOfficeBloc,
      child: BlocBuilder<AdminOfficeBloc, AdminOfficeState>(
        bloc: adminOfficeBloc,
        builder: (context, state) {
          if (state is AdminOfficeAdding) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is AdminOfficeError) {
            return ShowError(textMessage: state.error);
          }
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text('Создать офис'),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: AppColorStyles.orangeGradient,
                ),
              ),
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Время работы офиса',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 15,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          BottomPicker.time(
                            title: "Начало работы офиса",
                            titleStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.orange),
                            pickerTextStyle: TextStyle(
                              fontSize: 18,
                              color: context.theme.primaryColor,
                            ),
                            closeIconColor: context.theme.primaryColor,
                            dismissable: true,
                            backgroundColor: context.theme.cardColor,
                            bottomPickerTheme: BottomPickerTheme.orange,
                            use24hFormat: true,
                            onSubmit: (index) {
                              setState(() {
                                timeBegin = DateFormat('kk:mm').format(index);
                              });
                            },
                          ).show(context);
                        },
                        child: Text(
                          timeBegin,
                          style: const TextStyle(fontSize: 28,
                          color: AppColorStyles.orange),
                        ),
                      ),
                      const Text(
                        '—',
                        style: TextStyle(fontSize: 28),
                      ),
                      TextButton(
                        onPressed: () {
                          BottomPicker.time(
                            title: "Начало работы офиса",
                            titleStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.orange),
                            pickerTextStyle: TextStyle(
                              fontSize: 18,
                              color: context.theme.primaryColor,
                            ),
                            closeIconColor: context.theme.primaryColor,
                            dismissable: true,
                            backgroundColor: context.theme.cardColor,
                            bottomPickerTheme: BottomPickerTheme.orange,
                            use24hFormat: true,
                            onSubmit: (index) {
                              setState(() {
                                timeEnd = DateFormat('kk:mm').format(index);
                              });
                            },
                          ).show(context);
                        },
                        child: Text(
                          timeEnd,
                          style: const TextStyle(
                              fontSize: 28,
                            color: AppColorStyles.orange
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Дистанция бронирования',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 15,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      NumberPicker(
                        value: _currentValue,
                        minValue: 1,
                        maxValue: 60,
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
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  sliver: SliverToBoxAdapter(
                    child: TextField(
                      maxLines: 1,
                      controller: _cityController,
                      decoration: InputDecoration(
                        filled: true,
                        border: const OutlineInputBorder(),
                        label: Text(
                          'Город',
                          style: TextStyle(
                              fontSize: 20,
                              color: cityHasFocus
                                  ? AppColorStyles.orange
                                  : context.theme.primaryColor),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  sliver: SliverToBoxAdapter(
                    child: TextField(
                      maxLines: 1,
                      controller: _addressController,
                      decoration: InputDecoration(
                        filled: true,
                        border: const OutlineInputBorder(),
                        label: Text(
                          'Адрес',
                          style: TextStyle(
                              fontSize: 20,
                              color: addressHasFocus
                                  ? AppColorStyles.orange
                                  : context.theme.primaryColor),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: GradientElevatedButton(
                      width: MediaQuery.of(context).size.width - 70,
                      text: 'Создать',
                      onPressed: () async {
                        BlocProvider.of<AdminOfficeBloc>(context).add(
                          CreateOfficeEvent(
                            timeBegin: timeBegin,
                            timeEnd: timeEnd,
                            access: true,
                            city: _cityController.text,
                            numDay: _currentValue,
                            address: _addressController.text,
                            timeZone: 'UTC%2B10',
                          ),
                        );

                        _cityController.text = '';
                        _addressController.text = '';

                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Офис создан успешно"),
                          duration: Duration(seconds: 2),
                        ));

                        Navigator.of(context).pop();
                      },
                      gradient: AppColorStyles.orangeGradient,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
