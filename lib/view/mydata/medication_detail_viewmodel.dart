
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';
import 'package:ghealth_app/view/mydata/medication_detail_view.dart';

import '../../data/models/medication_detail.dart';
import '../../data/models/medication_detail_response.dart';
import '../../main.dart';
import '../../utils/my_exception.dart';

class MedicationDetailViewModel extends ChangeNotifier {
  final _postRepository = PostRepository();

  /// 처방 약 코드
  late String medicationCode;
  MedicationDetailViewModel(this.medicationCode);

  late MedicationDetailData? _medicationDetailData;

  String medicationEtcTitle = '';
  String medicationEtcContent = '';

  List<bool> _isSelectedList = List.generate(6, (int index) => false);

  List<bool> get isSelectedList => _isSelectedList;
  MedicationDetailData? get medicationDetailData => _medicationDetailData;

  /// 투약 정보 상세
  Future<MedicationDetailData?> handleMedicationDetail() async {
    logger.i('medicationCode: $medicationCode');
    try{
      MedicationDetailResponse response = await _postRepository.getMedicationDetail(medicationCode);

      if(response.status.code == '200') {
        _medicationDetailData = response.data;
        medicationEtcTitle = 'Q. 이 약은 어떻게 복약하는겁니까?';
        medicationEtcContent = _medicationDetailData!.info.replaceAll('복약정보\n\n', '');
        isSelectedList[0] = true;
        return medicationDetailData;
      } else {
        return null;
      }

    }  on DioException catch (dioError) {
      logger.e('=> $dioError');
      MyException.myDioException(dioError.type);
    }
    return null;
  }

  void onPressedChip(MedicationInfoType type) {
    _isSelectedList = List.generate(6, (int index) => false);

    switch(type) {
      case MedicationInfoType.taking: {
        medicationEtcTitle = 'Q. 이 약은 어떻게 복약하는겁니까?';
        medicationEtcContent = medicationDetailData!.info.replaceAll('복약정보\n\n', '');
        isSelectedList[0] = true;
        break;
      }
      case MedicationInfoType.usage: {
        medicationEtcTitle = 'Q. 이 약의 용법 및 용량은?';
        medicationEtcContent = medicationDetailData!.usage.replaceAll('용법 · 용량\n', '');
        isSelectedList[1] = true;
        break;
      }
      case MedicationInfoType.efficacy: {
        medicationEtcTitle = 'Q. 이 약의 효능 및 효과는?';
        medicationEtcContent = medicationDetailData!.efficacy.replaceAll('효능 · 효과\n', '');
        isSelectedList[2] = true;
        break;
      }
      case MedicationInfoType.advise: {
        medicationEtcTitle = 'Q. 이 약의 주의사항은?';
        medicationEtcContent = medicationDetailData!.precaution.replaceAll('사용상의 주의사항\n', '');
        isSelectedList[3] = true;
        break;
      }
      case MedicationInfoType.dur: {
        medicationEtcTitle = 'Q. 이 약의 DUR';
        medicationEtcContent = medicationDetailData!.dur;
        isSelectedList[4] = true;
        break;
      }
      case MedicationInfoType.basic:{
        medicationEtcTitle = 'Q. 기본 미구현';
        medicationEtcContent = medicationDetailData!.classification;
        isSelectedList[5] = true;
      }
    }
    notifyListeners();
  }

}