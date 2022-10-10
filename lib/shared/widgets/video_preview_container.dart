import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:video_player_app/shared/constants/colors.dart';
import 'package:video_player_app/shared/widgets/spacing.dart';

class VideoPreviewContainer extends StatelessWidget {
  final String title;
  final String date;
  final String image;
  final String channelTitle;

  const VideoPreviewContainer({
    Key? key,
    required this.title,
    required this.date,
    required this.image,
    required this.channelTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: CachedNetworkImage(
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.amber,
            valueColor: AlwaysStoppedAnimation(Colors.black),
          ),
        ),
        errorWidget: (context, url, _) => const SizedBox.shrink(),
        imageUrl: image,
        imageBuilder: (context, imageProvider) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 210,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      AppColors.grey.withOpacity(.5),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.play_circle,
                  size: 100,
                ),
              ),
              const YMargin(10),
              Text(title),
              const YMargin(5),
              Text('Published $date'),
              const YMargin(15),
              Text('By $channelTitle'),
            ],
          );
        },
      ),
    );
  }
}
