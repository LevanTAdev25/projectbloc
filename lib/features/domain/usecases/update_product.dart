import 'package:prjbloc/features/domain/entities/product.dart';
import 'package:prjbloc/features/domain/repositories/product_repository.dart';

class UpdateProduct {
  final ProductRepository _productRepository;
  UpdateProduct(this._productRepository);
  Future<void> call({required Product product}) async {
    return await _productRepository.updateProductData(product);
  }
}
