import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:video_player_app/features/uploads/model/snippet_data.dart';

part 'get_channel_videos_state.freezed.dart';

@freezed
class GetChannelVideosState with _$GetChannelVideosState {
  const factory GetChannelVideosState.initial() = _Initial;

  const factory GetChannelVideosState.loading() = _Loading;

  const factory GetChannelVideosState.error({required String message}) = _Error;

  const factory GetChannelVideosState.finished({required SnippetData data}) =
      _Finished;
}
