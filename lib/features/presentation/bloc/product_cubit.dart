import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prjbloc/features/domain/entities/product.dart';
import 'package:prjbloc/features/domain/usecases/add_product_usecase.dart';
import 'package:prjbloc/features/domain/usecases/filter_by_category_usecase.dart';
import 'package:prjbloc/features/domain/usecases/get_product_list_usecase.dart';
import 'package:prjbloc/features/domain/usecases/remove_product_usecase.dart';
import 'package:prjbloc/features/domain/usecases/update_product_usecase.dart';
import 'package:prjbloc/features/presentation/bloc/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductListUseCase _getProductListUseCase;
  final AddProductUseCase _addProductUseCase;
  final RemoveProductUseCase _removeProductUseCase;
  final UpdateProductUseCase _updateProductUseCase;
  final FilterByCategoryUseCase _filterByCategoryUseCase;

  ProductCubit({
    required this._getProductListUseCase,
    required this._addProductUseCase,
    required this._removeProductUseCase,
    required this._updateProductUseCase,
    required this._filterByCategoryUseCase,
  }) : super(ProductInitialize());
  Future<void> loadProducts({String? query, String? category}) async {
    emit(ProductLoading());
    try {
      List<Product> arrProduct = await _getProductListUseCase(query: query);
      emit(
        ProductLoadSuccess(
          arrProduct,
          selectedCategory: category ?? "Tất cả",
          query: query ?? "",
        ),
      );
    } catch (e) {
      emit(ProductError(e.toString().replaceAll("Exception: ", "")));
    }
  }

  void validate() {}
  Future<void> addNewProduct(Product product) async {
    emit(ProductLoading());
    try {
      await _addProductUseCase(product: product);
    } catch (e) {
      emit(ProductError(e.toString().replaceAll("Exception: ", "")));
    }
  }

  Future<void> removeCurrentProduct(String id) async {
    emit(ProductLoading());
    try {
      await _removeProductUseCase(id: id);
      await loadProducts();
    } catch (e) {
      emit(ProductError(e.toString().replaceAll("Exception: ", "")));
    }
  }

  Future<void> updateCurrentProduct(Product product) async {
    emit(ProductLoading());
    try {
      await _updateProductUseCase(product: product);
    } catch (e) {
      emit(ProductError(e.toString().replaceAll("Exception: ", "")));
    }
  }

  Future<void> newProductListByCategory(String? category) async {
    emit(ProductLoading());
    try {
      final newListProduct = await _filterByCategoryUseCase(category: category);
      emit(
        ProductLoadSuccess(
          newListProduct,
          selectedCategory: category ?? "Tất cả",
          query: "",
        ),
      );
    } catch (e) {
      emit(ProductError(e.toString().replaceAll("Exception: ", "")));
    }
  }

  void initCreateForm() {
    emit(
      ProductFormState(
        name: '',
        price: 0.0,
        category: 'Laptop văn phòng',
        editingProductId: null,
      ),
    );
  }

  void initEditForm(Product product) {
    emit(
      ProductFormState(
        name: product.name,
        price: product.price,
        category: product.category,
        editingProductId: product.id,
      ),
    );
  }

  void updateFormName(String name) {
    if (state is ProductFormState) {
      emit((state as ProductFormState).copyWith(name: name));
    }
  }

  void updateFormPrice(String priceStr) {
    if (state is ProductFormState) {
      final price = double.tryParse(priceStr) ?? 0.0;
      emit((state as ProductFormState).copyWith(price: price));
    }
  }

  void updateFormCategory(String category) {
    if (state is ProductFormState) {
      emit((state as ProductFormState).copyWith(category: category));
    }
  }

  Future<void> submitCreateForm() async {
    if (state is! ProductFormState) return;
    final formState = state as ProductFormState;
    final product = Product(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: formState.name,
      price: formState.price,
      category: formState.category,
    );
    try {
      emit(ProductActionSuccess("Thêm sản phẩm thành công"));
      await addNewProduct(product);
      await loadProducts();
    } catch (e) {
      emit(ProductError(e.toString().replaceAll("Exception: ", "")));
      emit(formState);
    }
  }

  Future<void> submitEditForm() async {
    if (state is! ProductFormState) return;
    final formState = state as ProductFormState;
    if (formState.editingProductId == null) return;

    final product = Product(
      id: formState.editingProductId!,
      name: formState.name,
      price: formState.price,
      category: formState.category,
    );
    try {
      emit(ProductActionSuccess("Đã chỉnh sửa thành công"));
      await updateCurrentProduct(product);
      await loadProducts();
    } catch (e) {
      emit(ProductError(e.toString().replaceAll("Exception: ", "")));
      emit(formState);
    }
  }

  Future<void> snackBarPopUpdate(
    BuildContext parentContext,
    Product product,
  ) async {}
}
