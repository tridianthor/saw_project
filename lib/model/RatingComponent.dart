class RatingComponent{
  String? rating;
  double? value;
  dynamic criteriaValue;

  /*TODO there's a case where a not all rating were used in one criteria*/

  RatingComponent({required this.rating, required this.value});

  checkCriteriaValue() => criteriaValue != null ? true : false;
}