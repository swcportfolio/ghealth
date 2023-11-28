
// ignore_for_file: use_build_context_synchronously, prefer_is_empty

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';

import '../../data/models/reservation_data.dart';
import '../../data/models/reservation_history_response.dart';
import '../../main.dart';
import '../../utils/etc.dart';
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

         if(response.data.length == 0){
           Etc.showSnackBar('더 이상 방문내역이 없습니다.', context);
         } else {
           _scrollController.jumpTo(_scrollController.offset+1);
         }
       }
       notifyListeners();
     }
   } on DioException catch (dioError){
     logger.e('=> $dioError');
     throw Exception(dioError);
   } catch (error){
     logger.e('=> $error');
     throw Exception(error);
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