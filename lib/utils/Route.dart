import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:saw_project/presentation/Home.dart';
import 'package:saw_project/presentation/InputAlternatives.dart';
import 'package:saw_project/presentation/InputCriteria.dart';
import 'package:saw_project/presentation/InputData.dart';
import 'package:saw_project/presentation/InputRating.dart';
import 'package:saw_project/presentation/Result.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case Home.ID:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const Home(),
        );
      case InputAlternatives.ID:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const InputAlternatives(),
        );
      case InputCriteria.ID:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const InputCriteria(),
        );
      case InputRating.ID:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const InputRating(),
        );
      case InputData.ID:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const InputData(),
        );
      case Result.ID:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const Result(),
        );
    }
  }
}