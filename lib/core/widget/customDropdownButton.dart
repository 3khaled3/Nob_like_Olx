// ignore_for_file: file_names

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDrob extends StatefulWidget {
  final List<String> items;
  final String titel;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  const CustomDrob(
      {super.key,
      required this.items,
      required this.titel,
      required this.onChanged,
      this.validator});

  @override
  State<CustomDrob> createState() => _CustomDrobState();
}

class _CustomDrobState extends State<CustomDrob> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2(
        buttonStyleData: const ButtonStyleData(
          height: 50,
          width: 160,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.blue,
          iconDisabledColor: Colors.blue,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          // width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          offset: const Offset(0, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.red),
          ),
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        isExpanded: true,
        hint: Row(
          children: [
            const Icon(
              Icons.list,
              size: 16,
              color: Colors.black,
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                widget.titel,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: IntrinsicWidth(
              child: Row(
                children: [
                  const Icon(
                    Icons.list,
                    size: 16,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        validator: widget.validator,
        onChanged: (String? value) {
          setState(() {
            selectedValue = value;
          });
          widget.onChanged?.call(value);
        },
        onSaved: (value) {
          selectedValue = value.toString();
        },
      ),
    );
  }
}
