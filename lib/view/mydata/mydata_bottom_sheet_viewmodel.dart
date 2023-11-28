import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/data/models/health_instrumentation_response.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';
import 'package:ghealth_app/utils/etc.dart';

import '../../data/models/column_series_chart_data.dart';
import '../../data/models/default_series_chart_data.dart';
import '../../data/models/health_screening_data.dart';
import '../../utils/constants.dart';


class MyDataBottomSheetViewModel extends ChangeNotifier {
  final _postRepository = PostRepository();

  // 변환된 데이터를 담을 리스트
  late List<ColumnSeriesChartData> _columnDataList = [];
  late List<DefaultSeriesChartData> _defaultDataList = [];

  List<HealthScreeningData> _hearingAbilityList = [];

  List<ColumnSeriesChartData> get columnDataList => _columnDataList;
  List<DefaultSeriesChartData> get defaultDataList => _defaultDataList;
  List<HealthScreeningData> get hearingAbilityList => _hearingAbilityList;

  Future<void> handleInstrumentation(ScreeningsDataType screeningsDataType) async {
    try{
      HealthInstrumentationResponse response =
        await _postRepository.getHealthInstrumentationDio(screeningsDataType.label);

      if(response.status.code == '200'){
        convertDataAndPopulateList(response.data, screeningsDataType);
        notifyListeners();
      }
      else {
        // 200이 아닐경우
      }
    } on DioException catch (dioError){
    } catch (error){
    }
  }

  Future<void> handeBlood(BloodDataType bloodDataType) async {
    try{
      HealthInstrumentationResponse response =
      await _postRepository.getHealthBloodDio(bloodDataType.label);

      if(response.status.code == '200'){
        // 데이터 변환
        for (var data in response.data) {
          List<String> values = (data.dataValue).split(' ');

          double y1 = double.parse(values[0]);

          DefaultSeriesChartData chartData = DefaultSeriesChartData(
            x: Etc.defaultDateFormat(data.issuedDate),
            y1: y1,
          );
          _defaultDataList.add(chartData);
        }
        notifyListeners();
      }
      else {
      }
    } on DioException catch (dioError){

    } catch (error){
    }
  }

  /// 주어진 [dataList]를 특정 [dataType]에 따라 데이터를 변환하고,
  /// 해당 데이터를 적절한 목록에 추가하여 팝ULATE하는 메소드입니다.
  ///
  /// [dataType]은 화면에 표시할 데이터의 유형을 나타내며, [ScreeningsDataType] 중 하나여야 합니다.
  ///
  /// 시력 또는 혈압 데이터인 경우, 각 데이터를 '/'로 분리하고 첫 번째 값은 y1에, 두 번째 값은 y2에 대입하여
  /// [ColumnSeriesChartData] 객체를 생성하고 [columnDataList]에 추가합니다.
  ///
  /// 청력 데이터인 경우, 주어진 [dataList]를 [_hearingAbilityList]에 복사합니다.
  ///
  /// 그 외의 경우, 각 데이터를 공백으로 분리하고 첫 번째 값은 y1에 대입하여
  /// [DefaultSeriesChartData] 객체를 생성하고 [defaultDataList]에 추가합니다.
  ///
  /// 이 메소드를 호출하기 전에는 적절한 [dataType] 값이 전달되어야 합니다.
  void convertDataAndPopulateList(List<HealthScreeningData> dataList, ScreeningsDataType dataType) {
    if (dataType == ScreeningsDataType.vision ||
        dataType == ScreeningsDataType.bloodPressure) {
      // 시력 또는 혈압 데이터 변환
      List<ColumnSeriesChartData> tempDataList = dataList.map((data) {
        List<String> values = (data.dataValue).split('/');

        double y1 = double.parse(values[0]);
        double y2 = values.length > 1 ? double.parse(values[1].split(' ')[0]) : 0.0;

        return ColumnSeriesChartData(
          x: Etc.chartDateFormat(data.issuedDate),
          y1: y1,
          y2: y2,
        );
      }).toList();

      if(tempDataList.length > 5){
        _columnDataList = List.of(tempDataList.reversed.toList()
            .sublist(0, 5).reversed.toList());

      } else {
        _columnDataList = List.of(_columnDataList);
      }
    }

    else if (dataType == ScreeningsDataType.hearingAbility) {
      // 청력 데이터 변환
      _hearingAbilityList = List.of(dataList);
    }

    else {
      // 기타 데이터 변환
      List<DefaultSeriesChartData> tempDataList = dataList.map((data) {
        List<String> values = (data.dataValue).split(' ');
        double y1 = double.parse(values[0]);

        return DefaultSeriesChartData(
          x: Etc.chartDateFormat(data.issuedDate),
          y1: y1,
        );
      }).toList();

      if(tempDataList.length > 5){
       _defaultDataList = List.of(tempDataList.reversed.toList()
            .sublist(0, 5).reversed.toList());

      } else {
        _defaultDataList = List.of(_defaultDataList);
      }

    }
  }
}
