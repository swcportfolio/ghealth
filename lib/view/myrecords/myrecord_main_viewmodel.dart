

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/data/models/total_point_response.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/authorization.dart';
import '../../data/models/picker_data.dart';
import '../../main.dart';
import '../../utils/constants.dart';
import '../../utils/my_exception.dart';
import '../../widgets/custom_picker.dart';
import 'myrecord_main_view.dart';

class MyRecordMainViewModel extends ChangeNotifier {
  MyRecordMainViewModel(this.context, this.targetSleep, this.targetStep);

  late BuildContext context;
  final _postRepository = PostRepository();

  /// 총 포인트
  String _totalPoint = '0';

  /// 목표 수면
  late String targetSleep;

  /// 목표 걸음
  late String targetStep;

  String get totalPoint => _totalPoint;

  Future<void> handleTotalPoint() async {
   try {
     TotalPointResponse response = await _postRepository.getTotalPointDio();
     if(response.status.code == '200'){
       _totalPoint = response.data.toString();
       logger.i('totalPoint: $_totalPoint');
       notifyListeners();
     } else {
       logger.i('code: ${response.status.code}');
       logger.i('message: ${response.status.message}');
       notifyListeners();
     }
   }  on DioException catch (dioError) {
     logger.e('=> $dioError');
     MyException.myDioException(dioError.type);
   }
  }

  showCustomDialog(HealthDataType type){
    CustomPicker().showBottomSheet(
        PickerData(19, type == HealthDataType.sleep ? Constants.targetSleepList: Constants.targetStepsList, context,
                (callbackData)=> onGetPickerData(callbackData)));
  }

  /// Number picker Function callback
  /// @param callbackData : 반환 값
  onGetPickerData(callbackData) {
      int getPickerData = int.parse(callbackData.toString());
      if(getPickerData<1000){ // 수면시간
        targetSleep = getPickerData.toString();
        Authorization().targetSleep = targetSleep;
        saveStringData('targetSleep', targetSleep);
      } else { // 걸음수
        targetStep = getPickerData.toString();
        Authorization().targetStep = targetStep;
        saveStringData('targetStep', targetStep);
      }
      logger.i(getPickerData.toString());
      notifyListeners();
  }

  /// SharedPreferences local data save
  void saveStringData(String key , String data) async{
    var pref = await SharedPreferences.getInstance();
    pref.setString(key,data);
  }
}