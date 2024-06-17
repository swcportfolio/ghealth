import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../common/util/dio/dio_exceptions.dart';
import '../../../../../common/util/text_format.dart';
import '../../../../../main.dart';
import '../../../../domain/usecase/ghealth/physical_history_usecase.dart';
import '../../../../entity/summary_dto.dart';
import '../../../../model/enum/physical_type.dart';
import '../../../../model/vo_column_series_chart.dart';
import '../../../../model/vo_default_serises_chart.dart';

class PhysicalBottomSheetViewModel extends ChangeNotifier {
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  PhysicalBottomSheetViewModel(PhysicalType type){
    getPhysicalHistory(type);
  }

  // 변환된 데이터를 담을 리스트
  List<ColumnSeriesChartData> _columnDataList = [];
  List<DefaultSeriesChartData> _defaultDataList = [];
  List<HealthScreeningDTO> _hearingAbilityList = [];

  List<ColumnSeriesChartData> get columnDataList => _columnDataList;
  List<DefaultSeriesChartData> get defaultDataList => _defaultDataList;
  List<HealthScreeningDTO> get hearingAbilityList => _hearingAbilityList;

  Future<void> getPhysicalHistory(PhysicalType type) async {
    try {
      final physicalDTO = await PhysicalHistoryCase().execute(type.label);
      if (physicalDTO?.status.code == '200' && physicalDTO?.data != null) {
        convertDataAndPopulateList(physicalDTO!.data, type);

        _isLoading = false;
        notifyListeners();
      } else {
        const msg = '측정된 데이터가 없습니다.';
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





  // Future<dynamic> handleInstrumentation(PhysicalType type) async {
  //   try{
  //     final response = await _postRepository.getHealthInstrumentationDio(type.label);
  //
  //     if(response.status.code == '200'){
  //       convertDataAndPopulateList(response.data, type);
        // if(type == PhysicalType.hearingAbility){
        //   return _hearingAbilityList;
        // } else  if(type == PhysicalType.vision || type == PhysicalType.bloodPressure){
        //   return _columnDataList;
        // } else {
        //   return _defaultDataList;
        // }
  //    }
  //     else {
  //       return [];
  //     }
  //   } on DioException catch (dioError){
  //     logger.e('=> $dioError');
  //     throw MyException.myDioException(dioError.type);
  //   } catch (error){
  //     logger.e('=> $error');
  //     throw Exception(error);
  //   }
  // }

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
  convertDataAndPopulateList(List<HealthScreeningDTO> dataList, PhysicalType dataType) {

    if (dataType == PhysicalType.vision || dataType == PhysicalType.bloodPressure) {
      /// 시력 또는 혈압 데이터 변환
      List<ColumnSeriesChartData> tempDataList = dataList.map((data) {
        List<String> values = (data.dataValue).split('/');

        double y1 = double.parse(values[0]);
        double y2 = values.length > 1 ? double.parse(values[1].split(' ')[0]) : 0.0;

        return ColumnSeriesChartData(
          x: TextFormat.seriesChartXAxisDateFormat(data.issuedDate),
          y1: y1,
          y2: y2,
        );
      }).toList();

      if(tempDataList.length > 5){
        _columnDataList = List.of(tempDataList.reversed.toList()
            .sublist(0, 5).reversed.toList());

      } else {
        _columnDataList = List.of(tempDataList);
      }
    }


    else if (dataType == PhysicalType.hearingAbility) {
      /// 청력 데이터 변환
      _hearingAbilityList = List.of(dataList);
    }

    else {
      /// 기타 데이터 변환
      List<DefaultSeriesChartData> tempDataList = dataList.map((data) {
        List<String> values = (data.dataValue).split(' ');
        double y1 = double.parse(values[0]);

        return DefaultSeriesChartData(
          x: TextFormat.seriesChartXAxisDateFormat(data.issuedDate),
          y1: y1,
        );
      }).toList();

      if(tempDataList.length > 5){
       _defaultDataList = List.of(tempDataList.reversed.toList()
            .sublist(0, 5).reversed.toList());
      } else {
        _defaultDataList = List.of(tempDataList);
      }
    }

    notifyListeners();
  }
}
