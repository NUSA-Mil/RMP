import 'package:equatable/equatable.dart';

class CatFactEntity extends Equatable {
  final String fact;
  final int length;

  const CatFactEntity({
    required this.fact,
    required this.length,
  });

  @override
  List<Object> get props => [fact, length];

  @override
  String toString() => 'CatFactEntity(fact: $fact, length: $length)';
}