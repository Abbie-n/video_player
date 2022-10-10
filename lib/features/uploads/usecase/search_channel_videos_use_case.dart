import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:video_player_app/core/services/api/api_exception.dart';
import 'package:video_player_app/core/utils/connectivity_extension.dart';
import 'package:video_player_app/features/uploads/model/search_snippet_data.dart';
import 'package:video_player_app/features/uploads/repository/uploads_repository.dart';
import 'package:video_player_app/shared/data.dart';

class SearchChannelVideosUseCase {
  final Connectivity _connectivity;

  final UploadsRepository repository;

  SearchChannelVideosUseCase(this.repository, this._connectivity);

  Future<Data<SearchSnippetData>> call(String query) async {
    try {
      if (!await _connectivity.isConnected()) {
        return Data.failure(NetworkException());
      }

      final result = await repository.searchChannelVideos(query);

      if (result.items!.isEmpty) {
        return Data.failure(NullException());
      }

      return Data.success(data: result);
    } on Exception {
      return Data.failure(GenericException());
    }
  }
}
