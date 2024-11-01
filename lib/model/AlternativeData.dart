import 'package:equatable/equatable.dart';

class AlternativeData extends Equatable{
  String? alternative;

  AlternativeData({required this.alternative});

  @override
  List<Object?> get props => [
    alternative,
  ];
}