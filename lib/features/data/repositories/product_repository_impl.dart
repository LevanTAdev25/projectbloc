import 'package:prjbloc/features/data/datasources/product_remote_data_source.dart';
import 'package:prjbloc/features/data/models/product_model.dart';
import 'package:prjbloc/features/domain/entities/product.dart';
import 'package:prjbloc/features/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource _productLocalDataSource;
  ProductRepositoryImpl(this._productLocalDataSource);
  @override
  Future<List<ProductModel>> getProductsData({String? query}) async {
    try {
      return await _productLocalDataSource.getProductsData(query: query);
    } catch (e) {
      throw Exception("Loi lay danh sach: $e");
    }
  }

  @override
  Future<void> addProductData(Product product) async {
    try {
      await _productLocalDataSource.addProductData(product);
    } catch (e) {
      throw Exception("Loi lay danh sach: $e");
    }
  }

  @override
  Future<void> deleteProductData(String id) async {
    try {
      await _productLocalDataSource.deleteProductData(id);
    } catch (e) {
      throw Exception("Loi khi xoa: $e");
    }
  }

  @override
  Future<void> updateProductData(Product product) async {
    try {
      await _productLocalDataSource.updateProductData(product);
    } catch (e) {
      throw Exception("Loi khi update: $e");
    }
  }

  @override
  Future<List<Product>> filterByCategory({String? category}) async {
    // TODO: implement filterByCategory
    try {
      return await _productLocalDataSource.filterByCategory(category: category);
    } catch (e) {
      throw Exception("Loi loc: $e");
    }
  }
}
