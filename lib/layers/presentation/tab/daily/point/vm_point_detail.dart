

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../common/util/dio/dio_exceptions.dart';
import '../../../../../main.dart';
import '../../../../domain/usecase/ghealth/point_usecase.dart';
import '../../../../entity/point_history_dto.dart';


class PointDetailViewModelTest extends ChangeNotifier {
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  int _pageIdx = 1;

  PointDetailViewModelTest() {
    getPointHistory();
    addScrollControllerListener(); // 스크롤 이벤트 리스너 등록
  }

  final _scrollController = ScrollController();
  List<PointHistoryDataDTO> _pointHistoryList = [];

  ScrollController get scrollController => _scrollController;
  List<PointHistoryDataDTO> get pointHistoryList => _pointHistoryList;



  /// 포인트 이력 조회
  Future<void> getPointHistory() async {
    Map<String, dynamic> toMap = {
      'page': _pageIdx,
      'searchStartDate': '',
      'searchEndDate': '',
    };
    try {
      PointHistoryDTO? response = await PointHistoryUseCase().execute(toMap);

      if (response?.data != null && response?.status.code == '200') {
        if (_pageIdx == 1) {
          _pointHistoryList.clear();
          _pointHistoryList = List.of(response!.data!);
          _isLoading = false;
        } else {
          _pointHistoryList = List.from(_pointHistoryList)
          ..addAll(response!.data!);
        }
        _isLoading = false;
        notifyListeners();
      } else {
       logger.i('더이상 포인트 내역이 없습니다.');
      }
    } on DioException catch (e) {
      logger.i(e);
      final msg = DioExceptions.fromDioError(e).toString();
      notifyError(msg);
    } catch (e) {
      logger.i(e);
      const msg = '죄송합니다.\n예기치 않은 문제가 발생했습니다.';
      notifyError(msg);
    }
  }

  addScrollControllerListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 100) {
        if (_pointHistoryList.length % 10 == 0) {
          ++_pageIdx;
          getPointHistory();
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