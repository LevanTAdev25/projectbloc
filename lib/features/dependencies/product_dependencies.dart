import 'package:get_it/get_it.dart';
import 'package:prjbloc/features/data/datasources/product_remote_data_source.dart';
import 'package:prjbloc/features/data/repositories/product_repository_impl.dart';
import 'package:prjbloc/features/domain/repositories/product_repository.dart';
import 'package:prjbloc/features/domain/usecases/add_product_usecase.dart';
import 'package:prjbloc/features/domain/usecases/filter_by_category_usecase.dart';
import 'package:prjbloc/features/domain/usecases/get_product_list_usecase.dart';
import 'package:prjbloc/features/domain/usecases/remove_product_usecase.dart';
import 'package:prjbloc/features/domain/usecases/update_product_usecase.dart';
import 'package:prjbloc/features/presentation/bloc/product_cubit.dart';

final sl = GetIt.instance;
Future<void> initDependencies() async {
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl<ProductRemoteDataSource>()),
  );
  sl.registerLazySingleton<AddProductUseCase>(
    () => AddProductUseCase(sl<ProductRepository>()),
  );
  sl.registerLazySingleton<GetProductListUseCase>(
    () => GetProductListUseCase(sl<ProductRepository>()),
  );
  sl.registerLazySingleton<RemoveProductUseCase>(
    () => RemoveProductUseCase(sl<ProductRepository>()),
  );
  sl.registerLazySingleton<UpdateProductUseCase>(
    () => UpdateProductUseCase(sl<ProductRepository>()),
  );
  sl.registerLazySingleton<FilterByCategoryUseCase>(
    () => FilterByCategoryUseCase(sl<ProductRepository>()),
  );
  sl.registerFactory<ProductCubit>(
    () => ProductCubit(
      getProductListUseCase: sl<GetProductListUseCase>(),
      addProductUseCase: sl<AddProductUseCase>(),
      removeProductUseCase: sl<RemoveProductUseCase>(),
      updateProductUseCase: sl<UpdateProductUseCase>(),
      filterByCategoryUseCase: sl<FilterByCategoryUseCase>(),
    ),
  );
}
