import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:video_player_app/features/playlist/model/playlist_snippet_data.dart';

part 'get_channel_playlists_state.freezed.dart';

@freezed
class GetChannelPlaylistsState with _$GetChannelPlaylistsState {
  const factory GetChannelPlaylistsState.initial() = _Initial;

  const factory GetChannelPlaylistsState.loading() = _Loading;

  const factory GetChannelPlaylistsState.error({required String message}) =
      _Error;

  const factory GetChannelPlaylistsState.finished(
      {required PlaylistSnippetData data}) = _Finished;
}
