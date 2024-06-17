
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../common/util/dio/dio_exceptions.dart';
import '../../../../domain/usecase/ghealth/medication_usecase.dart';
import '../../../../entity/drug_info_dto.dart';
import '../../../../model/enum/drug_info_type.dart';

class DrugInfoViewModelTest extends ChangeNotifier {

  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';
  BuildContext context;

  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  /// 처방 약 코드
  final String _medicationCode;

  DrugInfoViewModelTest(this.context, this._medicationCode){
    getDrugInfo();
  }

  DrugInfoDataDTO? _drugInfoDataDTO;

  String _medicationEtcTitle = '';
  String _medicationEtcContent = '';

  String _medicationIngredientTitle = '';
  String _medicationIngredientContent = '';

  String _medicationPropertiesTitle = '';
  String _medicationPropertiesContent = '';

  List<bool> _isSelectedList = List.generate(6, (int index) => false);

  List<bool> get isSelectedList => _isSelectedList;

  DrugInfoDataDTO? get drugInfoDataDTO => _drugInfoDataDTO;
  String get medicationEtcTitle => _medicationEtcTitle;
  String get medicationEtcContent => _medicationEtcContent;
  String get medicationIngredientTitle => _medicationIngredientTitle;
  String get medicationIngredientContent => _medicationIngredientContent;
  String get medicationPropertiesTitle => _medicationPropertiesTitle;
  String get medicationPropertiesContent => _medicationPropertiesContent;


  /// 투약 정보 상세
  Future<void> getDrugInfo() async {
    try {
      final medicationDTO = await DrugInfoUseCase().execute(_medicationCode);

      if (medicationDTO?.status.code == '200' && medicationDTO?.data != null) {
        _drugInfoDataDTO = medicationDTO!.data;
        _medicationEtcTitle = 'Q. 이 약은 어떻게 복약하는겁니까?';
        _medicationEtcContent = _drugInfoDataDTO!.info.replaceAll('복약정보\n\n', '');
        isSelectedList[0] = true;
        _isLoading = false;
        notifyListeners();
      } else {
        const msg = '죄송합니다.\n의약정보를 불러오지 못했습니다.';
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


  onPressedChip(DrugInfoType type) {
    _isSelectedList = List.generate(6, (int index) => false);

    switch (type) {
      case DrugInfoType.taking:
        {
          _medicationEtcTitle = 'Q. 이 약은 어떻게 복약하는겁니까?';
          _medicationEtcContent =
              _drugInfoDataDTO!.info.replaceAll('복약정보\n\n', '');
          isSelectedList[0] = true;
          break;
        }
      case DrugInfoType.usage:
        {
          _medicationEtcTitle = 'Q. 이 약의 용법 및 용량은?';
          _medicationEtcContent =
              _drugInfoDataDTO!.usage.replaceAll('용법 · 용량\n', '');
          isSelectedList[1] = true;
          break;
        }
      case DrugInfoType.efficacy:
        {
          _medicationEtcTitle = 'Q. 이 약의 효능 및 효과는?';
          _medicationEtcContent =
              _drugInfoDataDTO!.efficacy.replaceAll('효능 · 효과\n', '');
          isSelectedList[2] = true;
          break;
        }
      case DrugInfoType.advise:
        {
          _medicationEtcTitle = 'Q. 이 약의 주의사항은?';
          _medicationEtcContent =
              _drugInfoDataDTO!.precaution.replaceAll('사용상의 주의사항\n', '');
          isSelectedList[3] = true;
          break;
        }
      case DrugInfoType.dur:
        {
          _medicationEtcTitle = 'Q. 이 약의 DUR';
          _medicationEtcContent = _drugInfoDataDTO!.dur;
          isSelectedList[4] = true;
          break;
        }
      case DrugInfoType.basic:
        {
          _medicationEtcTitle = 'Q. 분류 번호';
          _medicationEtcContent = _drugInfoDataDTO!.classification;
          _medicationIngredientTitle = 'Q. 성분정보';
          _medicationIngredientContent = _drugInfoDataDTO!.ingredient;
          _medicationPropertiesTitle = 'Q. 성상';
          _medicationPropertiesContent = _drugInfoDataDTO!.properties;
          isSelectedList[5] = true;
        }
    }
    notifyListeners();
  }

  /// 에러 처리
  notifyError(String message) {
    _isLoading = false;
    _errorMessage = message;
    _isError = true;
    notifyListeners();
  }
}