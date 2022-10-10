import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player_app/features/playlist/presentation/cubit/get_playlist_videos_cubit.dart';
import 'package:video_player_app/features/playlist/presentation/cubit/get_playlist_videos_state.dart';
import 'package:video_player_app/routes/router.gr.dart';
import 'package:video_player_app/shared/extensions/string_extension.dart';
import 'package:video_player_app/shared/widgets/back_navigator.dart';
import 'package:video_player_app/shared/widgets/base_widget.dart';
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
          Row(
            children: [
              const BackNavigator(),
              const XMargin(16),
              Expanded(
                child: Text(
                  '$playlistTitle playlist',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const YMargin(32),
          BlocBuilder<GetPlaylistsVideosCubit, GetPlaylistVideosState>(
            bloc: cubit,
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                error: (message) => Text(
                  message,
                  style: const TextStyle(color: Colors.redAccent),
                ),
                finished: (data) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            children: List.generate(
                              data.items!.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  if (data.items![index].snippet!.resourceId !=
                                      null) {
                                    context.router.push(CustomVideoPlayer(
                                        videoId: data.items![index].snippet!
                                            .resourceId!.videoId!));
                                    return;
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Video unavailable'),
                                    ),
                                  );
                                },
                                child: VideoPreviewContainer(
                                    channelTitle: data
                                        .items![index].snippet!.channelTitle!,
                                    date: data.items![index].snippet!
                                        .publishedAt!.convertToTimeAgo,
                                    title: data.items![index].snippet!.title!,
                                    image: data.items![index].snippet!
                                        .thumbnails!.medium?.url),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
