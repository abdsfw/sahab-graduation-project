import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ConnectivityStatus { connected, disconnected }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  ConnectivityCubit() : super(ConnectivityStatus.connected);
  static ConnectivityCubit get(context) => BlocProvider.of(context);

  Future<ConnectivityStatus> checkInternetStatus() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      emit(ConnectivityStatus.disconnected);
      return ConnectivityStatus.disconnected;
    } else {
      emit(ConnectivityStatus.connected);
      return ConnectivityStatus.connected;
    }
  }
}
