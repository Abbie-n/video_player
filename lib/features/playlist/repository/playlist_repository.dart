import 'package:video_player_app/features/playlist/model/playlist_snippet_data.dart';

abstract class PlaylistRepository {
  Future<PlaylistSnippetData> getChannelPlaylists();
  Future<PlaylistSnippetData> getPlaylistVideos(String playlistId);
}
