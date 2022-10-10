import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player_app/features/uploads/presentation/cubit/get_channel_videos_cubit.dart';
import 'package:video_player_app/features/uploads/presentation/cubit/get_channel_videos_state.dart';
import 'package:video_player_app/routes/router.gr.dart';
import 'package:video_player_app/shared/constants/texts.dart';
import 'package:video_player_app/shared/extensions/string_extension.dart';
import 'package:video_player_app/shared/widgets/base_widget.dart';
import 'package:video_player_app/shared/widgets/video_preview_container.dart';
import 'package:video_player_app/shared/widgets/spacing.dart';

class UploadsScreen extends HookConsumerWidget {
  const UploadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cubit = ref.watch(getChannelVideosCubitProvider);

    useEffect(() {
      cubit.call();
      return;
    }, []);

    return BaseWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppTexts.uploads,
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
          BlocBuilder<GetChannelVideosCubit, GetChannelVideosState>(
            bloc: cubit,
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                error: (message) => Text(
                  message,
                  style: const TextStyle(color: Colors.redAccent),
                ),
                finished: (data) => Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: List.generate(
                            data.items!.length,
                            (index) => GestureDetector(
                              onTap: () {
                                if (data.items![index].id!.videoId != null) {
                                  context.router.push(CustomVideoPlayer(
                                      videoId:
                                          data.items![index].id!.videoId!));
                                  return;
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Video unavailable'),
                                  ),
                                );
                              },
                              child: VideoPreviewContainer(
                                  channelTitle:
                                      data.items![index].snippet!.channelTitle!,
                                  date: data.items![index].snippet!.publishedAt!
                                      .convertToTimeAgo,
                                  title: data.items![index].snippet!.title!,
                                  image: data.items![index].snippet!.thumbnails!
                                      .medium!.url!),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
