import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ummaku/page/navigation_page.dart';
import 'package:ummaku/style/theme.dart';
import 'package:geolocator/geolocator.dart';

import 'controllers/location_controller.dart';

void main() async {
  // Directory directory = await path.getApplicationDocumentsDirectory();
  // Hive.init(directory.path);
  // Hive.registerAdapter(ThemeResourceAdapter());
  // Get.put(LocationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ummaku',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigateToHome() async {
    int a = 0;

    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.requestPermission();
    while (a != 2) {
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        a = 2;
        break;
      } else {
        if (permission == LocationPermission.deniedForever) {
          await Geolocator.openAppSettings();
          permission = await Geolocator.checkPermission();
          // Navigator.pushReplacementNamed(context, '/NoLocationPermission');
        } else {
          permission = await Geolocator.requestPermission();
        }
      }
    }

    while (!isLocationServiceEnabled) {
      await Geolocator.openLocationSettings();
      isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    }
    final controller = Get.put(LocationController());
    if (a == 2) {
      await Future.delayed(const Duration(milliseconds: 200),
          () => controller.getLocationFromloc());
    }
    Future.delayed(const Duration(milliseconds: 2000), () {
      Get.to(const NavigationPage(), transition: Transition.downToUp);
    });
  }

  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/appIcon.png',
              height: 200,
              width: 200,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text('Ummaku')
          ],
        ),
      ),
    );
  }
}
