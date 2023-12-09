
// ignore_for_file: use_build_context_synchronously, prefer_is_empty

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';
import 'package:ghealth_app/utils/my_exception.dart';

import '../../data/models/reservation_data.dart';
import '../../data/models/reservation_default_response.dart';
import '../../data/models/reservation_history_response.dart';
import '../../main.dart';
import '../../utils/etc.dart';
import '../../widgets/dialog.dart';
import '../indicator_page.dart';

class ReservationHistoryViewModel extends ChangeNotifier {
  ReservationHistoryViewModel(this.context, this.pageIdx) {
    addScrollControllerListener(); // 스크롤 이벤트 리스너 등록
  }

  late BuildContext context;
  late int pageIdx;

  final _postRepository = PostRepository();

  /// 예약 내역 히스토리 데이터 리스트
  List<ReservationData> _reservationDataList = [];
  final _scrollController = ScrollController();

  List<ReservationData> get reservationDataList => _reservationDataList;
  ScrollController get scrollController => _scrollController;

 Future<void> handleReservationHistory() async {
   try{
     ReservationHistoryResponse response =
                await _postRepository.getHistoryReservationDio(pageIdx);

     if (response.status.code == '200') {
       if (pageIdx == 1) {
         _reservationDataList.clear();
         _reservationDataList = List.of(response.data);
       }
       else { // 2페이지 이후 처리 로직
         Navigator.pop(context);

         _reservationDataList = List.from(_reservationDataList)
           ..addAll(response.data);

         if(response.data.length != 0){
           _scrollController.jumpTo(_scrollController.offset+1);
         }
       }
       notifyListeners();
     }
   } on DioException catch (dioError){
     logger.e('=> $dioError');
     throw MyException.myDioException(dioError.type);
   } catch (error){
     logger.e('=> $error');
     throw Exception(error);
   }
 }

  /// 예약 취소
  Future<void> handleCancelReservation(int reservationIdx) async {
    try {
      DefaultResponse response = await _postRepository.cancelReservationDio({
        "serviceType": "lifelog",
        "reservationIdx": reservationIdx
      });

      if(response.status.code == '200'){
        Etc.successSnackBar('예약이 취소 되었습니다.', context);
        _reservationDataList.clear();
        handleReservationHistory();
        notifyListeners();
      } else {
        CustomDialog.showMyDialog(
          title: '예약',
          content: '건강관리소 예약 취소가\n정상적으로 처리되지 못했습니다.',
          mainContext: context,
        );
      }

    } on DioException catch (dioError) {
      logger.i('=> $dioError');
      //throw Exception(dioError);
      CustomDialog.showMyDialog(
        title: '예약',
        content: '방문 예약 취소가\n정상적으로 처리되지 못했습니다.',
        mainContext: context,
      );
    }
  }

  addScrollControllerListener() {
    _scrollController.addListener(() {
      if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
          ++pageIdx;
          logger.d('=> pageIdx: $pageIdx');

          Navigator.push(context, IndicatorPage());
          Future.delayed(const Duration(seconds: 1), () {
            handleReservationHistory();
          });
      }
    });
  }
}