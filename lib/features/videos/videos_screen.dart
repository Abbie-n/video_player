import 'package:flutter/material.dart';
import 'package:video_player/shared/constants/texts.dart';
import 'package:video_player/shared/widgets/base_widget.dart';
import 'package:video_player/shared/widgets/video_preview_container.dart';
import 'package:video_player/shared/widgets/spacing.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppTexts.videos,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: const [
                  Icon(Icons.search_rounded),
                  XMargin(10),
                  Text('Search'),
                ],
              ),
            ],
          ),
          const YMargin(32),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: List.generate(
                      5,
                      (index) => const VideoPreviewContainer(
                        date: '2 days ago',
                        title: 'Dash fainted',
                        views: '50M',
                        image:
                            'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
