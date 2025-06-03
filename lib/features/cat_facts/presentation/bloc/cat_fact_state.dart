part of 'cat_fact_bloc.dart';

abstract class CatFactState extends Equatable {
  const CatFactState();

  @override
  List<Object> get props => [];
}

class CatFactInitial extends CatFactState {}

class CatFactLoading extends CatFactState {}

class CatFactLoaded extends CatFactState {
  final CatFactEntity fact;

  const CatFactLoaded({required this.fact});

  @override
  List<Object> get props => [fact];
}

class CatFactError extends CatFactState {
  final String message;

  const CatFactError({required this.message});

  @override
  List<Object> get props => [message];
}