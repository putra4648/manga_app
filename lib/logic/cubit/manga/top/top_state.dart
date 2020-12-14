part of 'top_cubit.dart';

abstract class TopMangaState extends Equatable {
  const TopMangaState();

  @override
  List<Object> get props => [];
}

class TopInitial extends TopMangaState {}

class TopMangaLoading extends TopMangaState {}

class TopMangaLoaded extends TopMangaState {
  final List<Manga> topMangas;

  TopMangaLoaded({this.topMangas});
}

class TopMangaFailure extends TopMangaState {}
