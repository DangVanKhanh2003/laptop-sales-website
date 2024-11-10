import 'package:get_it/get_it.dart';
import 'package:shopping_app/api/cart_api.dart';
import 'package:shopping_app/api/category_api.dart';
import 'package:shopping_app/api/customer_api.dart';
import 'package:shopping_app/api/product_api.dart';
import 'package:shopping_app/repository/cart_repository.dart';
import 'package:shopping_app/repository/category_repository.dart';
import 'package:shopping_app/repository/customer_repository.dart';
import 'package:shopping_app/repository/product_repository.dart';
import 'package:shopping_app/service/gemini_helper.dart';

class GetItHelper {
  static final GetIt _getIt = GetIt.asNewInstance();

  static T get<T extends Object>() {
    return _getIt.get<T>();
  }

  static void registerSingleton() {
    _getIt.registerLazySingleton<CategoryRepository>(
      () => CategoryRepository(CategoryApi()),
    );
    _getIt.registerLazySingleton<ProductRepository>(
      () => ProductRepository(ProductApi()),
    );
    _getIt.registerLazySingleton<CustomerRepository>(
      () => CustomerRepository(CustomerApi()),
    );
    _getIt.registerLazySingleton<CartRepository>(
      () => CartRepository(CartApi()),
    );
    _getIt.registerLazySingleton<GeminiHelper>(
      () => GeminiHelper(),
    );
  }
}
