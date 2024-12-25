import 'package:equatable/equatable.dart';

enum InputType {
  num,
  dropdown,
}

class Criteria extends Equatable {
  String? criteria;
  double? weight;
  String? hint;

  ///app defined as the theme is predefined
  ///0 - cost - the lesser, the better
  ///1 - benefit - the bigger, the better
  int? criteriaCategory;
  InputType? inputType;


  Criteria({
    required this.criteria,
    required this.weight,
    required this.criteriaCategory,
    required this.hint,
    required this.inputType,
  });

  @override
  String toString() {
    return "[criteria : $criteria, weight : $weight, criteriaCategory : $criteriaCategory]";
  }

  @override
  List<Object?> get props => [
        criteria,
        criteriaCategory,
        weight,
      ];

  static generateCriteria(){
    List<Criteria> criterias = [];
    criterias.add(Criteria(criteria: "Harga", hint: "Contoh : 30000", inputType: InputType.num, weight: 0.35, criteriaCategory: 2));
    criterias.add(Criteria(criteria: "SPF Protection", hint: "Contoh : 15", inputType: InputType.num, weight: 0.3, criteriaCategory: 2));
    criterias.add(Criteria(criteria: "Water Resistance", hint: "Contoh : 1", inputType: InputType.num, weight: 0.2, criteriaCategory: 2));
    criterias.add(Criteria(criteria: "Formula Ringan", hint: "Tentukan Pilihan", inputType: InputType.dropdown, weight: 0.15, criteriaCategory: 2));
    return criterias;
  }
}
