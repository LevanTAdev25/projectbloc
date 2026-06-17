import 'package:prjbloc/features/domain/repositories/product_repository.dart';

class RemoveProduct {
  final ProductRepository _productRepository;
  RemoveProduct(this._productRepository);
  Future<void> call({required String id}) async {
    return await _productRepository.deleteProductData(id);
  }
}
