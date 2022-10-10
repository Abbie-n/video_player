import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player_app/core/services/api/api_service_impl.dart';
import 'package:video_player_app/features/uploads/repository/uploads_repository.dart';
import 'package:video_player_app/features/uploads/repository/uploads_repository_impl.dart';

final uploadsRepositoryProvider = Provider<UploadsRepository>(
  (ref) => UploadsRepositoryImpl(
    apiService: ApiServiceImpl(),
  ),
);

final connectivityProvider = Provider<Connectivity>((ref) => Connectivity());
