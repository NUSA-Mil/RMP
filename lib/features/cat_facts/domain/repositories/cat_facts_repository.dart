import 'package:flutter_application_1/features/cat_facts/domain/entities/cat_fact_entity.dart';

abstract class CatFactsRepository {
  Future<CatFactEntity> getRandomCatFact();
}