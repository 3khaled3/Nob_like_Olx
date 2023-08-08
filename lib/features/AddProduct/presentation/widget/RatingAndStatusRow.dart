import 'package:flutter/material.dart';
import 'package:nob/mmmm.dart';

class ratingAndStatusRow extends StatelessWidget {
  const ratingAndStatusRow({
    super.key,
    required this.rateing,
    required this.status,
  });

  final List<String> rateing;
  final List<String> status;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0, left: 5),
              child: Text("rateing",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
            ),
            CustomDrob(
              items: rateing,
              titel: "rateing",
              onChanged: (p0) {},
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0, left: 5),
              child: Text("status",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
            ),
            CustomDrob(
              items: status,
              titel: "status",
              onChanged: (p0) {},
            ),
          ],
        ),
      ],
    );
  }
}
