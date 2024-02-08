import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:mytube/ui/theme/themes.dart';

import '../../theme/iconpath.dart';
import '../../theme/credits.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 6), () {
      Get.off(
        () => HomeScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 1500),
      );
    });

    return Scaffold(
      body: AnimateGradient(
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.bottomLeft,
        secondaryBegin: Alignment.bottomLeft,
        secondaryEnd: Alignment.topRight,
        primaryColors: const [
          AppColors.accentColor2,
          AppColors.accentColor1,
        ],
        secondaryColors: const [
          Colors.black,
          Colors.black87,
        ],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 300.0),
              const Text(
                Credits.appName,
                style: TextStyle(
                  fontSize: 52.0,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: AppColors.accentColor1,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              Image.asset(
                IconPath.appIconPath,
                width: 80.0,
                height: 80.0,
              ),
              const SizedBox(height: 240.0),
              const Text(
                Credits.developedBy,
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
