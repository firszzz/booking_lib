import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../resources/styles.dart';

class InstructionsScreen extends StatefulWidget {
  static const String routeName = '/instructions';
  const InstructionsScreen({Key? key}) : super(key: key);

  @override
  State<InstructionsScreen> createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Инструкции'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColorStyles.orangeGradient,
          ),
        ),
      ),
      body: SfPdfViewer.asset(
        'assets/pdf/new_employee.pdf',
      ),
    );
  }
}
