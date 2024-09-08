import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ice_hockey_ball/screens/intro_screen.dart';


void main() async{
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AirHockeyApp());
}

class AirHockeyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: IntroScreen(), // Pass the navigatorKey to SplashScreen
        );

      },
    );
  }
}