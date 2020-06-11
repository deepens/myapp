import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';

enum ConnectivityStatus { WiFi, Cellular, Offline }

class ConnectivityService {
  // Create our public controller
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  ConnectivityService() {
    // Subscribe to the connectivity Chanaged Steam
    //final Connectivity _connectivity = Connectivity();
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      connectionStatusController.add(_getStatusFromResult(result));
      if (_getStatusFromResult(result) == ConnectivityStatus.Cellular) {
        checkinternet().then((isnetworking) {
          if (isnetworking) {
            connectionStatusController.add(ConnectivityStatus.Cellular);
          } else {
            connectionStatusController.add(ConnectivityStatus.Offline);
          }
        });
      } else if (_getStatusFromResult(result) == ConnectivityStatus.WiFi) {
        checkinternet().then((isnetworking) {
          if (isnetworking) {
            connectionStatusController.add(ConnectivityStatus.Cellular);
          } else {
            connectionStatusController.add(ConnectivityStatus.Offline);
          }
        });
      } else {
        connectionStatusController.add(ConnectivityStatus.Offline);
      }
    });
  }

  Future<bool> checkinternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } on SocketException catch (_) {
      return Future.value(false);
    }
  }

  // Convert from the third part enum to our own enum
  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        {
          return ConnectivityStatus.Cellular;
        }
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }
}
