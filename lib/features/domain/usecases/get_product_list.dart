import 'package:prjbloc/features/domain/entities/product.dart';
import 'package:prjbloc/features/domain/repositories/product_repository.dart';

class GetProductList {
  final ProductRepository _productRepository;
  GetProductList(this._productRepository);
  Future<List<Product>> call({String? query, String? category}) async {
    var listProduct = await _productRepository.getProductsData(
      query: query,
      category: category,
    );
    return listProduct;
  }
}
