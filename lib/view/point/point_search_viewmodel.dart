

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../data/models/point_hisstory.dart';
import '../../data/models/point_history_response.dart';
import '../../data/repository/post_repository.dart';
import '../../main.dart';
import '../../utils/my_exception.dart';
import '../indicator_page.dart';

// ignore_for_file: use_build_context_synchronously, prefer_is_empty
class PointSearchViewModel extends ChangeNotifier {

  late BuildContext context;
  late int _pageIdx;

  PointSearchViewModel(this.context, this._pageIdx) {
    addScrollControllerListener(); // 스크롤 이벤트 리스너 등록
  }

  final _postRepository = PostRepository();
  final _scrollController = ScrollController();
  List<PointHistory> _pointHistoryList = [];

  ScrollController get scrollController => _scrollController;
  List<PointHistory> get pointHistoryList => _pointHistoryList;

  Future<void> handlePointHistoryList() async {
    try{
      PointHistoryResponse response
      = await _postRepository.getPointHistoryListDio(_pageIdx);

      if(response.status.code == '200'){
        if(response.data == null){
          Navigator.pop(context);
          return;
        }

        if (_pageIdx == 1) {
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
        ++_pageIdx;
        logger.d('=> pageIdx: $_pageIdx');

        Navigator.push(context, IndicatorPage());
        Future.delayed(const Duration(seconds: 1), () {
          handlePointHistoryList();
        });
      }
    });
  }
}