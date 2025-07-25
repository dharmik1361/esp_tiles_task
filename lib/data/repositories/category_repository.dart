import '../models/category.dart';
import '../services/api_service.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<Category> getCategoryById(String id);
  Future<Map<String, dynamic>> getDashboardData({
    int categoryId = 0,
    int pageIndex = 1,
  });
  Future<Map<String, dynamic>> getDashboardDataByCategory(
    int categoryId, {
    int pageIndex = 1,
  });
}

class CategoryRepositoryImpl implements CategoryRepository {
  final ApiService _apiService = ApiService();

  @override
  Future<List<Category>> getCategories() async {
    try {
      final dashboardData = await getDashboardData();

      // Parse categories from dashboard response - API returns Result.Category
      if (dashboardData['Result'] != null &&
          dashboardData['Result']['Category'] != null) {
        final categoriesList = dashboardData['Result']['Category'] as List;
        return categoriesList.map((json) => Category.fromJson(json)).toList();
      }

      // Fallback to mock data if API doesn't return expected format
      return _getMockCategories();
    } catch (e) {
      print('Error fetching categories: $e');
      return _getMockCategories();
    }
  }

  @override
  Future<Category> getCategoryById(String id) async {
    try {
      final dashboardData = await getDashboardData();

      if (dashboardData['Result'] != null &&
          dashboardData['Result']['Category'] != null) {
        final categoriesList = dashboardData['Result']['Category'] as List;
        final categoryJson = categoriesList.firstWhere(
          (cat) => cat['Id'].toString() == id,
          orElse: () => null,
        );

        if (categoryJson != null) {
          return Category.fromJson(categoryJson);
        }
      }

      // Fallback to mock data
      return _getMockCategory(id);
    } catch (e) {
      print('Error fetching category by ID: $e');
      return _getMockCategory(id);
    }
  }

  @override
  Future<Map<String, dynamic>> getDashboardData({
    int categoryId = 0,
    int pageIndex = 1,
  }) async {
    try {
      final response = await _apiService.getDashboard(
        categoryId: categoryId,
        pageIndex: pageIndex,
      );

      print('Dashboard API Response: $response');
      return response;
    } catch (e) {
      print('Error in getDashboardData: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getDashboardDataByCategory(
    int categoryId, {
    int pageIndex = 1,
  }) async {
    try {
      final response = await _apiService.getDashboard(
        categoryId: categoryId,
        pageIndex: pageIndex,
      );

      print('Dashboard API Response for Category $categoryId: $response');
      return response;
    } catch (e) {
      print('Error in getDashboardDataByCategory: $e');
      rethrow;
    }
  }

  // Mock data fallback methods
  List<Category> _getMockCategories() {
    return [
      Category(
        id: '1',
        name: 'Ceramic',
        description: 'Ceramic tiles for various applications',
        imageUrl: 'https://example.com/ceramic.jpg',
      ),
      Category(
        id: '2',
        name: 'Porcelain',
        description: 'Porcelain tiles for high-traffic areas',
        imageUrl: 'https://example.com/porcelain.jpg',
      ),
    ];
  }

  Category _getMockCategory(String id) {
    return Category(
      id: id,
      name: 'Ceramic',
      description: 'Ceramic tiles for various applications',
      imageUrl: 'https://example.com/ceramic.jpg',
    );
  }
}
