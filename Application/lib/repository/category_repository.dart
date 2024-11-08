import 'package:shopping_app/api/category_api.dart';
import 'package:shopping_app/model/category.dart';
import 'package:shopping_app/model/token_state.dart';

class CategoryRepository {
  final CategoryApi _categoryApi;

  CategoryRepository(this._categoryApi);

  Future<CategoryList> getAllCategory({
    required TokenState token,
  }) async {
    return await _categoryApi.getAllCategory(token: token);
  }
}
