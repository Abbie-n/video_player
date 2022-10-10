import 'package:video_player_app/core/model/api_request.dart';
import 'package:video_player_app/core/services/api/api_service.dart';
import 'package:video_player_app/core/utils/constants.dart';
import 'package:video_player_app/features/playlist/model/playlist_snippet_data.dart';
import 'package:video_player_app/features/playlist/repository/playlist_repository.dart';
import 'package:video_player_app/features/uploads/model/snippet_data.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {
  final ApiService apiService;

  PlaylistRepositoryImpl({required this.apiService});

  @override
  Future<PlaylistSnippetData> getChannelPlaylists() async {
    const path = 'playlists';
    final req = baseRequest.copyWith(
      channelId: Constants.channelId,
    );

    req.toJson().removeWhere((key, value) => value == null);
    final params = req.toJson();

    final response = await apiService.get(path, params: params);

    if (response == null || response.runtimeType == int) {
      return const PlaylistSnippetData();
    }

    final data = PlaylistSnippetData.fromJson(response);
    return data;
  }

  @override
  Future<PlaylistSnippetData> getPlaylistVideos(String playlistId) async {
    const path = 'playlistItems';

    final req = baseRequest.copyWith(
      channelId: Constants.channelId,
      playlistId: playlistId,
    );

    req.toJson().removeWhere((key, value) => value == null);
    final params = req.toJson();

    final response = await apiService.get(path, params: params);

    if (response == null || response.runtimeType == int) {
      return const PlaylistSnippetData();
    }

    final data = PlaylistSnippetData.fromJson(response);
    return data;
  }
}
