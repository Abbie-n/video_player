import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:video_player_app/core/model/data.dart';
import 'package:video_player_app/core/services/api/api_exception.dart';
import 'package:video_player_app/shared/extensions/connectivity_extension.dart';
import 'package:video_player_app/features/playlist/model/playlist_snippet_data.dart';
import 'package:video_player_app/features/playlist/repository/playlist_repository.dart';

class GetChannelPlaylistsUseCase {
  final Connectivity _connectivity;
  final PlaylistRepository repository;

  GetChannelPlaylistsUseCase(this.repository, this._connectivity);

  Future<Data<PlaylistSnippetData>> call() async {
    try {
      if (!await _connectivity.isConnected()) {
        return Data.failure(NetworkException());
      }

      final result = await repository.getChannelPlaylists();

      if (result.items!.isEmpty) {
        return Data.failure(NullException());
      }
      final filteredItems = result.items!
          .where((e) => e.snippet!.liveBroadcastContent != 'upcoming')
          .toList();

      return Data.success(data: result.copyWith(items: filteredItems));
    } on Exception {
      return Data.failure(GenericException());
    }
  }
}
