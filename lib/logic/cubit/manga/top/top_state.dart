part of 'top_bloc.dart';

abstract class TopState extends Equatable {
  const TopState();

  @override
  List<Object> get props => [];
}

class TopInitial extends TopState {}

class TopLoading extends TopState {}

class TopLoadedSuccess extends TopState {
  final List<Manga> tops;
  final bool isEmpty;

  TopLoadedSuccess({this.tops, this.isEmpty});

  TopLoadedSuccess copyWith({
    List<Manga> tops,
    bool isEmpty,
  }) {
    return TopLoadedSuccess(
      tops: tops ?? this.tops,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }

  @override
  List<Object> get props => [tops, isEmpty];
}

class TopFailure extends TopState {}
