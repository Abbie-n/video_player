import 'package:auto_route/auto_route.dart';
import 'package:video_player_app/features/home/home_screen.dart';
import 'package:video_player_app/features/uploads/presentation/uploads_screen.dart';
import 'package:video_player_app/features/playlist/playlists_screen.dart';
import 'package:video_player_app/shared/widgets/custom_video_player.dart';

@CupertinoAutoRouter(
  preferRelativeImports: true,
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: HomeScreen,
      children: [
        AutoRoute(page: UploadsScreen),
        AutoRoute(page: PlaylistsScreen),
      ],
    ),
    AutoRoute(page: CustomVideoPlayer),
  ],
)
class $AppRouter {}
