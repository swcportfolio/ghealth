
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';

import '../../data/models/record_date_response.dart';
import '../../main.dart';
import '../../utils/my_exception.dart';

class HealthCenterRecordViewModel extends ChangeNotifier{
  final _postRepository = PostRepository();

  /// 건강관리소에서 검진 이후 방문 날짜 리스트
  List<String> _recordDateList = [];

  List<String> get recordDateList => _recordDateList;


  /// 선택 할 날짜 죄회
  /// 마이데이터 전체 데이터 조회
  Future<List<String>> handleLookupDate() async {
    try{
      RecordDateResponse response = await _postRepository.getRecordDateDio();

      if(response.status.code == '200') {
        logger.d("나의 일상기록 계측검사 날짜데이터: ${response.data.length}");
        _recordDateList = List.of(response.data).cast<String>().toList();

        return _recordDateList;
      } else {
        return _recordDateList;
      }
    }  on DioException catch (dioError) {
      logger.e('=> $dioError');
      MyException.myDioException(dioError.type);
    }
    return _recordDateList;
  }
}