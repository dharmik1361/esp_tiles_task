class ApiEndpoints {
  static const String baseUrl = 'http://esptiles.imperoserver.in/api/API';

  // Dashboard/Product API
  static const String dashboard = '/Product/DashBoard';

  // Product List API
  static const String productList = '/Product/ProductList';

  // Categories
  static const String categories = '/categories';
  static const String categoryById = '/categories/{id}';

  // Subcategories
  static const String subcategories = '/subcategories';
  static const String subcategoriesByCategory =
      '/categories/{categoryId}/subcategories';
  static const String subcategoryById = '/subcategories/{id}';

  // Products
  static const String products = '/products';
  static const String productsBySubcategory =
      '/subcategories/{subcategoryId}/products';
  static const String productById = '/products/{id}';

  // Design Strip
  static const String designStrip = '/design-strip';
  static const String colorPalette = '/color-palette';
}
