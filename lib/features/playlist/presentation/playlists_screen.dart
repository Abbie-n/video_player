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
                          (item) => PlaylistPreviewContainer(
                            title: item.snippet!.title!,
                            image: item.snippet!.thumbnails!.medium!.url!,
                            playlistId: item.id!,
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
