import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player_app/routes/router.gr.dart';

void main() => runApp(ProviderScope(child: VideoPlayerApp()));

class VideoPlayerApp extends StatelessWidget {
  VideoPlayerApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'VideoPlayer',
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
