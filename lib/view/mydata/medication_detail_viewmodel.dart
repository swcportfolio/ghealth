
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

  String _medicationEtcTitle = '';
  String _medicationEtcContent = '';

  String _medicationIngredientTitle = '';
  String _medicationIngredientContent = '';

  String _medicationPropertiesTitle = '';
  String _medicationPropertiesContent = '';

  List<bool> _isSelectedList = List.generate(6, (int index) => false);

  List<bool> get isSelectedList => _isSelectedList;
  MedicationDetailData? get medicationDetailData => _medicationDetailData;

  String get medicationEtcTitle => _medicationEtcTitle;
  String get medicationEtcContent => _medicationEtcContent;
  String get medicationIngredientTitle => _medicationIngredientTitle;
  String get medicationIngredientContent => _medicationIngredientContent;
  String get medicationPropertiesTitle => _medicationPropertiesTitle;
  String get medicationPropertiesContent => _medicationPropertiesContent;

  /// 투약 정보 상세
  Future<MedicationDetailData?> handleMedicationDetail() async {
    logger.i('medicationCode: $medicationCode');
    try{
      MedicationDetailResponse response = await _postRepository.getMedicationDetail(medicationCode);

      if(response.status.code == '200') {
        _medicationDetailData = response.data;
        _medicationEtcTitle = 'Q. 이 약은 어떻게 복약하는겁니까?';
        _medicationEtcContent = _medicationDetailData!.info.replaceAll('복약정보\n\n', '');
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

   onPressedChip(MedicationInfoType type) {
    _isSelectedList = List.generate(6, (int index) => false);

    switch(type) {
      case MedicationInfoType.taking: {
        _medicationEtcTitle = 'Q. 이 약은 어떻게 복약하는겁니까?';
        _medicationEtcContent = medicationDetailData!.info.replaceAll('복약정보\n\n', '');
        isSelectedList[0] = true;
        break;
      }
      case MedicationInfoType.usage: {
        _medicationEtcTitle = 'Q. 이 약의 용법 및 용량은?';
        _medicationEtcContent = medicationDetailData!.usage.replaceAll('용법 · 용량\n', '');
        isSelectedList[1] = true;
        break;
      }
      case MedicationInfoType.efficacy: {
        _medicationEtcTitle = 'Q. 이 약의 효능 및 효과는?';
        _medicationEtcContent = medicationDetailData!.efficacy.replaceAll('효능 · 효과\n', '');
        isSelectedList[2] = true;
        break;
      }
      case MedicationInfoType.advise: {
        _medicationEtcTitle = 'Q. 이 약의 주의사항은?';
        _medicationEtcContent = medicationDetailData!.precaution.replaceAll('사용상의 주의사항\n', '');
        isSelectedList[3] = true;
        break;
      }
      case MedicationInfoType.dur: {
        _medicationEtcTitle = 'Q. 이 약의 DUR';
        _medicationEtcContent = medicationDetailData!.dur;
        isSelectedList[4] = true;
        break;
      }
      case MedicationInfoType.basic:{
        _medicationEtcTitle = 'Q. 분류 번호';
        _medicationEtcContent = medicationDetailData!.classification;
        _medicationIngredientTitle = 'Q. 성분정보';
        _medicationIngredientContent = medicationDetailData!.ingredient;
        _medicationPropertiesTitle = 'Q. 성상';
        _medicationPropertiesContent = medicationDetailData!.properties;
        isSelectedList[5] = true;
      }
    }
    notifyListeners();
  }

}