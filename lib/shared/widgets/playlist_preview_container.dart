import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:video_player_app/shared/constants/colors.dart';
import 'package:video_player_app/shared/widgets/spacing.dart';

import 'package:video_player_app/routes/router.gr.dart';

class PlaylistPreviewContainer extends StatelessWidget {
  final String title;
  final String image;
  final String playlistId;

  const PlaylistPreviewContainer({
    Key? key,
    required this.title,
    required this.image,
    required this.playlistId,
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
        imageBuilder: (context, imageProvider) => Row(
          children: [
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () => navigateToSinglePlalistScreen(context),
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
            ),
            const XMargin(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  const YMargin(10),
                  GestureDetector(
                    onTap: () => navigateToSinglePlalistScreen(context),
                    child: const Text('View full playlist'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void navigateToSinglePlalistScreen(BuildContext context) {
    if (playlistId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Playlist unavailable'),
        ),
      );
      return;
    }

    context.router.push(
      SinglePlaylistScreen(
        playlistId: playlistId,
        playlistTitle: title,
      ),
    );
  }
}
