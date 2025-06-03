import 'package:flutter_application_1/features/cat_facts/data/datasources/cat_facts_remote_data_source.dart';
import 'package:flutter_application_1/features/cat_facts/domain/entities/cat_fact_entity.dart';
import 'package:flutter_application_1/features/cat_facts/domain/repositories/cat_facts_repository.dart';

class CatFactsRepositoryImpl implements CatFactsRepository {
  final CatFactsRemoteDataSource remoteDataSource;

  CatFactsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<CatFactEntity> getRandomCatFact() async {
    try {
      final fact = await remoteDataSource.getRandomCatFact();
      return fact.toEntity();
    } catch (e) {
      throw Exception('Failed to get cat fact: ${e.toString()}');
    }
  }
}