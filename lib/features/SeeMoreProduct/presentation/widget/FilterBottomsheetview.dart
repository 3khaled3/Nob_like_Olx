// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/widget/CustomElvationBottom.dart';

// ignore: camel_case_types
class filterBottomSheetView extends StatelessWidget {
  const filterBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    RangeValues currentRangeValues = const RangeValues(10, 1000);
    var f = NumberFormat("#####", "en_US");
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(40)),
              width: 60,
              height: 6,
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Text(
            "Price range",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                f.format(currentRangeValues.start),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Text(
                f.format(currentRangeValues.end),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        RangeSlider(
          activeColor: Colors.red,
          inactiveColor: Colors.grey,
          values: currentRangeValues,
          min: 10,
          max: 1000,
          // divisions: 10,
          labels: RangeLabels(
            currentRangeValues.start.toString(),
            currentRangeValues.end.toString(),
          ),
          onChanged: (RangeValues values) {
            currentRangeValues = values;
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: customElevationButtom(
                  text: "Discard",
                  onPressed: () {},
                  buttomColor: const Color.fromARGB(255, 218, 218, 218),
                  textColor: Colors.black,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child:
                      customElevationButtom(text: "Apply", onPressed: () {})),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
