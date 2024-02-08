import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytube/ui/theme/credits.dart';
import 'package:mytube/ui/theme/themes.dart';
import 'package:mytube/ui/view/screen/splash_screen.dart';
import 'package:mytube/ui/view_model/favorite_videos_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();


  FavoriteVideosViewModel favoriteVideosViewModel = Get.put(FavoriteVideosViewModel());

  await favoriteVideosViewModel.loadFavorites();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Credits.appName,
      theme: AppThemes.lightTheme(),
      home: const SplashScreen(),
    );
  }
}
