import 'package:doc_link/presentation/screens/homescreen.dart/doctors/appointmentpage/appointment_page.dart';
import 'package:doc_link/presentation/screens/spashscreen/splashscreen.dart';
import 'package:doc_link/provider/appointmentpage_provider.dart';
import 'package:doc_link/provider/profilescreenprovider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProfileScreenStateModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppointmentScreenStateModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppointmentDateProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DocLink',
        home: const SplashScreen(),
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 222, 227, 255)),
          scaffoldBackgroundColor: const Color.fromRGBO(222, 227, 255, 1),
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
