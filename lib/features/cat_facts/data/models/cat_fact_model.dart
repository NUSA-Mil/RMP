import 'package:flutter_application_1/features/cat_facts/domain/entities/cat_fact_entity.dart';

class CatFactModel {
  final String fact;
  final int length;

  CatFactModel({required this.fact, required this.length});

  factory CatFactModel.fromJson(Map<String, dynamic> json) {
    return CatFactModel(
      fact: json['fact'],
      length: json['length'],
    );
  }

  CatFactEntity toEntity() => CatFactEntity(fact: fact, length: length);
}