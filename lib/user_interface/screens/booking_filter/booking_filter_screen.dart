import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:atb_flutter_demo/user_interface/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';

class BookingFilterScreen extends StatelessWidget {
  const BookingFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_back_sharp),
                        color: AppColorStyles.secondGray,
                      ),
                      const Text(
                        'Фильтры',
                        style: AppTextStyles.filterTitle,
                      )
                    ],
                  ),

                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Сбросить всё',
                        style: AppTextStyles.filterResetAllButton,
                      ),
                  ),
                ],
              ),
            ),

            const Text('Coming soon.... maybe'),

            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: GradientElevatedButton(
                  text: 'Применить',
                  onPressed: () {},
                  gradient: AppColorStyles.orangeGradient,
                  width: 345,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
