import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/constants/api_constants.dart';
import 'package:flutter_application_1/features/cat_facts/data/models/cat_fact_model.dart';

abstract class CatFactsRemoteDataSource {
  Future<CatFactModel> getRandomCatFact();
}

class CatFactsRemoteDataSourceImpl implements CatFactsRemoteDataSource {
  final Dio dio;

  CatFactsRemoteDataSourceImpl({required this.dio});

  @override
  Future<CatFactModel> getRandomCatFact() async {
    final response = await dio.get(ApiConstants.catFact);
    return CatFactModel.fromJson(response.data);
  }
}