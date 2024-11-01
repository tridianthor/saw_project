class Criteria{
  String? criteria;
  double? weight;
  ///0 - cost - the lesser, the better
  ///1 - benefit - the bigger, the better
  int? criteriaCategory;
  ///0 - text - count
  ///1 - text - matching
  ///2 - number - comparison
  ///3 - dropdown - choice
  int? inputType;
  /*TODO add input types*/

  Criteria({required criteria, required this.weight, required this.criteriaCategory, required this.inputType});
}