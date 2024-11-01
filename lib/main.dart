import 'package:flutter/material.dart';
import 'package:saw_project/constants/Dimens.dart';
import 'package:saw_project/presentation/Home.dart';
import 'package:saw_project/utils/Route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.defaultRoundedRadius),
          ),
        ),
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: const Home(),
      initialRoute: Home.ID,
    );
  }
}


