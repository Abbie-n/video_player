import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player_app/core/services/api/api_exception.dart';
import 'package:video_player_app/core/services/storage/offline_client.dart';
import 'package:video_player_app/core/utils/constants.dart';
import 'package:video_player_app/features/uploads/model/search_history_data.dart';
import 'package:video_player_app/shared/extensions/connectivity_extension.dart';
import 'package:video_player_app/features/uploads/model/snippet_data.dart';
import 'package:video_player_app/features/uploads/repository/uploads_repository.dart';
import 'package:video_player_app/shared/data.dart';

class SearchChannelVideosUseCase {
  final Connectivity _connectivity;
  final OfflineClient offlineClient;

  final UploadsRepository repository;

  SearchChannelVideosUseCase(
    this.repository,
    this._connectivity,
    this.offlineClient,
  );

  Future<Data<SnippetData>> call(String query) async {
    try {
      if (!await _connectivity.isConnected()) {
        return Data.failure(NetworkException());
      }

      final result = await repository.searchChannelVideos(query);

      if (result.items == null || result.items!.isEmpty) {
        return Data.failure(NullException());
      }

      return Data.success(data: result);
    } on Exception {
      return Data.failure(GenericException());
    }
  }

  void addToSearchHistory(String text) async {
    List<SearchHistoryData> searchlist = [];
    final localString =
        offlineClient.getString(Constants.searchHistoryStorageKey);

    if (localString != null) {
      for (final x in jsonDecode(localString)) {
        searchlist.add(SearchHistoryData.fromJson(x));
      }
    }

    searchlist.add(
      SearchHistoryData(
        id: const Uuid().v4(),
        text: text,
      ),
    );

    await offlineClient.setString(
        Constants.searchHistoryStorageKey, jsonEncode(searchlist));
  }

  void deleteSingleSearchHistory(String id) async {
    List<SearchHistoryData> searchlist = [];
    final localString =
        offlineClient.getString(Constants.searchHistoryStorageKey);

    if (localString != null) {
      for (final x in jsonDecode(localString)) {
        searchlist.add(SearchHistoryData.fromJson(x));
      }
    }

    if (searchlist.isNotEmpty) {
      searchlist.removeWhere((e) => e.id == id);

      await offlineClient.setString(
          Constants.searchHistoryStorageKey, jsonEncode(searchlist));
    }
  }

  List<SearchHistoryData> getSearchHistory() {
    List<SearchHistoryData> searchlist = [];
    final localString =
        offlineClient.getString(Constants.searchHistoryStorageKey);

    if (localString != null) {
      for (final x in jsonDecode(localString)) {
        searchlist.add(SearchHistoryData.fromJson(x));
      }
    }
    return searchlist;
  }

  void clearSearchHistory() async =>
      offlineClient.clearData(Constants.searchHistoryStorageKey);
}
