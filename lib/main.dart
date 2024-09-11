import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient/Provider/HomeProvider.dart';
import 'package:patient/Provider/SelectGenderProvider.dart';
import 'package:patient/Provider/SelectHeightProvider.dart';
import 'package:provider/provider.dart';
import 'Provider/SelectWeightProvider.dart';
import 'View/HomePage.dart';
import 'View/SelectHeightPage.dart';
import 'View/SelectWeightPage.dart';
import 'View/splash.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white, // Sets the status bar color
    statusBarIconBrightness: Brightness.light, // For light icons on dark background
    statusBarBrightness: Brightness.dark, // For iOS, dark text on light background
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomePageProvider(),),
        ChangeNotifierProvider(create: (context) => SelectGenderProvider(),),
        ChangeNotifierProvider(create: (context) => WeightProvider(),),
        ChangeNotifierProvider(create: (context) => HeightProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: const Color(0xFF522ED2),
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor:const Color(0xFF522ED2)),
          useMaterial3: true,
        ),
        home: const SplashScreenPage(),
        routes: {
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}

