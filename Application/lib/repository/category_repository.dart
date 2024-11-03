import 'package:shopping_app/api/category_api.dart';
import 'package:shopping_app/model/category.dart';

class CategoryRepository {
  final CategoryApi _categoryApi;

  CategoryRepository(this._categoryApi);

  Future<CategoryList> getAllCategory() async {
    return await _categoryApi.getAllCategory();
  }
}
