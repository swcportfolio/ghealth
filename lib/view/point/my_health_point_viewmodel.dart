
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ghealth_app/data/models/point_hisstory.dart';
import 'package:ghealth_app/data/models/point_history_response.dart';
import 'package:ghealth_app/data/models/product_data_response.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';

import '../../data/models/product_data.dart';
import '../../main.dart';
import '../../utils/my_exception.dart';
import '../indicator_page.dart';

class MyHealthPointViewModel extends ChangeNotifier  {

  MyHealthPointViewModel(this.context);

  late BuildContext context;
  final  int _pageIdx = 1;

  final _postRepository = PostRepository();

  List<PointHistory> _pointHistoryList = [];
  List<ProductData> _productList = [];

  List<PointHistory> get pointHistoryList => _pointHistoryList;
  List<ProductData> get productList => _productList;

  Future<void> handlePointHistoryList(bool mounted) async {
    try{
      PointHistoryResponse response = await _postRepository.getPointHistoryListDio(_pageIdx);

      if(response.status.code == '200'){
        if(response.data == null)
        {
          if(!mounted) return;
          Navigator.pop(context);
          return;
        }
        if (_pageIdx == 1) {
          _pointHistoryList.clear();
          _pointHistoryList = List.of(response.data!);
        }
        notifyListeners();
      }

    }  on DioException catch (dioError) {
      logger.e('=> $dioError');
      MyException.myDioException(dioError.type);
    }
  }

  Future<void> handleProductDio() async {
    try {
      ProductDataResponse response = await _postRepository.getProductDio();
      //TODO: response status 값이 없음
      _productList = List.of(response.products);
      notifyListeners();

    } on DioException catch (dioError) {
      logger.e('=> $dioError');
      MyException.myDioException(dioError.type);
    }
  }


}