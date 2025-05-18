import 'package:Cooply/core/di/service_locator.dart';
import 'package:Cooply/providers/auth_provider.dart';
import 'package:Cooply/screens/splash_screen.dart';
import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'services/AuthService.dart';

void main() {
  setupLocator();
  runApp(

      // const MyApp()
      MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => AuthProvider(
              getIt<AuthService>())), //Inject get_it service into provider
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.APP_TITLE,
      localizationsDelegates: const [

        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
