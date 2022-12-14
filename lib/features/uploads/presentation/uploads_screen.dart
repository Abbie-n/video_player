import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player_app/features/uploads/presentation/cubit/get_channel_videos_cubit.dart';
import 'package:video_player_app/features/uploads/presentation/cubit/get_channel_videos_state.dart';
import 'package:video_player_app/features/uploads/presentation/widget/search_box.dart';
import 'package:video_player_app/routes/router.gr.dart';
import 'package:video_player_app/shared/constants/texts.dart';
import 'package:video_player_app/shared/extensions/string_extension.dart';
import 'package:video_player_app/shared/extensions/text_editing_controller_extension.dart';
import 'package:video_player_app/shared/widgets/base_widget.dart';
import 'package:video_player_app/shared/widgets/video_preview_container.dart';
import 'package:video_player_app/shared/widgets/spacing.dart';

class UploadsScreen extends HookConsumerWidget {
  const UploadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cubit = ref.watch(getChannelVideosCubitProvider);
    final focusNode = useFocusNode();
    final controller = useTextEditingController();
    final overlayState = useState<OverlayState>(Overlay.of(context));
    final overlayEntry = useState<OverlayEntry?>(null);

    controller.addHookListener(() {});

    useEffect(() {
      cubit.call();
      return null;
    }, []);

    return BaseWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.uploads,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const YMargin(16),
          SearchBox(
            controller: controller,
            focusNode: focusNode,
            overlayEntry: overlayEntry,
            overlayState: overlayState,
          ),
          const YMargin(32),
          BlocBuilder<GetChannelVideosCubit, GetChannelVideosState>(
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
                              if (item.id!.videoId != null) {
                                context.router.push(
                                  CustomVideoPlayer(
                                    videoId: item.id!.videoId!,
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
                              image: item.snippet!.thumbnails!.medium!.url!,
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
