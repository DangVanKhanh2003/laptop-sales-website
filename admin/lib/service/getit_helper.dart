import 'package:get_it/get_it.dart';
import 'package:admin/api/category_api.dart';
import 'package:admin/api/comment_api.dart';
import 'package:admin/api/customer_api.dart';
import 'package:admin/api/order_api.dart';
import 'package:admin/api/order_pending_api.dart';
import 'package:admin/api/product_api.dart';
import 'package:admin/repository/category_repository.dart';
import 'package:admin/repository/comment_repository.dart';
import 'package:admin/repository/customer_repository.dart';
import 'package:admin/repository/order_pending_repository.dart';
import 'package:admin/repository/order_repository.dart';
import 'package:admin/repository/product_repository.dart';

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
    _getIt.registerLazySingleton<OrderPendingRepository>(
      () => OrderPendingRepository(OrderPendingApi()),
    );
    _getIt.registerLazySingleton<OrderRepository>(
      () => OrderRepository(OrderApi()),
    );
    _getIt.registerLazySingleton<CommentRepository>(
      () => CommentRepository(CommentApi()),
    );
  }
}
