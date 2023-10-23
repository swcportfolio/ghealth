

abstract class ConnectivityObserver {
  Stream<NetWorkStatus> observe();
  Future<NetWorkStatus> checkNoneConnectivity();
}

enum NetWorkStatus {
  available,
  unavailable
}
