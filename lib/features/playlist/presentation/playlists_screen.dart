import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player_app/features/playlist/presentation/cubit/get_channel_playlists_cubit.dart';
import 'package:video_player_app/features/playlist/presentation/cubit/get_channel_playlists_state.dart';
import 'package:video_player_app/shared/constants/texts.dart';
import 'package:video_player_app/shared/widgets/base_widget.dart';
import 'package:video_player_app/shared/widgets/playlist_preview_container.dart';
import 'package:video_player_app/shared/widgets/spacing.dart';

class PlaylistsScreen extends HookConsumerWidget {
  const PlaylistsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cubit = ref.watch(getChannelPlaylistsCubitProvider);

    useEffect(() {
      cubit.call();
      return;
    }, []);

    return BaseWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.playlists,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const YMargin(32),
          BlocBuilder<GetChannelPlaylistsCubit, GetChannelPlaylistsState>(
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
                            (index) => PlaylistPreviewContainer(
                              title: data.items![index].snippet!.title!,
                              image: data.items![index].snippet!.thumbnails!
                                  .medium!.url!,
                              playlistId: data.items![index].id!,
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
