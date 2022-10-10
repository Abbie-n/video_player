import 'package:video_player_app/core/model/api_request.dart';
import 'package:video_player_app/features/uploads/model/search_snippet_data.dart';

abstract class UploadsRepository {
  Future<SearchSnippetData> getChannelVideos();
  Future<SearchSnippetData> searchChannelVideos(String query);
}
