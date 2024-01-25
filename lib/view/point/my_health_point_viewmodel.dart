
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ghealth_app/data/models/point_hisstory.dart';
import 'package:ghealth_app/data/models/point_history_response.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';

import '../../main.dart';
import '../../utils/my_exception.dart';
import '../indicator_page.dart';

// ignore_for_file: use_build_context_synchronously, prefer_is_empty
class MyHealthPointViewModel extends ChangeNotifier {
  MyHealthPointViewModel(this.context, this.pageIdx){
    addScrollControllerListener(); // 스크롤 이벤트 리스너 등록
  }

  late BuildContext context;
  late int pageIdx;

  final _postRepository = PostRepository();

  List<PointHistory> _pointHistoryList = [];
  final _scrollController = ScrollController();

  List<PointHistory> get pointHistoryList => _pointHistoryList;
  ScrollController get scrollController => _scrollController;


  Future<void> handlePointHistoryList() async {
    try{
      PointHistoryResponse response = await _postRepository.getPointHistoryListDio(pageIdx);

      if(response.status.code == '200'){
        if(response.data == null){
          Navigator.pop(context);
          return;
        }

        if (pageIdx == 1) {
          _pointHistoryList.clear();
          _pointHistoryList = List.of(response.data!);
        }
        else { // 2페이지 이후 처리 로직
          Navigator.pop(context);

          _pointHistoryList = List.from(_pointHistoryList)
            ..addAll(response.data!);

          if(response.data?.length != 0){
            _scrollController.jumpTo(_scrollController.offset+1);
          }
        }
        notifyListeners();
      }

    }  on DioException catch (dioError) {
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
          handlePointHistoryList();
        });
      }
    });
  }
}