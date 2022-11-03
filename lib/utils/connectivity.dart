import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  late StreamSubscription<ConnectivityResult> _subscription;
  late StreamController<ConnectivityResult> _networkStatusController;

  StreamSubscription<ConnectivityResult> get subscription => _subscription;
  StreamController<ConnectivityResult> get networkStatusController =>
      _networkStatusController;

  ConnectivityService(this._networkStatusController);

  checkNetwork() async {
    _networkStatusController.sink.add(await Connectivity().checkConnectivity());
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      _networkStatusController.sink.add(result);
    });
  }

  disposeStream() {
    _networkStatusController.close();
    _subscription.cancel();
  }
}
