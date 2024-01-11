
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/data/models/ai_health_response.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';

import '../../data/models/ai_health_data.dart';
import '../../main.dart';
import '../../utils/my_exception.dart';

class AiHealthMainViewModel extends ChangeNotifier {
  final _postRepository = PostRepository();
  late AiHealthData _aiHealthData;

  AiHealthData get aiHealthData => _aiHealthData;

  /// 마이데이터 기반 AI 건강 예측 데이터 가져오기
  Future<AiHealthData?> handleAiHealth() async {
    try{
      AiHealthResponse response = await _postRepository.getAiHealthDataDio();

      if(response.status.code == '200'){
        _aiHealthData = response.data;
        notifyListeners();

        return _aiHealthData;
      }
      else {
        return null;
      }
    } on DioException catch (dioError){
      logger.e('=> $dioError');
      MyException.myDioException(dioError.type);
    }
    return null;
  }
}