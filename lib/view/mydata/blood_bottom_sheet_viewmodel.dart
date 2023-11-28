import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/data/models/health_instrumentation_response.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';
import 'package:ghealth_app/utils/etc.dart';

import '../../data/models/blood_series_chart_data.dart';
import '../../data/models/health_screening_data.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';


class BloodBottomSheetViewModel extends ChangeNotifier {
  final _postRepository = PostRepository();

  // 변환된 데이터를 담을 리스트
  late List<BloodSeriesChartData> _defaultDataList = [];

  List<BloodSeriesChartData> get defaultDataList => _defaultDataList;

  Future<void> handeBlood(BloodDataType bloodDataType) async {
    try{
      HealthInstrumentationResponse response =
      await _postRepository.getHealthBloodDio(bloodDataType.label);

      if(response.status.code == '200'){
        // 데이터 변환
        List<BloodSeriesChartData> tempDataList = response.data.map((data) {
          List<String> values = (data.dataValue).split(' ');
          double y1 = double.parse(values[0]);

          return BloodSeriesChartData(
            x: Etc.chartDateFormat(data.issuedDate),
            y1: y1,
            barColor: Etc.calculateBloodStatusColor(bloodDataType, y1,
                badColor:Colors.red, goodColor: mainColor),
          );
        }).toList();

        if(tempDataList.length>5){
          _defaultDataList = List.of(tempDataList.reversed.toList()
              .sublist(0, 5).reversed.toList());

        } else {
          _defaultDataList = List.of(_defaultDataList);
        }
        notifyListeners();
      }
      else {
      }
    } on DioException catch (dioError){

    } catch (error){
    }
  }

  void convertDataAndPopulateList(List<HealthScreeningData> dataList, ScreeningsDataType dataType) {

    }
}
