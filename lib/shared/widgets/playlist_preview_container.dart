import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:video_player/shared/constants/colors.dart';
import 'package:video_player/shared/widgets/spacing.dart';

class PlaylistPreviewContainer extends StatelessWidget {
  final String title;
  final String total;
  final String image;

  const PlaylistPreviewContainer({
    Key? key,
    required this.title,
    required this.total,
    required this.image,
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
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 210,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            AppColors.grey.withOpacity(.6),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      alignment: Alignment.centerRight,
                      child: const Icon(
                        Icons.playlist_play_outlined,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const XMargin(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title),
                      const YMargin(5),
                      Text(
                        '$total videos',
                      ),
                      const YMargin(10),
                      const Text('View full playlist'),
                    ],
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
