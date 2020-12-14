part of 'top_cubit.dart';

abstract class TopMangaState extends Equatable {
  const TopMangaState();

  @override
  List<Object> get props => [];
}

class TopInitial extends TopMangaState {}

class MangaTopLoading extends TopMangaState {}

class MangaTopLoaded extends TopMangaState {
  final List<Manga> topMangas;

  MangaTopLoaded({this.topMangas});
}
