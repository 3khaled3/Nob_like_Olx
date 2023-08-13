// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nob/core/utils/routes.dart';
import 'package:nob/features/home/presentation/home_view.dart';
import 'widget/CustomNavItem.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const homeView(),
    const homeView(),
    const homeView(),
    const homeView(),
    const homeView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).push(AppRouter.kaddProductView);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: CustomNavItem(
                  activeIcon: Icons.home,
                  inactiveIcon: Icons.home_outlined,
                  label: "Home",
                  isActive: _currentIndex == 0,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                ),
              ),
              Expanded(
                child: CustomNavItem(
                  activeIcon: Icons.chat,
                  inactiveIcon: Icons.chat_bubble_outline,
                  label: "CHATS",
                  isActive: _currentIndex == 1,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                ),
              ),
              const Expanded(
                  child: SizedBox()), // this will handle the fab spacing

              Expanded(
                child: CustomNavItem(
                  activeIcon: Icons.favorite_rounded,
                  inactiveIcon: Icons.favorite_border_rounded,
                  label: "MY ADS",
                  isActive: _currentIndex == 2,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                  },
                ),
              ),
              Expanded(
                child: CustomNavItem(
                  activeIcon: Icons.person_2,
                  inactiveIcon: Icons.person_2_outlined,
                  label: "ACCOUNT",
                  isActive: _currentIndex == 3,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 3;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
