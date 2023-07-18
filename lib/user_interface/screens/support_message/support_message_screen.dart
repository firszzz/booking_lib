import 'package:atb_flutter_demo/resources/app_themes.dart';
import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:atb_flutter_demo/user_interface/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../internal/dependencies/repository_module.dart';

class SupportMessageScreen extends StatefulWidget {
  static String routeName = '/support_message_screen';

  const SupportMessageScreen({Key? key}) : super(key: key);

  @override
  State<SupportMessageScreen> createState() => _SupportMessageScreenState();
}

class _SupportMessageScreenState extends State<SupportMessageScreen> {
  var supportRepository = RepositoryModule.supportRepository();
  String topic = '';
  String textMessage = '';
  bool hasFocus1 = false;
  bool hasFocus2 = false;

  @override
  Widget build(BuildContext context) {
    var controller;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Обратиться в поддержку',
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: SvgPicture.asset(
                    'assets/svg/feedback.svg',
                    height: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 35),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: Focus(
                          onFocusChange: (val) {
                            setState(() {
                              hasFocus1 = val;
                            });
                          },
                          child: TextField(
                            maxLines: 1,
                            controller: controller,
                            // style: AppTextStyles.supportMessageTitleTextField,
                            decoration: InputDecoration(
                              filled: true,
                              // fillColor: Theme.of(context).primaryColorLight,
                              border: const OutlineInputBorder(),
                              label: Text(
                                'Тема обращения',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: hasFocus1 ? AppColorStyles.orange : context.theme.primaryColor
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  borderSide: BorderSide(
                                    width: 2,
                                  )),
                            ),
                            onChanged: (val) {
                              setState(() {
                                topic = val;
                              });
                            },
                          ),
                        ),
                      ),
                      Focus(
                        onFocusChange: (val) {
                          setState(() {
                            hasFocus2 = val;
                          });
                        },
                        child: TextField(
                          maxLines: 9,
                          decoration: InputDecoration(
                            filled: true,
                            // fillColor: AppColorStyles.white,
                            border: const OutlineInputBorder(),
                            labelText: 'Сообщение в поддержку',
                            labelStyle: TextStyle(
                              fontSize: 20,
                              color: hasFocus2 ? AppColorStyles.orange : context.theme.primaryColor
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
                          onChanged: (val) {
                            setState(() {
                              textMessage = val;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: Text(
                            'Дата обращения: ${DateFormat('dd-MM-yyyy').format(DateTime.now()).toString()}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: GradientElevatedButton(
                    width: 330,
                    text: 'Отправить',
                    onPressed: () {
                      if (topic.isNotEmpty &&
                          textMessage.isNotEmpty &&
                          (topic.length <= 255)) {
                        supportRepository.sendSupportMessage(
                            topic: topic, textMessage: textMessage);
                        final snackBar = SnackBar(
                          content: const Text('Обращение успешно отправлено'),
                          action: SnackBarAction(
                            label: 'OK',
                            textColor: AppColorStyles.orange,
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                      } else {
                        final snackBar = SnackBar(
                          content: const Text(
                              'Что-то не так! Проверьте правильность введеных данных'),
                          action: SnackBarAction(
                            label: 'OK',
                            textColor: AppColorStyles.orange,
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    gradient: AppColorStyles.orangeGradient,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
