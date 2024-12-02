import 'package:admin/api/category_api.dart';
import 'package:admin/model/category.dart';

class CategoryRepository {
  final CategoryApi _categoryApi;

  CategoryRepository(this._categoryApi);

  Future<CategoryList> getAllCategory() async {
    return await _categoryApi.getAllCategory();
  }

  Future<void> deleteCategory({
    required int categoryId,
  }) async {
    return await _categoryApi.deleteCategory(
      categoryId: categoryId,
    );
  }

  Future<void> editCategory({
    required Category category,
  }) async {
    return await _categoryApi.editCategory(
      category: category,
    );
  }

  Future<void> addCategory({
    required Category category,
  }) async {
    return await _categoryApi.addCategory(
      category: category,
    );
  }
}
