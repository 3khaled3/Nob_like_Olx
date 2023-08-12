// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:nob/core/widget/customtextFaild.dart';

class priceTextFaild extends StatelessWidget {
  final dynamic Function(String)? onChanged;
  const priceTextFaild({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return customTextfaild(
      keyboardType: TextInputType.number,
      suffixIcon: const SizedBox(
        width: 20,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Text("L.E",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16)),
          ),
        ),
      ),
      onChanged: onChanged,
      labelText: "Product Price",
      validator: (value) {
        if (value!.isEmpty) {
          return "Product Price is requird ";
        }
        return null;
      },
    );
  }
}
