import 'package:prjbloc/features/domain/repositories/product_repository.dart';

class RemoveProductUseCase {
  final ProductRepository _productRepository;
  RemoveProductUseCase(this._productRepository);
  Future<void> call({required String id}) async {
    return await _productRepository.deleteProductData(id);
  }
}
