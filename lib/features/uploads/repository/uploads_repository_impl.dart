import 'package:loggy/loggy.dart';
import 'package:video_player_app/core/model/api_request.dart';
import 'package:video_player_app/core/services/api/api_service.dart';
import 'package:video_player_app/core/utils/constants.dart';
import 'package:video_player_app/features/uploads/model/search_snippet_data.dart';
import 'package:video_player_app/features/uploads/repository/uploads_repository.dart';

class UploadsRepositoryImpl implements UploadsRepository {
  final ApiService apiService;

  UploadsRepositoryImpl({required this.apiService});

  @override
  Future<SearchSnippetData> getChannelVideos() async {
    const path = 'search';
    final req = baseRequest.copyWith(
      channelId: Constants.channelId,
      order: 'date',
      type: 'video',
      channelType: 'channelTypeUnspecified',
    );

    req.toJson().removeWhere((key, value) => value == null);
    final params = req.toJson();
    logDebug('get params ::: $params');

    final response = await apiService.get(path, params: params);

    if (response == null || response.runtimeType == int) {
      return const SearchSnippetData();
    }

    final data = SearchSnippetData.fromJson(response);
    return data;
  }

  @override
  Future<SearchSnippetData> searchChannelVideos(String query) async {
    const path = 'search';

    final req = baseRequest.copyWith(
      q: query,
      channelId: Constants.channelId,
      order: 'date',
      type: 'video',
      channelType: 'channelTypeUnspecified',
    );

    req.toJson().removeWhere((key, value) => value == null);
    final params = req.toJson();
    logDebug('search params ::: $params');

    final response = await apiService.get(path, params: params);

    if (response == null || response.runtimeType == int) {
      return const SearchSnippetData();
    }

    final data = SearchSnippetData.fromJson(response);
    return data;
  }
}
