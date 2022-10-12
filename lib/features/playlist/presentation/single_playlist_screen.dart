import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player_app/features/playlist/presentation/cubit/get_playlist_videos_cubit.dart';
import 'package:video_player_app/features/playlist/presentation/cubit/get_playlist_videos_state.dart';
import 'package:video_player_app/routes/router.gr.dart';
import 'package:video_player_app/shared/constants/texts.dart';
import 'package:video_player_app/shared/extensions/string_extension.dart';
import 'package:video_player_app/shared/widgets/base_widget.dart';
import 'package:video_player_app/shared/widgets/header.dart';
import 'package:video_player_app/shared/widgets/video_preview_container.dart';
import 'package:video_player_app/shared/widgets/spacing.dart';

class SinglePlaylistScreen extends HookConsumerWidget {
  const SinglePlaylistScreen({
    super.key,
    required this.playlistTitle,
    required this.playlistId,
  });

  final String playlistTitle;
  final String playlistId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cubit = ref.watch(getPlaylistsVideosCubitProvider);

    useEffect(() {
      cubit.call(playlistId);
      return;
    }, []);

    return BaseWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(title: '$playlistTitle playlist'),
          const YMargin(32),
          BlocBuilder<GetPlaylistsVideosCubit, GetPlaylistVideosState>(
            bloc: cubit,
            builder: (context, state) => state.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              loading: () => const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.amber,
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ),
              ),
              error: (message) => Center(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
              ),
              finished: (data) => Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: data.items!
                        .map(
                          (item) => GestureDetector(
                            onTap: () {
                              if (item.snippet!.resourceId != null) {
                                context.router.push(
                                  CustomVideoPlayer(
                                    videoId: item.snippet!.resourceId!.videoId!,
                                  ),
                                );
                                return;
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppTexts.videoUnavailable),
                                ),
                              );
                            },
                            child: VideoPreviewContainer(
                              channelTitle: item.snippet!.channelTitle!,
                              date: item.snippet!.publishedAt!.convertToTimeAgo,
                              title: item.snippet!.title!,
                              image: item.snippet!.thumbnails!.medium?.url,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
