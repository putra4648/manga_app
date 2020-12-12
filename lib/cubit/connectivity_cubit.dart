import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity connectivity;
  StreamSubscription connSubscription;
  ConnectivityCubit({@required this.connectivity})
      : super(ConnectionLoading()) {
    connSubscription = connectivity.onConnectivityChanged.listen((conn) {
      connectionResult(conn);
    });
  }

  void connectionResult(ConnectivityResult result) {
    emit(ConnectionLoading());
    emit(ConnectionResult(connectivityResult: result));
  }

  @override
  Future<void> close() {
    connSubscription?.cancel();
    return super.close();
  }
}
