import 'package:admin/api/stats_api.dart';
import 'package:admin/repository/stats_repository.dart';
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

  static void registerIfNot<T extends Object>(
    T Function() signFunc,
  ) {
    if (!_getIt.isRegistered<T>()) {
      _getIt.registerSingleton(signFunc());
    }
  }

  static void registerSingleton() {
    registerIfNot<CategoryRepository>(
      () => CategoryRepository(CategoryApi()),
    );
    registerIfNot<ProductRepository>(
      () => ProductRepository(ProductApi()),
    );
    registerIfNot<CustomerRepository>(
      () => CustomerRepository(CustomerApi()),
    );
    registerIfNot<OrderPendingRepository>(
      () => OrderPendingRepository(OrderPendingApi()),
    );
    registerIfNot<OrderRepository>(
      () => OrderRepository(OrderApi()),
    );
    registerIfNot<CommentRepository>(
      () => CommentRepository(CommentApi()),
    );
    registerIfNot<StatsRepository>(
      () => StatsRepository(StatsApi()),
    );
  }
}
