import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:video_player_app/features/playlist/model/playlist_snippet_data.dart';

part 'get_playlist_videos_state.freezed.dart';

@freezed
class GetPlaylistVideosState with _$GetPlaylistVideosState {
  const factory GetPlaylistVideosState.initial() = _Initial;

  const factory GetPlaylistVideosState.loading() = _Loading;

  const factory GetPlaylistVideosState.error({required String message}) =
      _Error;

  const factory GetPlaylistVideosState.finished(
      {required PlaylistSnippetData data}) = _Finished;
}
