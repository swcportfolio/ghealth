import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/common/common.dart';

import '../../../../../common/util/dio/dio_exceptions.dart';
import '../../../../../common/util/text_format.dart';
import '../../../../domain/usecase/ghealth/blood_history_usecase.dart';
import '../../../../model/enum/blood_data_type.dart';
import '../../../../model/vo_blood_chart.dart';

class BloodBottomSheetViewModel extends ChangeNotifier {
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  BloodBottomSheetViewModel(BloodDataType type) {
    getBloodHistory(type);
  }

  /// 변환된 데이터를 담을 리스트
  late List<BloodChartData> _defaultDataList = [];

  List<BloodChartData> get defaultDataList => _defaultDataList;


  Future<void> getBloodHistory(BloodDataType type) async {
    try {
      final bloodHistoryDTO = await BloodHistoryCase().execute(type.label);
      if (bloodHistoryDTO?.status.code == '200' &&
          bloodHistoryDTO?.data != null) {
        List<BloodChartData> tempDataList = bloodHistoryDTO!.data.map((data) {
          List<String> values = (data.dataValue).split(' ');
          double y1 = double.parse(values[0]);

          return BloodChartData(
            x: TextFormat.seriesChartXAxisDateFormat(data.issuedDate),
            y1: y1,
            barColor: Branch.calculateBloodStatusColor(
              type,
              y1,
              badColor: Colors.red,
              goodColor: AppColors.primaryColor,
            ),
          );
        }).toList();


        /// 혈액 검사 데이터가 6개 이상일떄
        /// if.최대 5개까지 if.최근 검사 데이터
        ///
        /// 1~5개까지 그대로 Return
        if (tempDataList.length > 5) {
          _defaultDataList = List.of(tempDataList.reversed
              .toList()
              .sublist(0, 5)
              .reversed
              .toList());
        } else {
          _defaultDataList = List.of(tempDataList);
        }

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
}
