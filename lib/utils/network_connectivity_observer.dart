
import 'package:connectivity_plus/connectivity_plus.dart';
import '../main.dart';
import '../services/connectivity_observer.dart';

class NetworkConnectivityObserver implements ConnectivityObserver {
  final _connectivity =  Connectivity();

  /// 네트워크 연결 변화를 관찰하는 함수
  /// 연결 시 [Status.available]값을 리턴한다
  /// 미 연결시 [Status.unavailable] 값을 리턴한다.
  @override
  Stream<NetWorkStatus> observe() {
    return _connectivity.onConnectivityChanged.where((event) {
      return event == ConnectivityResult.wifi ||
          event == ConnectivityResult.ethernet ||
          event == ConnectivityResult.mobile ||
          event == ConnectivityResult.other ||
          event == ConnectivityResult.none;
    }).map((event) {
      logger.i('event: $event');
      switch(event) {
        case ConnectivityResult.none:
          return NetWorkStatus.unavailable;
        default: return NetWorkStatus.available;
      }
    });
  }

  /// 앱 실행시 네트워크가 연결 상태 확인
  /// 문제해결을 위한 함수([observe] 함수의 경우 네트워크가 미 연결상태에서
  /// 앱 실행시 [ConnectivityResult.none] 값을 응답하지 않아 해결책으로
  /// [checkNoneConnectivity] 함수를 구현 했다.
  /// 이 함수는 최초 앱 실행 구에서 실행하면 된다.
  /// 연결된 상태로 실행이 됬는지, 미연결 상태로 실행이 됬는지 확인 한다.
  /// 미 연결상태일때만 스낵바를 띄워준다.
  @override
  Future<NetWorkStatus> checkNoneConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if(connectivityResult == ConnectivityResult.none){
      return NetWorkStatus.unavailable;
    } else {
      return NetWorkStatus.available;
    }
  }


}