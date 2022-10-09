import 'package:auto_route/auto_route.dart';
import 'package:video_player/features/home/home_screen.dart';
import 'package:video_player/features/videos/videos_screen.dart';
import 'package:video_player/features/playlist/playlists_screen.dart';

@CupertinoAutoRouter(
  preferRelativeImports: true,
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: HomeScreen, children: [
      AutoRoute(page: VideosScreen),
      AutoRoute(page: PlaylistsScreen),
    ]),
  ],
)
class $AppRouter {}
