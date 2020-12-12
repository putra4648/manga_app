part of 'connectivity_cubit.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

class ConnectionLoading extends ConnectivityState {}

class ConnectionResult extends ConnectivityState {
  final ConnectivityResult connectivityResult;

  ConnectionResult({this.connectivityResult});
}
