import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prjbloc/features/domain/entities/product.dart';
import 'package:prjbloc/features/domain/usecases/add_product.dart';
import 'package:prjbloc/features/domain/usecases/filter_by_category.dart';
import 'package:prjbloc/features/domain/usecases/get_product_list.dart';
import 'package:prjbloc/features/domain/usecases/remove_product.dart';
import 'package:prjbloc/features/domain/usecases/update_product.dart';
import 'package:prjbloc/features/presentation/bloc/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  GetProductList _getProductList;
  AddProduct _addProduct;
  RemoveProduct _removeProduct;
  UpdateProduct _updateProduct;
  FilterByCategory _filterByCategory;
  ProductCubit({
    required this._getProductList,
    required this._addProduct,
    required this._removeProduct,
    required this._updateProduct,
    required this._filterByCategory,
  }) : super(ProductInitialize());
  Future<void> loadProducts({String? query, String? category}) async {
    emit(ProductLoading());
    try {
      List<Product> arrProduct = await _getProductList(
        query: query,
        category: category,
      );
      emit(ProductLoadSuccess(arrProduct));
    } catch (e) {
      emit(ProductError(e.toString().replaceAll("Exception: ", "")));
    }
  }

  Future<void> addNewProduct(Product product) async {
    try {
      await _addProduct(product: product);
      await loadProducts();
    } catch (e) {
      emit(ProductError(e.toString().replaceAll("Exception: ", "")));
    }
  }

  Future<void> removeCurrentProduct(String id) async {
    try {
      await _removeProduct(id: id);
      await loadProducts();
    } catch (e) {
      emit(ProductError(e.toString().replaceAll("Exception: ", "")));
    }
  }

  Future<void> updateCurrentProduct(Product product) async {
    try {
      await _updateProduct(product: product);
      await loadProducts();
    } catch (e) {
      emit(ProductError(e.toString().replaceAll("Exception: ", "")));
    }
  }

  Future<void> newProductListByCategory(String? category) async {
    emit(ProductLoading());
    try {
      var newListProduct = await _filterByCategory(category: category);
      emit(ProductLoadSuccess(newListProduct));
    } catch (e) {
      emit(ProductError(e.toString().replaceAll("Exception: ", "")));
    }
  }
}
