import 'package:prjbloc/features/domain/entities/product.dart';
import 'package:prjbloc/features/domain/repositories/product_repository.dart';

class FilterByCategoryUseCase {
  final ProductRepository _productRepository;
  FilterByCategoryUseCase(this._productRepository);
  Future<List<Product>> call({String? category}) async {
    List<Product> arrProduct = await _productRepository.filterByCategory(
      category: category,
    );
    return arrProduct;
  }
}
