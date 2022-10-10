import 'package:freezed_annotation/freezed_annotation.dart';

part 'snippet_data.freezed.dart';

part 'snippet_data.g.dart';

@freezed
class SnippetData with _$SnippetData {
  const factory SnippetData({
    final String? kind,
    final String? etag,
    final String? nextPageToken,
    final String? regionCode,
    final PageInfo? pageInfo,
    final List<Items>? items,
  }) = _SnippetData;

  factory SnippetData.fromJson(Map<String, dynamic> json) =>
      _$SnippetDataFromJson(json);
}

@freezed
class PageInfo with _$PageInfo {
  const factory PageInfo({
    final int? totalResults,
    final int? resultsPerPage,
  }) = _PageInfo;

  factory PageInfo.fromJson(Map<String, dynamic> json) =>
      _$PageInfoFromJson(json);
}

@freezed
class Items with _$Items {
  const factory Items({
    final String? kind,
    final String? etag,
    final Id? id,
    final Snippet? snippet,
  }) = _Items;

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);
}

@freezed
class Id with _$Id {
  const factory Id({
    final String? kind,
    final String? videoId,
  }) = _Id;

  factory Id.fromJson(Map<String, dynamic> json) => _$IdFromJson(json);
}

@freezed
class Snippet with _$Snippet {
  const factory Snippet({
    final String? publishedAt,
    final String? channelId,
    final String? title,
    final String? description,
    final Thumbnails? thumbnails,
    final String? channelTitle,
    final String? liveBroadcastContent,
    final String? publishTime,
  }) = _Snippet;

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);
}

@freezed
class Default with _$Default {
  const factory Default({
    final String? url,
    final int? width,
    final int? height,
  }) = _Default;

  factory Default.fromJson(Map<String, dynamic> json) =>
      _$DefaultFromJson(json);
}

@freezed
class Thumbnails with _$Thumbnails {
  const factory Thumbnails({
    final Default? medium,
    final Default? high,
  }) = _Thumbnails;

  factory Thumbnails.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailsFromJson(json);
}
