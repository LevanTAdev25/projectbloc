import 'package:prjbloc/features/domain/entities/product.dart';
import 'package:prjbloc/features/domain/repositories/product_repository.dart';

class AddProduct {
  final ProductRepository _productRepository;
  AddProduct(this._productRepository);
  Future<void> call({required Product product}) async {
    return await _productRepository.addProductData(product);
  }
}
