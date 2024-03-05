import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/data/models/health_instrumentation_response.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';
import 'package:ghealth_app/utils/etc.dart';

import '../../../data/enum/blood_type.dart';
import '../../../data/models/blood_series_chart_data.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';

import '../../../utils/my_exception.dart';
import '../../../utils/text_formatter.dart';


class BloodBottomSheetViewModel extends ChangeNotifier {
  final _postRepository = PostRepository();

  // 변환된 데이터를 담을 리스트
  late List<BloodSeriesChartData> _defaultDataList = [];
  List<BloodSeriesChartData> get defaultDataList => _defaultDataList;

  Future<List<BloodSeriesChartData>> handeBlood(BloodDataType bloodDataType) async {
    try{
      HealthInstrumentationResponse response =
      await _postRepository.getHealthBloodDio(bloodDataType.label);

      if(response.status.code == '200'){
        List<BloodSeriesChartData> tempDataList = response.data.map((data) {
          List<String> values = (data.dataValue).split(' ');
          double y1 = double.parse(values[0]);

          return BloodSeriesChartData(
            x: TextFormatter.seriesChartXAxisDateFormat(data.issuedDate),
            y1: y1,
            barColor: Etc.calculateBloodStatusColor(bloodDataType, y1,
                badColor:Colors.red, goodColor: mainColor),
          );
        }).toList();

        /// 혈액 검사 데이터가 6개 이상일떄
        /// if.최대 5개까지 if.최근 검사 데이터
        ///
        /// 1~5개까지 그대로 Return
        if(tempDataList.length>5){
          _defaultDataList = List.of(tempDataList.reversed.toList()
              .sublist(0, 5).reversed.toList());
        } else {
          _defaultDataList = List.of(tempDataList);
        }
        return _defaultDataList;
      }
      else {
        return [];
      }
    } on DioException catch (dioError){
      logger.e('=> $dioError');
      throw MyException.myDioException(dioError.type);
    } catch (error){
      logger.e('=> $error');
      throw Exception(error);
    }
  }
}
