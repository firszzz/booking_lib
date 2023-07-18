import 'package:atb_flutter_demo/bloc/support/support_bloc.dart';
import 'package:atb_flutter_demo/domain/models/support_message.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../resources/styles.dart';

final List<String> _states = ["Активные", "В процессе", "Завершенные"];
final Map<String, String> _statesMap = {
  "Активные": "active",
  "В процессе": "processed",
  "Завершенные": "finished"
};

class SupportScreen extends StatefulWidget {
  static const String routeName = 'support';
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    final bloc = SupportBloc()..add(LoadSupportEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поддержка'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColorStyles.orangeGradient,
          ),
        ),
      ),
      body: BlocProvider<SupportBloc>(
        create: (context) => bloc,
        child: BlocBuilder<SupportBloc, SupportState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is SupportLoadingState) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color: Colors.deepOrange),
                ),
              );
            }
            if (state is SupportLoadedState) {
              final List<SupportMessage> listMessages = state.listMessages;
              var selected = _states[0];
              String status = 'active';

              if (listMessages.isNotEmpty) {

                return Scaffold(
                  body: SafeArea(
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      slivers: [
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: DropdownSearch<dynamic>(
                              onChanged: (val) {
                                selected = val;
                                bloc.add(ChangeSupportEvent(_statesMap[val]!));
                              },
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
                              popupProps: const PopupProps.menu(),
                              items: _states,
                              selectedItem: _statesMap.keys.firstWhere((element) => _statesMap[element] == status),
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Card(
                                    elevation: 2.0,
                                    margin: EdgeInsets.zero,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 50,
                                                child: Text(
                                                  listMessages[index].id.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 200,
                                                child: Text(
                                                  listMessages[index].topic,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.right,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            listMessages[index].textMessage,
                                            maxLines: 3,
                                            style: const TextStyle(fontSize: 16),
                                            textAlign: TextAlign.start,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  String currentStatus =
                                                  _statesMap.keys.firstWhere((element) => _statesMap[element] == listMessages[index].statusMessage);
                                                  List<String> allStates = ["Активные", "В процессе", "Завершенные"];
                                                  allStates.remove(currentStatus);
                                                  List<String> listStates = allStates;
                                                  String selectedStatus = listStates[0];

                                                  showDialog<void>(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text('Изменение статуса сообщения в поддержку', textAlign: TextAlign.start,),
                                                        content: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Text('${listMessages[index].id}. ${listMessages[index].topic}', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              listMessages[index].textMessage, style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16),),
                                                          ],
                                                        ),
                                                        actions: <Widget>[
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                DropdownSearch<dynamic>(
                                                                  onChanged: (val) {
                                                                    selectedStatus = val;
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                    dropdownSearchDecoration: InputDecoration(
                                                                      filled: true,
                                                                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                                                                    ),
                                                                  ),
                                                                  popupProps: const PopupProps.menu(),
                                                                  items: listStates,
                                                                  selectedItem: selectedStatus,
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                SizedBox(
                                                                  width: double.infinity,
                                                                  height: 50,
                                                                  child: TextButton(
                                                                    style: TextButton.styleFrom(
                                                                      textStyle: Theme.of(context).textTheme.labelLarge,
                                                                    ),
                                                                    child: const Text('Изменить статус', style: TextStyle(color: AppColorStyles.atbOrange),),
                                                                    onPressed: () async {
                                                                      bloc.add(ChangeStatusEvent(listMessages[index].id, _statesMap[selectedStatus]!));
                                                                      await Future.delayed(const Duration(milliseconds: 50));
                                                                      setState(() {
                                                                        listMessages.remove(listMessages[index]);
                                                                        Navigator.of(context).pop();
                                                                      });
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: const Text('Изменить статус', style: TextStyle(color: AppColorStyles.atbOrange),),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }, childCount: state.listMessages.length),
                        )
                      ],
                    ),
                  ),
                );
              }
              else {
                return Scaffold(
                  body: SafeArea(
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      slivers: [
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: DropdownSearch<dynamic>(
                              onChanged: (val) {
                                selected = val;
                                bloc.add(ChangeSupportEvent(_statesMap[val]!));
                              },
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
                              popupProps: const PopupProps.menu(),
                              items: _states,
                              selectedItem: selected,
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 100,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Center(
                                child: Text('Нет сообщений в поддержку с этим статусом', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center,),
                              ),
                            )
                          )
                        )
                      ],
                    ),
                  ),
                );
              }
            }
            return Scaffold(
              body: Center(child: Text('Something went wrong: $state')),
            );
          },
        ),
      ),
    );
  }
}