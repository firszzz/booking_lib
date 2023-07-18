import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownMenu extends StatelessWidget {
  final dynamic onChanged;
  final List<dynamic> items;
  final dynamic selectedItem;

  const DropdownMenu({
    Key? key,
    required this.onChanged(dynamic selected),
    required this.items,
    required this.selectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<dynamic>(
      onChanged: onChanged,
      popupProps: const PopupProps.menu(),
      items: items,
      dropdownDecoratorProps:
      const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            filled: true,
            border: UnderlineInputBorder(
                borderSide: BorderSide.none
            )
        ),
      ),
      selectedItem: selectedItem,
    );
  }
}
