

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../common/util/dio/dio_exceptions.dart';
import '../../../domain/usecase/ghealth/ai_health_usecase.dart';
import '../../../entity/ai_health_dto.dart';

class AiHealthViewModelTest extends ChangeNotifier {
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  AiHealthViewModelTest(){
    getAiHealth();
  }

  /// AI Health 결과 데이터
  /// 마이데이터 기반으로 생성된 예측 데이터
  AiHealthData? _aiHealthData;

  AiHealthData? get aiHealthData => _aiHealthData;


  /// 마이데이터 기반 AI 건강 예측 데이터 조회
  Future<void> getAiHealth() async {
    try{
      AiHealthDTO? response = await AiHealthUseCase().execute();

      if (response?.status.code == '200' && response?.data != null) {
        _aiHealthData = response!.data;
        _isLoading = false;
        notifyListeners();
      } else {
        const msg = '죄송합니다.\n예기치 않은 문제가 발생했습니다.';
        notifyError(msg);
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