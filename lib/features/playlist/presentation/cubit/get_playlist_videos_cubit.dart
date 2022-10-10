import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_app/bloc_provider.dart';
import 'package:video_player_app/features/playlist/presentation/cubit/get_channel_playlists_state.dart';
import 'package:video_player_app/features/playlist/presentation/cubit/get_playlist_videos_state.dart';
import 'package:video_player_app/features/playlist/usecase/get_playlist_videos_use_case.dart';
import 'package:video_player_app/providers.dart';

final getPlaylistsVideosCubitProvider =
    cubitAutoDispose<GetPlaylistsVideosCubit>(
  (ref) => GetPlaylistsVideosCubit(
    GetPlaylistVideosUseCase(
      ref.read(playlistRepositoryProvider),
      ref.read(connectivityProvider),
    ),
  ),
);

class GetPlaylistsVideosCubit extends Cubit<GetPlaylistVideosState> {
  final GetPlaylistVideosUseCase getPlaylistVideosUseCase;

  GetPlaylistsVideosCubit(this.getPlaylistVideosUseCase)
      : super(const GetPlaylistVideosState.initial());

  Future<void> call(String playlistId) async {
    emit(const GetPlaylistVideosState.loading());

    final result = await getPlaylistVideosUseCase(playlistId);

    result.maybeWhen(
      success: (data) async =>
          emit(GetPlaylistVideosState.finished(data: data)),
      failure: (exception) => emit(GetPlaylistVideosState.error(
        message: exception.toString(),
      )),
      orElse: () => null,
    );
  }
}
