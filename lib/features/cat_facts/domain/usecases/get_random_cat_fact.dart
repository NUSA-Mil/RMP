import 'package:flutter_application_1/features/cat_facts/domain/entities/cat_fact_entity.dart';
import 'package:flutter_application_1/features/cat_facts/domain/repositories/cat_facts_repository.dart';

class GetRandomCatFact {
  final CatFactsRepository repository;

  GetRandomCatFact(this.repository);

  Future<CatFactEntity> call() async {
    return await repository.getRandomCatFact();
  }
}