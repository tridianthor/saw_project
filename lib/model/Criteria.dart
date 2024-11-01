class Criteria{
  String? criteria;
  double? weight;
  ///0 - cost - the lesser, the better
  ///1 - benefit - the bigger, the better
  int? criteriaCategory;

  /*TODO add input types*/

  Criteria({required criteria, required this.weight, required this.criteriaCategory});
}