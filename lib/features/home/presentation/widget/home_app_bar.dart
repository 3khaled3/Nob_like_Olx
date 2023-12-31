import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nob/routes.dart';

import 'iconButtom.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Text("noble",
            style: GoogleFonts.lobsterTwo(fontSize: 43, color: Colors.blue)),
        const Spacer(),
        iconButtom(
          icon: Icons.search,
          onTap: () {
            GoRouter.of(context).push(AppRouter.kSearchView);
          },
        ),
      ],
    );
  }
}
