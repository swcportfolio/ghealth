import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/layers/domain/usecase/ghealth/lifelog_result_uescase.dart';

import '../../../../common/util/dio/dio_exceptions.dart';
import '../../../entity/lifelog_result_dto.dart';
import '../../../model/enum/lifelog_data_type.dart';

class LifeLogBottomSheetViewModel extends ChangeNotifier {
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  LifeLogBottomSheetViewModel(LifeLogDataType type, String selectedDate){
    getLifeLogResult(type, selectedDate);
  }

  /// 라이프로그 건강검진 결과 데이터 리스트
  List<LifeLogData> _lifeLogDataList = [];

  List<LifeLogData> get lifeLogDataList => _lifeLogDataList;


  /// 라이프로그 건겅검진 결과 데이터 조회
  Future<void> getLifeLogResult(LifeLogDataType type, String selectedDate) async {
    try {
      final lifeLogResultDTO = await LifeLogResultUseCase()
          .execute({'deviceID': type.id, 'date': selectedDate});

      if (lifeLogResultDTO?.status.code == '200' && lifeLogResultDTO?.data != null) {
        _lifeLogDataList = List.of(lifeLogResultDTO!.data);

        _isLoading = false;
        notifyListeners();
      }
    } on DioException catch (e) {
      final msg = DioExceptions.fromDioError(e).toString();
      notifyError(msg);
    } catch (e) {
      const msg = '죄송합니다.\n예기치 않은 문제가 발생했습니다.';
      notifyError(msg);
    }
  }

  /// 에러 처리
  notifyError(String message){
    _isLoading = false;
    _errorMessage = message;
    _isError = true;
    notifyListeners();
  }
}
