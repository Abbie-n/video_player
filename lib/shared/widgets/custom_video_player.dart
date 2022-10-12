import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player_app/shared/widgets/base_widget.dart';
import 'package:video_player_app/shared/widgets/header.dart';
import 'package:video_player_app/shared/widgets/spacing.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class CustomVideoPlayer extends HookConsumerWidget {
  const CustomVideoPlayer({super.key, required this.videoId});
  final String videoId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useState<YoutubePlayerController?>(null);

    void controllerListener() => controller.value = YoutubePlayerController(
          params: const YoutubePlayerParams(
            mute: false,
            showControls: true,
            showFullscreenButton: true,
            color: 'black',
          ),
        )..onInit =
            () async => await controller.value!.cueVideoById(videoId: videoId);

    useEffect(() {
      controllerListener();
      controller.addListener(controllerListener);

      return () {
        controller.removeListener(controllerListener);
      };
    }, []);

    return YoutubePlayerScaffold(
      controller: controller.value!,
      aspectRatio: 16 / 9,
      builder: (context, player) {
        return BaseWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(title: 'Player'),
              const YMargin(16),
              Expanded(child: player)
            ],
          ),
        );
      },
    );
  }
}
