part of 'top_bloc.dart';

abstract class TopEvent extends Equatable {
  const TopEvent();

  @override
  List<Object> get props => [];
}

class TopInitEvent extends TopEvent {}

class TopLoadEvent extends TopEvent {}
