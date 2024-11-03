import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/category.dart';
import 'package:shopping_app/repository/category_repository.dart';
import 'package:shopping_app/service/getit.dart';

final categoryProvider = StateNotifierProvider(
  (_) => CategoryProvider(),
);

class CategoryProvider extends StateNotifier<CategoryList> {
  CategoryProvider() : super(CategoryList(categoryList: []));

  List<Category>? get category => state.categoryList;

  set categoryList(CategoryList value) {
    state = value;
  }

  bool get hasData => category != null && category!.isNotEmpty;

  Future<void> getCategory() async {
    state = await GetItWrapper.getIt<CategoryRepository>().getAllCategory();
  }
}
