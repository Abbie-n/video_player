import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:video_player_app/core/services/storage/offline_client_impl.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<void> serviceLocator() async {
  final offlineClient = await OfflineClientImpl.getInstance();
  getIt.registerSingleton(offlineClient);

  $initGetIt(getIt);
}
