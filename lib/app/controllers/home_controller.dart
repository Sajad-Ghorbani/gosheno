import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:gosheno/app/ui/screens/home_screen.dart';
import 'package:gosheno/app/ui/screens/library_screen.dart';
import 'package:gosheno/app/ui/screens/note_screen.dart';
import 'package:gosheno/app/ui/screens/profile_screen.dart';

class HomeController extends GetxController{
  final player = AudioPlayer();

  int currentIndex = 0;
  List<Widget> listWidgets = [
    const HomeScreen(key: ValueKey(1)),
    const NoteScreen(key: ValueKey(2)),
    const LibraryScreen(key: ValueKey(3)),
    const ProfileScreen(key: ValueKey(4)),
  ];
}