import 'package:flutter/material.dart';
import 'package:nob/features/Favorite/presentation/widget/fav_app_bar.dart';
import 'package:nob/features/Favorite/presentation/widget/fav_builder.dart';


class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [const FavAppBar(), FavBuilder()],
        ),
      ),
    );
  }
}
