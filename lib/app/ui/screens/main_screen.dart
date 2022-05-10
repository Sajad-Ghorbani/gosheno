import 'package:animations/animations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:gosheno/app/ui/screens/home_screen.dart';
import 'package:gosheno/app/ui/screens/library_screen.dart';
import 'package:gosheno/app/ui/screens/note_screen.dart';
import 'package:gosheno/app/ui/screens/profile_screen.dart';
import 'package:gosheno/app/ui/theme/app_color.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  List<Widget> listWidgets = [
    const HomeScreen(key: ValueKey(1)),
    const NoteScreen(key: ValueKey(2)),
    const LibraryScreen(key: ValueKey(3)),
    const ProfileScreen(key: ValueKey(4)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageTransitionSwitcher(
          duration: const Duration(seconds: 1),
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.scaled,
              child: child,
            );
          },
          child: listWidgets[currentIndex],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              currentIndex != 0
                  ? const SizedBox(height: 5)
                  : const SizedBox.shrink(),
              const Icon(
                FeatherIcons.home,
                color: kWhiteColor,
              ),
              currentIndex != 0
                  ? const Text(
                      'خانه',
                      style: TextStyle(color: kWhiteColor),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              currentIndex != 1
                  ? const SizedBox(height: 5)
                  : const SizedBox.shrink(),
              const Icon(
                FeatherIcons.fileText,
                color: kWhiteColor,
              ),
              currentIndex != 1
                  ? const Text(
                      'یادداشت',
                      style: TextStyle(color: kWhiteColor),
                    )
                  : const SizedBox.shrink()
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              currentIndex != 2
                  ? const SizedBox(height: 5)
                  : const SizedBox.shrink(),
              const Icon(
                FeatherIcons.book,
                color: kWhiteColor,
              ),
              currentIndex != 2
                  ? const Text(
                      'کتابخانه',
                      style: TextStyle(color: kWhiteColor),
                    )
                  : const SizedBox.shrink()
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              currentIndex != 3
                  ? const SizedBox(height: 5)
                  : const SizedBox.shrink(),
              const Icon(
                FeatherIcons.user,
                color: kWhiteColor,
              ),
              currentIndex != 3
                  ? const Text(
                      'پروفایل',
                      style: TextStyle(color: kWhiteColor),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ],
        backgroundColor: Colors.transparent,
        color: Theme.of(context).colorScheme.primary,
        height: 60,
        index: currentIndex,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (int value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
    );
  }
}
