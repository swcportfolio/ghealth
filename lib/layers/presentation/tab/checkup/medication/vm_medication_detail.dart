

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../common/util/dio/dio_exceptions.dart';
import '../../../../domain/usecase/ghealth/medication_usecase.dart';
import '../../../../entity/summary_dto.dart';

class MedicationDetailViewModelTest extends ChangeNotifier {
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';
  BuildContext context;

  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  MedicationDetailViewModelTest(this.context){
    getMedicationInfo();
    addScrollListener();
  }

  /// 약 처방 더보기 화면 인덱스
  int _medicationPageIndex = 1;

  /// 전체 히스토리 스크롤 컨트롤러
  final _scrollController = ScrollController();

  /// 처방 이력 리스트
  late List<MedicationInfoDTO> _medicationList = [];

  ScrollController get scrollController => _scrollController;
  List<MedicationInfoDTO>  get medicationList => _medicationList;

  /// 약처방 조회
  Future<void> getMedicationInfo() async {
    try{
      final medicationDTO = await MedicationUseCase().execute(_medicationPageIndex);

      if (medicationDTO?.status.code == '200' && medicationDTO?.data != null) {
        if(_medicationPageIndex == 1){
          _medicationList.clear();
          _medicationList = medicationDTO!.data;
        } else {
          _medicationList = List.from(_medicationList)
            ..addAll(medicationDTO!.data);
        }
        _isLoading = false;
        notifyListeners();
      } else {

      }
    } on DioException catch (e) {
      final msg = DioExceptions.fromDioError(e).toString();
      notifyError(msg);
    } catch (e) {
      const msg = '죄송합니다.\n예기치 않은 문제가 발생했습니다.';
      notifyError(msg);
    }
  }


  /// 스크롤 이벤트 등록
  /// 히스토리 전체보기에서 스크롤시 하단에 근접하면
  /// 다음 페이지 데이터를 불러온다.
  addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 100) {
        if (_medicationList.length % 10 == 0) {
          ++_medicationPageIndex;
          getMedicationInfo();
        }
      }
    });
  }


  /// 에러 처리
  notifyError(String message){
    _isLoading = false;
    _errorMessage = message;
    _isError = true;
    notifyListeners();
  }
}