import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';
import 'package:ghealth_app/utils/my_exception.dart';

import '../../data/models/health_report_response.dart';
import '../../data/models/lifelog_data.dart';
import '../../main.dart';
import '../../utils/enum/lifelog_data_type.dart';


class LifeLogBottomSheetViewModel extends ChangeNotifier {

  late String selectedDate;
  LifeLogBottomSheetViewModel(this.selectedDate);
  final _postRepository = PostRepository();

  /// 라이프로그 건강검진 결과 데이터 리스트
  List<LifeLogData> _lifeLogDataList = [];

  List<LifeLogData> get lifeLogDataList => _lifeLogDataList;

  /// 라이프로그 건겅검진 결과 데이터 조회
  Future<List<LifeLogData>> handleLifeLogResult(LifeLogDataType dataType) async {
    try{
      HealthReportResponse response =
              await _postRepository.getHealthReportLifeLogDio(dataType.id, selectedDate);

      if(response.status.code == '200'){
        _lifeLogDataList = List.of(response.data);
        return _lifeLogDataList;
      }
      else {
        return _lifeLogDataList;
      }
    } on DioException catch (dioError){
      logger.e('=> $dioError');
      MyException.myDioException(dioError.type);
    }
    return _lifeLogDataList;
  }
}
