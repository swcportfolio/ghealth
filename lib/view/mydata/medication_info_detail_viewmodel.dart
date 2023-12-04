

// ignore_for_file: use_build_context_synchronously, prefer_is_empty

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:ghealth_app/utils/my_exception.dart';

import '../../data/models/mediacation_info_response.dart';
import '../../data/models/medication_Info_data.dart';
import '../../data/repository/post_repository.dart';
import '../../main.dart';
import '../../utils/api_exception.dart';
import '../indicator_page.dart';

class MedicationInfoDetailViewModel extends ChangeNotifier {
  MedicationInfoDetailViewModel(this.context, this.pageIdx) {
    addScrollControllerListener(); // 스크롤 이벤트 리스너 등록
  }

  late BuildContext context;
  late int pageIdx;

  final _postRepository = PostRepository();
  final _scrollController = ScrollController();

  late List<MedicationInfoData> _medicationInfoDataList = [];

  List<MedicationInfoData> get medicationInfoDataList => _medicationInfoDataList;
  ScrollController get scrollController => _scrollController;


  Future<void> handleMedicationInfoDio() async {
    try{
      MedicationInfoResponse response
               = await _postRepository.getMedicationInfoDataDio(pageIdx);

     if(response.status.code == '200'){
       if (pageIdx == 1) {
         _medicationInfoDataList.clear();
         _medicationInfoDataList = List.of(response.data);
       }
       else { // 2페이지 이후 처리 로직
         Navigator.pop(context);

         _medicationInfoDataList = List.from(_medicationInfoDataList)
           ..addAll(response.data);

         if(response.data.length != 0){
           _scrollController.jumpTo(_scrollController.offset+1);
         }
       }
       notifyListeners();
     }
   } on DioException catch (dioError) {
     logger.e('=> $dioError');
     MyException.myDioException(dioError.type);
   }
 }

  addScrollControllerListener() {
    _scrollController.addListener(() {
      if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
          ++pageIdx;
          logger.d('=> pageIdx: $pageIdx');

          Navigator.push(context, IndicatorPage());
          Future.delayed(const Duration(seconds: 1), () {
            handleMedicationInfoDio();
          });
      }
    });
  }
}