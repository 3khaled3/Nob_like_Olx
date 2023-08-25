import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:nob/routes.dart';

import '../../../../core/utils/indicator.dart';

class BuildSendMassegeBuble extends StatelessWidget {
  final String containt;
  final type;
  final String time;
  final bool seen;
  const BuildSendMassegeBuble({
    super.key,
    required this.containt,
    required this.seen,
    required this.time,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          height: 4,
        ),
        type == "File"
            ? BubbleNormalImage(
                onTap: () {
                  GoRouter.of(context)
                      .push(AppRouter.kimageviewscreen, extra: containt);
                },
                sent: true,
                seen: seen,
                id: 'id001',
                image: CachedNetworkImage(
                    imageUrl: containt,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            buildCircleIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover),
                color: const Color(0xFF1B97F3),
                tail: true,
                delivered: true,
              )
            : BubbleSpecialThree(
                sent: true,
                seen: seen,
                text: containt,
                color: const Color(0xFF1B97F3),
                tail: false,
                textStyle: const TextStyle(color: Colors.white, fontSize: 16),
              ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Text(
            time,
            style: const TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ),
      ],
    );
  }
}

class BuildResiveMassegeBuble extends StatelessWidget {
  final String containt;
  final String time;
  final type;
  const BuildResiveMassegeBuble({
    super.key,
    required this.containt,
    required this.time,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 4,
        ),
        type == "File"
            ? BubbleNormalImage(
                sent: false,
                seen: false,
                onTap: () {
                  GoRouter.of(context)
                      .push(AppRouter.kimageviewscreen, extra: containt);
                },
                isSender: false,
                id: 'id1',
                image: CachedNetworkImage(
                    imageUrl: containt,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            buildCircleIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover),
                color: Colors.grey[350]!,
                tail: true,
                delivered: true,
              )
            : BubbleSpecialThree(
                text: containt,
                color: Colors.grey[350]!,
                tail: false,
                isSender: false,
              ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Text(
            time,
            style: const TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ),
      ],
    );
  }
}

class ImageViewScreen extends StatelessWidget {
  final String url;
  const ImageViewScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text('Image View'),
        backgroundColor: Colors.black87,
        // systemOverlayStyle: SystemUiOverlayStyle(
        //   systemNavigationBarColor: Colors.black, // Navigation bar
        //   statusBarColor: Colors.black, // Status bar
        // ),
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: url,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              buildCircleIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
