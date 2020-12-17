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

  TopLoadedSuccess({this.tops});

  TopLoadedSuccess copyWith({
    List<Manga> tops,
  }) {
    return TopLoadedSuccess(
      tops: tops ?? this.tops,
    );
  }

  @override
  List<Object> get props => [tops];
}

class TopFailure extends TopState {}
