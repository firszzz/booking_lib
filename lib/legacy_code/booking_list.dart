/*
import 'package:atb_flutter_demo/bloc/workplace/workplace_bloc.dart';
import 'package:atb_flutter_demo/user_interface/screens/booking_picker/booking_picker_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/map/map_screen.dart';
import 'package:atb_flutter_demo/user_interface/widgets/show_error.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:table_calendar/table_calendar.dart';

import '../resources/styles.dart';
import '../user_interface/screens/booking/widgets/workplace_item.dart';

class BookingList extends StatefulWidget {
  const BookingList({Key? key}) : super(key: key);

  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  CalendarFormat format = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();


  @override
  Widget build(BuildContext context) {
    // final workplaceRepository = RepositoryModule.workplaceRepository();
    final bloc = WorkplaceBloc(*/
/*workplaceRepository*//*
)
      ..add(LoadWorkplaceEvent());
    return BlocProvider<WorkplaceBloc>(
      create: (context) => bloc,
      child: Scaffold(
        body: BlocBuilder<WorkplaceBloc, WorkplaceState>(
          builder: (context, state) {
            if (state is WorkplaceLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is WorkplaceLoadedState) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  SliverAppBar(
                    elevation: 0,
                    pinned: true,
                    expandedHeight: 90,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: const BoxDecoration(
                          gradient: AppColorStyles.orangeGradient,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15.0, left: 10.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 280,
                                child: DropdownSearch<String>(
                                  popupProps: PopupProps.modalBottomSheet(
                                      title: const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          'Выберите этаж',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      // showSearchBox: true,
                                      */
/*bottomSheetProps: BottomSheetProps(
                                      elevation: 10.0,
                                      // backgroundColor: AppColorStyles.mainGray,
                                    ),*//*

                                      modalBottomSheetProps:
                                          ModalBottomSheetProps(
                                        backgroundColor:
                                            Theme.of(context).primaryColorDark,
                                      )),
                                  items: List.generate(
                                      1, (index) => 'Этаж ${index + 1}'),
                                  selectedItem: 'Этаж 1',
                                  dropdownDecoratorProps:
                                  DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      // labelText: 'Выберите офис',
                                      filled: true,
                                      fillColor: Theme.of(context).primaryColorLight,
                                      // fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(9),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, MapScreen.routeName);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 5),
                                  child: Text('Карта'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  CupertinoSliverRefreshControl(
                    onRefresh: () async {
                      // await Future.delayed(Duration(seconds: 2));
                      bloc.add(RefreshWorkplaceEvent());
                    },
                  ),
                  */
/*SliverToBoxAdapter(
                    child: TableCalendar(
                      focusedDay: focusedDay,
                      firstDay: DateTime.now(),
                      lastDay: DateTime(2024),
                      calendarFormat: format,
                      onFormatChanged: (CalendarFormat _format) {
                        setState(() {
                          format = _format;
                        });
                      },
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      daysOfWeekVisible: true,
                      onDaySelected: (DateTime selectDay, DateTime focusDay) {
                        setState(() {
                          selectedDay = selectDay;
                          focusedDay = focusDay;
                        });
                      },
                      calendarStyle: const CalendarStyle(
                          isTodayHighlighted: true,
                          todayDecoration: BoxDecoration(
                            color: Color.fromRGBO(255, 152, 0, 0.5),
                            shape: BoxShape.circle,
                          ),
                          todayTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Color.fromRGBO(255, 152, 0, 1),
                            shape: BoxShape.circle,
                          ),
                          selectedTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          )),
                      selectedDayPredicate: (DateTime date) {
                        return isSameDay(selectedDay, date);
                      },
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        formatButtonShowsNext: false,
                      ),
                    ),
                  ),*//*


                  */
/*SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownSearch<String>(
                              popupProps: const PopupProps.menu(),
                              items: const ['Переговорка', 'Рабочее'],
                              dropdownDecoratorProps: const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  label: Text('Тип места'),
                                ),
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.symmetric(horizontal: 4.0)),
                          Expanded(
                              child: DropdownSearch<String>(
                                popupProps: const PopupProps.menu(),
                                items: List.generate(10, (index) => 'Этаж $index'),
                                dropdownDecoratorProps: const DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text('Этаж'),
                                  ),
                                ),
                              )),
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0)),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColorStyles.secondGray,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: IconButton(
                                onPressed: () {},
                                color: AppColorStyles.secondGray,
                                icon: SvgPicture.asset('assets/svg/burger_menu.svg'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),*//*


                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 7),
                          child: WorkplaceItem(
                            title: 'Рабочее место ${state.workplaces[index].id}',
                            subtitle: state.workplaces[index].info,
                            onTap: () async {
                              const storage = FlutterSecureStorage();
                              storage.write(
                                  key: 'idWorkPlace',
                                  value: state.workplaces[index].id.toString());

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const BookingBlocScreen()));
                            },
                            onTapInfo: () {}, onLongPress: () {  },
                          ),
                        );
                      },
                      childCount: state.workplaces.length,
                    ),
                  ),
                ],
              );
            }
            if (state is WorkplaceEmptyState) {
              return const Center(
                child: Text(
                  'Места не созданы',
                  style: AppTextStyles.homeEmptyStateMessage,
                ),
              );
            }
            if (state is WorkplaceErrorState) {
              return ShowError(textMessage: state.error);
            }
            return ShowError(textMessage: state.toString());
          },
        ),
      ),
    );
  }
}
*/
