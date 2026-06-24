import 'package:prjbloc/features/domain/entities/product.dart';
import 'package:prjbloc/features/domain/repositories/product_repository.dart';

class GetProductListUseCase {
  final ProductRepository _productRepository;
  GetProductListUseCase(this._productRepository);
  Future<List<Product>> call({String? query}) async {
    final listProduct = await _productRepository.getProductsData(query: query);
    return listProduct;
  }
}
