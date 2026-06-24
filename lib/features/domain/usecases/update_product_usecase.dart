import 'package:prjbloc/features/domain/entities/product.dart';
import 'package:prjbloc/features/domain/repositories/product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository _productRepository;
  UpdateProductUseCase(this._productRepository);
  Future<void> call({required Product product}) async {
    return await _productRepository.updateProductData(product);
  }
}
