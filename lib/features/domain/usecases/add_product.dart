import 'package:prjbloc/features/domain/entities/product.dart';
import 'package:prjbloc/features/domain/repositories/product_repository.dart';

class AddProduct {
  final ProductRepository _productRepository;
  AddProduct(this._productRepository);
  Future<void> call({required Product product}) async {
    if (product.name.trim().isEmpty) {
      throw Exception("Tên không được để trống");
    }
    if (product.price <= 0) {
      throw Exception("Giá sản phấm không được bé hơn hoặc bằng âm");
    }
    return await _productRepository.addProductData(product);
  }
}
