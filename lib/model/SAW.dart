import 'package:saw_project/model/AlternativeData.dart';
import 'package:saw_project/model/Criteria.dart';
import 'package:saw_project/model/RatingValue.dart';

class Saw{
  List<AlternativeData> alternatives;
  ///criterias weight total must be 1;
  List<Criteria> criterias;
  List<RatingComponent> ratingComponents;
  ///to store data
  List<List<dynamic>>? data;

  List<List<double>> decisionMatrix = [[]];
  List<List<double>> normalizedMatrix = [[]];
  List<double> rankedList = [];

  Saw({required this.alternatives,
    required this.criterias,
    required this.ratingComponents,});

  clear(){
    alternatives.clear();
    criterias.clear();
    ratingComponents.clear();
    decisionMatrix.clear();
    normalizedMatrix.clear();
    rankedList.clear();
  }

  check() => alternatives.isEmpty && criterias.isEmpty && ratingComponents.isEmpty;
}

class TemporaryCalculation{
  static TemporaryCalculation _instance = TemporaryCalculation._();

  factory TemporaryCalculation(){
    return _instance;
  }

  TemporaryCalculation._();

  Saw saw = Saw(alternatives: [], criterias: [], ratingComponents: []);
}