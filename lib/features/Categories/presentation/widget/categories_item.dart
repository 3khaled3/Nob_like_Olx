import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes.dart';

class CategoriesItem extends StatelessWidget {
  final String image;
  final String title;

  const CategoriesItem(
      {super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.kallproductsView, extra: title);
      },
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                height: 100,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
