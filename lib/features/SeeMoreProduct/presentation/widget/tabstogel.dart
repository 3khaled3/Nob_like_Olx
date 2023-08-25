// ignore_for_file: camel_case_types

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../constant.dart';
import '../../../../routes.dart';

class tabstogel extends StatelessWidget {
  final int initial;
  const tabstogel({
    required this.initial,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late TabController tabController;
    // ignore: non_constant_identifier_names
    final List<String> Categories =
        categories.map((categoryData) => categoryData.keys.first).toList();
    List<Widget> taps = [];
    taps.add(const Tab(
      child: Tap(tap: "All"),
    ));
    for (var i = 0; i < Categories.length; i++) {
      taps.add(Tab(
        child: Tap(tap: Categories[i]),
      ));
    }

    tabController = TabController(
      length: taps.length,
      initialIndex: initial,
      vsync: Scaffold.of(context),
    );
    return DefaultTabController(
      length: taps.length,
      child: Column(
        children: <Widget>[
          ButtonsTabBar(
              controller: tabController,
              radius: 100,
              onTap: (value) {
                GoRouter.of(context).pop();
                if (value == 0) {
                  GoRouter.of(context)
                      .push(AppRouter.kallproductsView, extra: "All");
                } else {
                  GoRouter.of(context).push(AppRouter.kallproductsView,
                      extra: Categories[(value - 1)]);
                }
              },
              backgroundColor: Colors.blue,
              unselectedBackgroundColor: Colors.black,
              unselectedLabelStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              labelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              tabs: taps),
        ],
      ),
    );
  }
}

class Tap extends StatelessWidget {
  final String tap;
  const Tap({
    required this.tap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
          child: Text(
        tap,
        //  style: GoogleFonts.josefinSans(
        //       fontSize: 22.0,
        //       fontWeight: FontWeight.w800,
        //     ),
        style: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
      )),
    );
  }
}
