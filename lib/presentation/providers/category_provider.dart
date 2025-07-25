import 'package:flutter/foundation.dart';
import '../../data/models/category.dart' as models;
import '../../data/repositories/category_repository.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryRepository _repository = CategoryRepositoryImpl();

  List<models.Category> _categories = [];
  bool _isLoading = false;
  String? _error;
  Map<String, dynamic>? _dashboardData;

  List<models.Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, dynamic>? get dashboardData => _dashboardData;

  Future<void> loadCategories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _categories = await _repository.getCategories();
      print('Loaded ${_categories.length} categories');
    } catch (e) {
      _error = e.toString();
      print('Error loading categories: $_error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadDashboardData({
    int categoryId = 0,
    int pageIndex = 1,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _dashboardData = await _repository.getDashboardData(
        categoryId: categoryId,
        pageIndex: pageIndex,
      );

      // Also load categories from dashboard data
      _categories = await _repository.getCategories();

      print('Dashboard data loaded successfully');
      print('Categories count: ${_categories.length}');
    } catch (e) {
      _error = e.toString();
      print('Error loading dashboard data: $_error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadDashboardDataByCategory(
    int categoryId, {
    int pageIndex = 1,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _dashboardData = await _repository.getDashboardDataByCategory(
        categoryId,
        pageIndex: pageIndex,
      );

      print('Dashboard data loaded for category $categoryId');
    } catch (e) {
      _error = e.toString();
      print('Error loading dashboard data for category $categoryId: $_error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<models.Category?> getCategoryById(String id) async {
    try {
      return await _repository.getCategoryById(id);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
