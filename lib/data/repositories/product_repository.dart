import '../models/product.dart';
import '../services/api_service.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<List<Product>> getProductsBySubcategory(String subcategoryId);
  Future<Product> getProductById(String id);
  Future<Map<String, dynamic>> getProductList(
    int subCategoryId, {
    int pageIndex = 1,
  });
}

class ProductRepositoryImpl implements ProductRepository {
  final ApiService _apiService = ApiService();

  @override
  Future<List<Product>> getProducts() async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      Product(
        id: '1',
        name: 'Excellence grey',
        description: 'Premium grey ceramic tile',
        price: 10.99,
        imageUrl: 'https://example.com/excellence-grey.jpg',
        subcategoryId: '1',
        tags: ['grey', 'ceramic', 'premium'],
        isAvailable: true,
      ),
      Product(
        id: '2',
        name: 'Excellence ivory',
        description: 'Premium ivory ceramic tile',
        price: 12.99,
        imageUrl: 'https://example.com/excellence-ivory.jpg',
        subcategoryId: '1',
        tags: ['ivory', 'ceramic', 'premium'],
        isAvailable: true,
      ),
    ];
  }

  @override
  Future<List<Product>> getProductsBySubcategory(String subcategoryId) async {
    try {
      final productListData = await getProductList(int.parse(subcategoryId));

      // Parse products from ProductList API response
      if (productListData['Result'] != null) {
        final productsList = productListData['Result'] as List;
        return productsList.map((json) => Product.fromJson(json)).toList();
      }

      // Fallback to mock data
      return _getMockProductsBySubcategory(subcategoryId);
    } catch (e) {
      print('Error fetching products by subcategory: $e');
      return _getMockProductsBySubcategory(subcategoryId);
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 300));

    return Product(
      id: id,
      name: 'Excellence grey',
      description: 'Premium grey ceramic tile',
      price: 10.99,
      imageUrl: 'https://example.com/excellence-grey.jpg',
      subcategoryId: '1',
      tags: ['grey', 'ceramic', 'premium'],
      isAvailable: true,
    );
  }

  @override
  Future<Map<String, dynamic>> getProductList(
    int subCategoryId, {
    int pageIndex = 1,
  }) async {
    try {
      final response = await _apiService.getProductList(
        subCategoryId: subCategoryId,
        pageIndex: pageIndex,
      );

      print(
        'Product List API Response for SubCategory $subCategoryId: $response',
      );
      return response;
    } catch (e) {
      print('Error in getProductList: $e');
      rethrow;
    }
  }

  // Mock data fallback methods
  List<Product> _getMockProductsBySubcategory(String subcategoryId) {
    return [
      Product(
        id: '1',
        name: 'Excellence grey',
        description: 'Premium grey ceramic tile',
        price: 10.99,
        imageUrl: 'https://example.com/excellence-grey.jpg',
        subcategoryId: subcategoryId,
        tags: ['grey', 'ceramic', 'premium'],
        isAvailable: true,
      ),
      Product(
        id: '2',
        name: 'Excellence ivory',
        description: 'Premium ivory ceramic tile',
        price: 12.99,
        imageUrl: 'https://example.com/excellence-ivory.jpg',
        subcategoryId: subcategoryId,
        tags: ['ivory', 'ceramic', 'premium'],
        isAvailable: true,
      ),
    ];
  }
}
