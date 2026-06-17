import 'package:prjbloc/features/domain/entities/product.dart';
import 'package:prjbloc/features/domain/repositories/product_repository.dart';

class FilterByCategory {
  final ProductRepository _productRepository;
  FilterByCategory(this._productRepository);
  Future<List<Product>> call({String? category}) async {
    List<Product> arrProduct = await _productRepository.filterByCategory(
      category: category,
    );
    return arrProduct;
  }
}
