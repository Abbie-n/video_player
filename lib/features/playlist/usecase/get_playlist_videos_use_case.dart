import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:video_player_app/core/services/api/api_exception.dart';
import 'package:video_player_app/shared/extensions/connectivity_extension.dart';
import 'package:video_player_app/features/playlist/model/playlist_snippet_data.dart';
import 'package:video_player_app/features/playlist/repository/playlist_repository.dart';
import 'package:video_player_app/shared/data.dart';

class GetPlaylistVideosUseCase {
  final Connectivity _connectivity;
  final PlaylistRepository repository;

  GetPlaylistVideosUseCase(this.repository, this._connectivity);

  Future<Data<PlaylistSnippetData>> call(String playlistId) async {
    try {
      if (!await _connectivity.isConnected()) {
        return Data.failure(NetworkException());
      }

      final result = await repository.getPlaylistVideos(playlistId);

      if (result.items!.isEmpty) {
        return Data.failure(NullException());
      }

      return Data.success(data: result);
    } on Exception {
      return Data.failure(GenericException());
    }
  }
}
