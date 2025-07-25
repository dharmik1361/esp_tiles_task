import '../models/subcategory.dart';

abstract class SubcategoryRepository {
  Future<List<Subcategory>> getSubcategories();
  Future<List<Subcategory>> getSubcategoriesByCategory(String categoryId);
  Future<Subcategory> getSubcategoryById(String id);
}

class SubcategoryRepositoryImpl implements SubcategoryRepository {
  @override
  Future<List<Subcategory>> getSubcategories() async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      Subcategory(
        id: '1',
        name: 'EXCELLENCE',
        description: 'Premium quality tiles',
        imageUrl: 'https://example.com/excellence.jpg',
        categoryId: '1',
      ),
      Subcategory(
        id: '2',
        name: 'ETRUSCAN',
        description: 'Classic design tiles',
        imageUrl: 'https://example.com/etruscan.jpg',
        categoryId: '1',
      ),
    ];
  }

  @override
  Future<List<Subcategory>> getSubcategoriesByCategory(
    String categoryId,
  ) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 400));

    return [
      Subcategory(
        id: '1',
        name: 'EXCELLENCE',
        description: 'Premium quality tiles',
        imageUrl: 'https://example.com/excellence.jpg',
        categoryId: categoryId,
      ),
      Subcategory(
        id: '2',
        name: 'ETRUSCAN',
        description: 'Classic design tiles',
        imageUrl: 'https://example.com/etruscan.jpg',
        categoryId: categoryId,
      ),
    ];
  }

  @override
  Future<Subcategory> getSubcategoryById(String id) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 300));

    return Subcategory(
      id: id,
      name: 'EXCELLENCE',
      description: 'Premium quality tiles',
      imageUrl: 'https://example.com/excellence.jpg',
      categoryId: '1',
    );
  }
}
