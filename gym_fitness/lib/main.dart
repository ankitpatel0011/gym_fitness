import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techsaga/View/dashboard.dart';
import 'package:techsaga/View/screens/login/login_screen.dart';
import 'package:techsaga/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:techsaga/Repository/Provider/gym_provider.dart';
import 'package:techsaga/Repository/Provider/location_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LocationProvider>.value(value: locationProvider),
      ChangeNotifierProvider<GymProvider>.value(value: gymProvider),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  PhoneNumberScreen(),
    );
  }
}
