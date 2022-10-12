import 'package:video_player_app/core/model/api_request.dart';
import 'package:video_player_app/core/services/api/api_service.dart';
import 'package:video_player_app/core/utils/constants.dart';
import 'package:video_player_app/features/uploads/model/snippet_data.dart';
import 'package:video_player_app/features/uploads/repository/uploads_repository.dart';

const path = 'search';

class UploadsRepositoryImpl implements UploadsRepository {
  final ApiService apiService;

  UploadsRepositoryImpl({required this.apiService});

  @override
  Future<SnippetData> getChannelVideos() async {
    final req = baseRequest.copyWith(
      channelId: Constants.channelId,
      order: 'date',
      type: 'video',
      channelType: 'channelTypeUnspecified',
    );

    req.toJson().removeWhere((key, value) => value == null);
    final params = req.toJson();

    final response = await apiService.get(path, params: params);

    if (response == null || response.runtimeType == int) {
      return const SnippetData();
    }

    final data = SnippetData.fromJson(response);
    return data;
  }

  @override
  Future<SnippetData> searchChannelVideos(String query) async {
    final req = baseRequest.copyWith(
      q: query,
      channelId: Constants.channelId,
      order: 'date',
      type: 'video',
      channelType: 'channelTypeUnspecified',
    );

    req.toJson().removeWhere((key, value) => value == null);
    final params = req.toJson();

    final response = await apiService.get(path, params: params);

    if (response == null || response.runtimeType == int) {
      return const SnippetData();
    }

    final data = SnippetData.fromJson(response);
    return data;
  }
}
