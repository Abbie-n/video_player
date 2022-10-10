import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_history_data.freezed.dart';

part 'search_history_data.g.dart';

@freezed
class SearchHistoryData with _$SearchHistoryData {
  const factory SearchHistoryData({
    final String? id,
    final String? text,
  }) = _SearchHistoryData;

  factory SearchHistoryData.fromJson(Map<String, dynamic> json) =>
      _$SearchHistoryDataFromJson(json);
}
