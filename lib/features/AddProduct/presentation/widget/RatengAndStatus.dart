
// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';

import '../../../../core/widget/customDropdownButton.dart';

class RateingAndStatus extends StatelessWidget {
  final void Function(String?)? RatingonChanged;
  final void Function(String?)? StatusonChanged;
  const RateingAndStatus({
    super.key,
    required this.RatingonChanged,
    required this.StatusonChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> rateing =
        List.generate(10, (index) => '${index + 1} / 10');
    final List<String> status = ["New", "Used"];
    return Row(
      children: [
        Expanded(
          child: CustomDrob(
            items: rateing,
            titel: "rateing",
            onChanged: RatingonChanged,
            validator: (value) {
              if (value == null) {
                return "please  Select rateing ";
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: CustomDrob(
            items: status,
            titel: "status",
            onChanged: StatusonChanged,
            validator: (value) {
              if (value == null) {
                return "please  Select rateing ";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
