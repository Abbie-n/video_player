import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:video_player_app/core/utils/constants.dart';

part 'api_request.freezed.dart';

part 'api_request.g.dart';

@freezed
class ApiRequest with _$ApiRequest {
  const factory ApiRequest({
    final String? resource,
    required final String? part,
    final String? channelId,
    final String? channelType,
    required final int maxResults,
    final String? order,
    final String? type,
    final String? playlistId,
    required final String key,
    final String? q,
  }) = _ApiRequest;

  factory ApiRequest.fromJson(Map<String, dynamic> json) =>
      _$ApiRequestFromJson(json);
}

const baseRequest = ApiRequest(
  part: 'snippet',
  maxResults: 10,
  key: Constants.key,
);
