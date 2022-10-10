import 'package:video_player_app/features/uploads/model/snippet_data.dart';

abstract class UploadsRepository {
  Future<SnippetData> getChannelVideos();
  Future<SnippetData> searchChannelVideos(String query);
}
