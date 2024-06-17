
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ghealth_app/layers/domain/usecase/ghealth/product_usecase.dart';

import '../../../../../common/util/dio/dio_exceptions.dart';
import '../../../../../main.dart';
import '../../../../domain/usecase/ghealth/point_usecase.dart';
import '../../../../entity/point_history_dto.dart';
import '../../../../entity/product_dto.dart';
import '../../../../entity/total_point_dto.dart';


class MyHealthPointViewModelTest extends ChangeNotifier  {
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  final  int _pageIdx = 1;

  MyHealthPointViewModelTest(){
    getPointAndProduct();
  }

  List<PointHistoryDataDTO> _pointHistoryList = [];
  List<ProductDataDTO> _productList = [];
  String _totalPoint = '0';

  List<PointHistoryDataDTO> get pointHistoryList => _pointHistoryList;
  List<ProductDataDTO> get productList => _productList;
  String get totalPoint => _totalPoint;

  Future<void> getPointAndProduct() async{
    try{
      // usecase
      final pointHistoryFuture = PointHistoryUseCase().execute({
        'page': _pageIdx,
        'searchStartDate': '',
        'searchEndDate': '',
      });
      final productFuture = ProductUseCase().execute();

      final List futureResults = await Future.wait([
        pointHistoryFuture,
        productFuture,
      ]);
      PointHistoryDTO? responsePoint  = futureResults[0];
      ProductDTO? responseProduct  = futureResults[1];

      // 포인트 이력 조회 결과 로직
      if(responsePoint != null && responsePoint.status.code == '200'){
        if (_pageIdx == 1) {
          _pointHistoryList.clear();
          _pointHistoryList = List.of(responsePoint.data!);
          _isLoading = false;
        }
      }

      // 상품 조회 결과 로직
      if(responseProduct != null){
        //TODO: response status 값이 없음
        _productList = List.of(responseProduct.products);
      }

      _isLoading = false;
      notifyListeners();
    } on DioException catch (e) {
      logger.i(e);
      final msg = DioExceptions.fromDioError(e).toString();
      notifyError(msg);
    } catch (e) {
      logger.i(e);
      const msg = '죄송합니다.\n예기치 않은 문제가 발생했습니다.';
      notifyError(msg);
    }
  }



  /// 포인트 이력 조회
  Future<void> getPointHistory() async {
    Map<String, dynamic> toMap = {
      'page': _pageIdx,
      'searchStartDate': '',
      'searchEndDate': '',
    };
    try{
      PointHistoryDTO? response = await PointHistoryUseCase().execute(toMap);

      if(response != null && response.status.code == '200'){
        if (_pageIdx == 1) {
          _pointHistoryList.clear();
          _pointHistoryList = List.of(response.data!);
          _isLoading = false;
        }
      }
      notifyListeners();
    } on DioException catch (e) {
      logger.i(e);
      final msg = DioExceptions.fromDioError(e).toString();
      notifyError(msg);
    } catch (e) {
      logger.i(e);
      const msg = '죄송합니다.\n예기치 않은 문제가 발생했습니다.';
      notifyError(msg);
    }
  }

    /// 상품 조회
    Future<void> getProductDio() async {
      try {
        ProductDTO? response = await ProductUseCase().execute();
        //TODO: response status 값이 없음
        _productList = List.of(response!.products);
        _isLoading = false;
        notifyListeners();
      } on DioException catch (e) {
        logger.i(e);
        final msg = DioExceptions.fromDioError(e).toString();
        notifyError(msg);
      } catch (e) {
        logger.i(e);
        const msg = '죄송합니다.\n예기치 않은 문제가 발생했습니다.';
        notifyError(msg);
      }
  }

  /// 에러 처리
  notifyError(String message){
    _isLoading = false;
    _errorMessage = message;
    _isError = true;
    notifyListeners();
  }
}