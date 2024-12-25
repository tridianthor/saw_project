import 'dart:developer';
import 'dart:math' as math;

import 'package:saw_project/model/AlternativeData.dart';
import 'package:saw_project/model/Criteria.dart';
import 'package:saw_project/model/RatingComponent.dart';
import 'package:saw_project/model/RatingPerCriteria.dart';

class Saw {
  List<AlternativeData> alternatives;

  ///criterias weight total must be 1;
  List<Criteria> criterias;
  List<RatingComponent> ratingComponents;

  ///to store data
  Map data = {};

  ///rating per criteria
  List<RatingPerCriteria> ratingPerCriteria;

  Map<String, List> matrix = {};
  Map<String, List> normalizedMatrix = {};
  List<List<double>> decisionMatrix = [[]];
  List<double> rankedList = [];

  Saw({
    required this.alternatives,
    required this.criterias,
    required this.ratingComponents,
    required this.ratingPerCriteria,
  });

  clear() {
    alternatives.clear();
    criterias.clear();
    ratingComponents.clear();
    ratingPerCriteria.clear();
    decisionMatrix.clear();
    normalizedMatrix.clear();
    rankedList.clear();
  }

  check() => alternatives.isEmpty && criterias.isEmpty && ratingComponents.isEmpty;
}

class SawInstance {
  static SawInstance _instance = SawInstance._();

  factory SawInstance() {
    return _instance;
  }

  SawInstance._();

  Saw saw = Saw(alternatives: [], criterias: [], ratingComponents: [], ratingPerCriteria: []);

  calculateMatrix() {
    Map<String, List> matrix = {};
    saw.data.forEach((key, element) {
      int criteriaIndex = 0;
      matrix[key] = element.map((element) {
        var criteriaRating = saw.ratingPerCriteria[criteriaIndex].value;
        int? intValue = int.tryParse(element);
        if (intValue == null) {
          if (element == criteriaRating[4]) {
            criteriaIndex++;
            return 5;
          } else if (element == criteriaRating[3]) {
            criteriaIndex++;
            return 4;
          } else if (element == criteriaRating[2]) {
            criteriaIndex++;
            return 3;
          } else if (element == criteriaRating[1]) {
            criteriaIndex++;
            return 2;
          } else {
            criteriaIndex++;
            return 1;
          }
        } else {
          if (criteriaIndex == 0) {
            log("int value : $intValue, ratingValue : ${criteriaRating[1][0]} ${criteriaRating[1][1]}");
            if (intValue < criteriaRating[0][0]) {
              criteriaIndex++;
              return 5;
            } else if (intValue >= criteriaRating[1][0] && intValue < criteriaRating[1][1]) {
              criteriaIndex++;
              return 4;
            } else if (intValue >= criteriaRating[2][0] && intValue < criteriaRating[2][1]) {
              criteriaIndex++;
              return 3;
            } else if (intValue >= criteriaRating[3][0] && intValue < criteriaRating[3][1]) {
              criteriaIndex++;
              return 2;
            } else {
              criteriaIndex++;
              return 1;
            }
          } else {
            int intValue = int.parse(element);
            if (intValue > criteriaRating[0][0]) {
              criteriaIndex++;
              return 5;
            } else if (intValue >= criteriaRating[1][0] && intValue < criteriaRating[1][1]) {
              criteriaIndex++;
              return 4;
            } else if (intValue >= criteriaRating[2][0] && intValue < criteriaRating[2][1]) {
              criteriaIndex++;
              return 3;
            } else if (intValue >= criteriaRating[3][0] && intValue < criteriaRating[3][1]) {
              criteriaIndex++;
              return 2;
            } else {
              criteriaIndex++;
              return 1;
            }
          }
        }
      }).toList();
    });

    saw.matrix = matrix;

    saw.matrix.forEach((key, element) {
      log("key : $key, element: ${element.toString()}");
    });

    normalizeMatrixAndCalculateVector();
  }

  normalizeMatrixAndCalculateVector() {
    saw.matrix.forEach((String key, List element) {
      List normalizedValue = element.map((value) {
        int criteriaIndex = 0;
        int divider = saw.matrix.values.map((element){
          return element[criteriaIndex];
        }).cast<int>().toList().reduce(math.max);
        criteriaIndex++;
        return value/divider;
      }).toList();

      double vector = 0;
      int elementIndex = 0;
      for (var element in normalizedValue) {
        vector = vector + (element * saw.criterias[elementIndex].weight);
        elementIndex++;
      }
      saw.rankedList.add(vector);
    });
  }

  getWinner(){
    int winnerIndex = saw.rankedList.indexOf(saw.rankedList.reduce(math.max));
    return {
      "winner": saw.alternatives[winnerIndex],
      "score": saw.rankedList[winnerIndex]
    };
  }
}