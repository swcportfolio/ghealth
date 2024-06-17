

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/layers/presentation/tab/reservation/vm_reservation.dart';

import '../../../../../common/util/dio/dio_exceptions.dart';
import '../../../../../main.dart';
import '../../../../widgets/dialog.dart';
import '../../../domain/usecase/ghealth/reservation_usecase.dart';
import '../../../entity/reservation_dto.dart';
import '../../../model/enum/region_type.dart';

class ReservationHistoryViewModelTest extends ChangeNotifier {
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';
  BuildContext context;

  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  ReservationHistoryViewModelTest(this.context) {
    addScrollListener(); // 스크롤 이벤트 리스너 등록
    getReservationHistory();
  }

  /// 예약 히스토리 페이지 인덱스
  int _page = 1;

  /// 예약 내역 히스토리 데이터 리스트
  List<ReservationDataDTO> _historyList = [];

  /// 예약 히스토리 화면 스크롤 컨트롤
  final _scrollController = ScrollController();

  List<ReservationDataDTO> get historyList => _historyList;
  ScrollController get scrollController => _scrollController;


  /// 예약 히시트로 조회
  Future<void> getReservationHistory() async {
    try{
      ReservationHistoryDTO? response = await ReservationHistoryUseCase().execute(_page);
      logger.i(response?.data);

      if (response?.status.code == '200'&& response!.data.isNotEmpty) {
        if (_page == 1) {
          _historyList.clear();
          _historyList = List.of(response.data);
        }
        else { // 2페이지 이후 처리 로직
          _historyList = List.from(_historyList)
            ..addAll(response.data);
        }
      } else {
        _historyList.clear();
      }
      _isLoading = false;
      notifyListeners();
    } on DioException catch (e) {
      final msg = DioExceptions.fromDioError(e).toString();
      notifyError(msg);
    } catch (e) {
      const msg = '죄송합니다.\n예기치 않은 문제가 발생했습니다.';
      notifyError(msg);
    }
  }


  /// 예약 취소
  Future<void> handleCancelReservation(int reservationIdx, RegionType orgType) async {
    try {
      ReservationStatueDTO? response =
      await ReservationCancelUseCase().execute({
        "serviceType": "lifelog",
        "reservationIdx": reservationIdx,
        "orgType": orgType.label,
      });
      if (response?.status.code == '200') {
        //TODO 텍스트가 넘어가는지 확인 해야됨
        _showReservationDialog('방문 예약이 취소되었습니다.');
        initScreen();
      } else {
        _showReservationDialog('방문 예약 취소가\n정상적으로 처리되지 못했습니다.');
      }
      initScreen();
    } on DioException catch (e) {
      logger.e(e);
      _showReservationDialog('방문 예약 취소가\n정상적으로 처리되지 못했습니다.');
    } catch (e) {
      logger.e(e);
      _showReservationDialog('방문 예약 취소가\n정상적으로 처리되지 못했습니다.');
    }
  }


  /// 예약 다이얼로그를 표시합니다.
  void _showReservationDialog(String message) {
    CustomDialog.showMyDialog(
      title: '예약',
      content: message,
      mainContext: context,
    );
  }


  /// 화면 초기화
  initScreen(){
    _isLoading = true;
    getReservationHistory();
  }


  /// 스크롤 이벤트 등록
  /// 히스토리 전체보기에서 스크롤시 하단에 근접하면
  /// 다음 페이지 데이터를 불러온다.
  addScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 100) {
        if (_historyList.length % 10 == 0) {
          ++_page;
          getReservationHistory();
        }
      }
    });
  }


  /// 에러 처리
  notifyError(String message){
    _isLoading = false;
    _errorMessage = message;
    _isError = true;
    notifyListeners();
  }
}