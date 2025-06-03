import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/network/dio_setup.dart';
import 'package:flutter_application_1/features/cat_facts/data/datasources/cat_facts_remote_data_source.dart';
import 'package:flutter_application_1/features/cat_facts/data/repositories/cat_facts_repository_impl.dart';
import 'package:flutter_application_1/features/cat_facts/domain/repositories/cat_facts_repository.dart';
import 'package:flutter_application_1/features/cat_facts/domain/usecases/get_random_cat_fact.dart';
import 'package:flutter_application_1/features/cat_facts/presentation/bloc/cat_fact_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // External
  sl.registerSingleton<Dio>(setupDio());

  // Data sources
  sl.registerLazySingleton<CatFactsRemoteDataSource>(
    () => CatFactsRemoteDataSourceImpl(dio: sl()),
  );

  // Repository
  sl.registerLazySingleton<CatFactsRepository>(
    () => CatFactsRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetRandomCatFact(sl()));

  // Bloc
  sl.registerFactory(() => CatFactBloc(getRandomCatFact: sl()));
}