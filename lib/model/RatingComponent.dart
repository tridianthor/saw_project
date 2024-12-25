class RatingComponent {
  String? rating;
  double? value;
  dynamic criteriaValue;

  RatingComponent({required this.rating, required this.value});

  checkCriteriaValue() => criteriaValue != null ? true : false;

  static generateRatingComponent() {
    List<RatingComponent> ratingComponents = [];
    ratingComponents.add(RatingComponent(rating: "Sangat Rendah", value: 1));
    ratingComponents.add(RatingComponent(rating: "Rendah", value: 2));
    ratingComponents.add(RatingComponent(rating: "Cukup", value: 3));
    ratingComponents.add(RatingComponent(rating: "Tinggi", value: 4));
    ratingComponents.add(RatingComponent(rating: "Sangat Tinggi", value: 5));
    return ratingComponents;
  }
}
