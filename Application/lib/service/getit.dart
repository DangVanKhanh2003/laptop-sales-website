import 'package:get_it/get_it.dart';
import 'package:shopping_app/api/category_api.dart';
import 'package:shopping_app/api/product_api.dart';
import 'package:shopping_app/repository/category_repository.dart';
import 'package:shopping_app/repository/product_repository.dart';

class GetItWrapper {
  static GetIt getIt = GetIt.instance;

  static void registerSingleton() {
    getIt.registerLazySingleton<CategoryRepository>(
      () => CategoryRepository(CategoryApi()),
    );
    getIt.registerLazySingleton<ProductRepository>(
      () => ProductRepository(ProductApi()),
    );
  }
}
