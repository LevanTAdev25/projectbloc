import 'package:prjbloc/features/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProductsData({String? query, String? category});
  Future<void> addProductData(Product product);
  Future<void> updateProductData(Product product);
  Future<void> deleteProductData(String id);
  Future<List<Product>> filterByCategory({String? category});
}
