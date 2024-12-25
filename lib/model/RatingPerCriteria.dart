import 'package:saw_project/model/Criteria.dart';
import 'package:saw_project/model/RatingComponent.dart';
import 'package:saw_project/model/SAW.dart';

enum Compare { moreThan, lessThan, equals, moreThanEquals, lessThanEquals }

class RatingPerCriteria {
  Criteria? criteria;
  List value;

  RatingPerCriteria({required this.criteria, required this.value});

  static generateRatingPerCriteria() {
    List<RatingPerCriteria> ratingPerCriteria = [];
    ratingPerCriteria.add(
      RatingPerCriteria(criteria: SawInstance().saw.criterias[0], value: [
        [50000],
        [50000, 75000],
        [75000, 100000],
        [100000, 150000],
        [150000]
      ]),
    );
    ratingPerCriteria.add(
      RatingPerCriteria(criteria: SawInstance().saw.criterias[1], value: [
        [70],
        [50, 70],
        [30, 50],
        [15, 30],
        [15],
      ]),
    );
    ratingPerCriteria.add(
      RatingPerCriteria(criteria: SawInstance().saw.criterias[2], value: [
        [120],
        [90, 120],
        [60, 90],
        [30, 60],
        [30],
      ]),
    );
    ratingPerCriteria.add(
      RatingPerCriteria(criteria: SawInstance().saw.criterias[3], value: ["Sangat Tidak Nyaman", "Berat", "Cukup Nyaman", "Ringan", "Sangat Ringan"]),
    );
    return ratingPerCriteria;
  }
}
