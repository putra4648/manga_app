part of 'schedule_bloc.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoadedSuccess extends ScheduleState {
  final List<Manga> mangas;

  const ScheduleLoadedSuccess({this.mangas});
}

class ScheduleFailure extends ScheduleState {}
