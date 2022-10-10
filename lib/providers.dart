import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player_app/core/services/api/api_service_impl.dart';
import 'package:video_player_app/core/services/storage/offline_client.dart';
import 'package:video_player_app/core/services/storage/offline_client_impl.dart';
import 'package:video_player_app/features/playlist/repository/playlist_repository.dart';
import 'package:video_player_app/features/playlist/repository/playlist_repository_impl.dart';
import 'package:video_player_app/features/uploads/repository/uploads_repository.dart';
import 'package:video_player_app/features/uploads/repository/uploads_repository_impl.dart';

final uploadsRepositoryProvider = Provider<UploadsRepository>(
  (ref) => UploadsRepositoryImpl(
    apiService: ApiServiceImpl(),
  ),
);

final playlistRepositoryProvider = Provider<PlaylistRepository>(
  (ref) => PlaylistRepositoryImpl(
    apiService: ApiServiceImpl(),
  ),
);

final connectivityProvider = Provider<Connectivity>((ref) => Connectivity());

final offlineClientProvider =
    Provider<OfflineClient>((ref) => OfflineClientImpl());
