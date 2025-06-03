import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/features/cat_facts/domain/entities/cat_fact_entity.dart';
import 'package:flutter_application_1/features/cat_facts/domain/usecases/get_random_cat_fact.dart';

part 'cat_fact_event.dart';
part 'cat_fact_state.dart';

class CatFactBloc extends Bloc<CatFactEvent, CatFactState> {
  final GetRandomCatFact getRandomCatFact;

  CatFactBloc({required this.getRandomCatFact}) : super(CatFactInitial()) {
    on<GetCatFactEvent>(_onGetCatFactEvent);
  }

  Future<void> _onGetCatFactEvent(
    GetCatFactEvent event,
    Emitter<CatFactState> emit,
  ) async {
    emit(CatFactLoading());
    try {
      final fact = await getRandomCatFact();
      emit(CatFactLoaded(fact: fact));
    } catch (e) {
      emit(CatFactError(message: e.toString()));
    }
  }
}