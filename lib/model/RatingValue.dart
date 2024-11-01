class RatingValue {
  String? rating;
  double? value;

  RatingValue({required this.rating, required this.value});
}

class RatingComponent{
  dynamic itemName;
  RatingValue? ratingValue;

  RatingComponent({required this.itemName, required this.ratingValue});
}