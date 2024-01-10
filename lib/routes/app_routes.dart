import 'package:flutter/material.dart';
import 'package:anamnesis/presentation/home_map_screen/home_map_screen.dart';
import 'package:anamnesis/presentation/memory_screen/memory_screen.dart';
import 'package:anamnesis/presentation/home_list_screen/home_list_screen.dart';
import 'package:anamnesis/presentation/edit_memory_screen/edit_memory_screen.dart';
import 'package:anamnesis/presentation/create_memory_screen/create_memory_screen.dart';
import 'package:anamnesis/presentation/side_menu_screen/side_menu_screen.dart';
import 'package:anamnesis/presentation/memory_journals_screen/memory_journals_screen.dart';
import 'package:anamnesis/presentation/memory_journals_journal_screen/memory_journals_journal_screen.dart';
import 'package:anamnesis/presentation/memory_map_screen/memory_map_screen.dart';
import 'package:anamnesis/presentation/memory_photos_screen/memory_photos_screen.dart';
import 'package:anamnesis/presentation/memory_photos_photo_screen/memory_photos_photo_screen.dart';
import 'package:anamnesis/presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String homeMapScreen = '/home_map_screen';

  static const String memoryScreen = '/memory_screen';

  static const String homeListScreen = '/home_list_screen';

  static const String editMemoryScreen = '/edit_memory_screen';

  static const String createMemoryScreen = '/create_memory_screen';

  static const String sideMenuScreen = '/side_menu_screen';

  static const String memoryJournalsScreen = '/memory_journals_screen';

  static const String memoryJournalsJournalScreen =
      '/memory_journals_journal_screen';

  static const String memoryMapScreen = '/memory_map_screen';

  static const String memoryPhotosScreen = '/memory_photos_screen';

  static const String memoryPhotosPhotoScreen = '/memory_photos_photo_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> get routes => {
        homeMapScreen: HomeMapScreen.builder,
        memoryScreen: MemoryScreen.builder,
        homeListScreen: HomeListScreen.builder,
        editMemoryScreen: EditMemoryScreen.builder,
        createMemoryScreen: CreateMemoryScreen.builder,
        sideMenuScreen: SideMenuScreen.builder,
        memoryJournalsScreen: MemoryJournalsScreen.builder,
        memoryJournalsJournalScreen: MemoryJournalsJournalScreen.builder,
        memoryMapScreen: MemoryMapScreen.builder,
        memoryPhotosScreen: MemoryPhotosScreen.builder,
        memoryPhotosPhotoScreen: MemoryPhotosPhotoScreen.builder,
        appNavigationScreen: AppNavigationScreen.builder,
        initialRoute: HomeListScreen.builder
      };
}
