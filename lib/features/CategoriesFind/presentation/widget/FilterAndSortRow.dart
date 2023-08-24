// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nob/core/widget/bottom_sheet.dart';

import 'FilterBottomsheetview.dart';

class FilterAndSortRow extends StatelessWidget {
  const FilterAndSortRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 20, bottom: 10),
            child: GestureDetector(
              onTap: () {
                showbottomSheet(
                    context: context, widget: const filterBottomSheetView());
              },
              child: const Row(
                children: [
                  Icon(Icons.filter_list, color: Colors.black),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Filters",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 11)),
                  )
                ],
              ),
            ),
          ),
        ]),
        const Divider(
          height: .1,
          thickness: 1,
          indent: 0,
          endIndent: 0,
        ),
        const SizedBox(
          height: 4,
        )
      ],
    );
  }
}
