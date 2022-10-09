import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/routes/router.gr.dart';
import 'package:video_player/shared/constants/colors.dart';
import 'package:video_player/shared/constants/texts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: AutoTabsScaffold(
        routes: const [
          VideosScreen(),
          PlaylistsScreen(),
        ],
        bottomNavigationBuilder: (context, tabsRouter) => BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: tabsRouter.activeIndex,
          iconSize: 22,
          selectedFontSize: 14,
          selectedItemColor: Colors.blue,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedFontSize: 14,
          unselectedItemColor: AppColors.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          type: BottomNavigationBarType.fixed,
          onTap: (i) {
            if (tabsRouter.activeIndex == i) {
              tabsRouter.stackRouterOfIndex(i)?.popUntilRoot();
            } else {
              tabsRouter.setActiveIndex(i);
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.video_collection),
              ),
              label: AppTexts.videos,
            ),
            BottomNavigationBarItem(
              icon: const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.playlist_play),
              ),
              label: AppTexts.playlists,
            ),
          ],
        ),
      ),
    );
  }
}
