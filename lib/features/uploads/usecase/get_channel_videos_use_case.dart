import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:video_player_app/core/services/api/api_exception.dart';
import 'package:video_player_app/shared/extensions/connectivity_extension.dart';
import 'package:video_player_app/features/uploads/model/snippet_data.dart';
import 'package:video_player_app/features/uploads/repository/uploads_repository.dart';
import 'package:video_player_app/shared/data.dart';

class GetChannelVideosUseCase {
  final Connectivity _connectivity;

  final UploadsRepository repository;

  GetChannelVideosUseCase(this.repository, this._connectivity);

  Future<Data<SnippetData>> call() async {
    try {
      if (!await _connectivity.isConnected()) {
        return Data.failure(NetworkException());
      }

      final result = await repository.getChannelVideos();

      if (result.items == null || result.items!.isEmpty) {
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
