

import '../../../../common/di/di.dart';
import '../../../entity/product_dto.dart';
import '../../repository/ghealth_repository.dart';
import '../base_usecase.dart';

/// 상품조회 유스케이스
class ProductUseCase implements NoParamUseCase<void, void> {
  final GHealthRepository _gHealthRepository;

  ProductUseCase([GHealthRepository? gHealthRepository])
      : _gHealthRepository = gHealthRepository ?? locator();

  @override
  Future<ProductDTO?> execute() {
    return _gHealthRepository.getProduct();
  }
}