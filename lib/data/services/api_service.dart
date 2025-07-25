import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/api_endpoints.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final String baseUrl = ApiEndpoints.baseUrl;

  Future<Map<String, String>> get _headers async {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // TODO: Add authentication headers when needed
      // 'Authorization': 'Bearer $token',
    };
  }

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: await _headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: await _headers,
        body: json.encode(data),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to post data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: await _headers,
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to update data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<void> delete(String endpoint) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: await _headers,
      );

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw Exception('Failed to delete data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Dashboard API call
  Future<dynamic> getDashboard({
    int categoryId = 0,
    String deviceManufacturer = "Google",
    String deviceModel = "Android SDK built for x86",
    String deviceToken = "mock-token",
    int pageIndex = 1,
  }) async {
    try {
      var request = http.Request(
        'POST',
        Uri.parse('$baseUrl${ApiEndpoints.dashboard}'),
      );
      request.body = json.encode({
        "CategoryId": categoryId,
        "DeviceManufacturer": deviceManufacturer,
        "DeviceModel": deviceModel,
        "DeviceToken": deviceToken,
        "PageIndex": pageIndex,
      });
      request.headers.addAll(await _headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print('Dashboard API Response: $responseBody');
        return json.decode(responseBody);
      } else {
        print('Dashboard API Error: ${response.reasonPhrase}');
        throw Exception(
          'Failed to load dashboard: ${response.statusCode} - ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      print('Dashboard API Exception: $e');
      throw Exception('Network error: $e');
    }
  }

  // Product List API call
  Future<dynamic> getProductList({
    required int subCategoryId,
    int pageIndex = 1,
  }) async {
    try {
      var request = http.Request(
        'POST',
        Uri.parse('$baseUrl${ApiEndpoints.productList}'),
      );
      request.body = json.encode({
        "SubCategoryId": subCategoryId,
        "PageIndex": pageIndex,
      });
      request.headers.addAll(await _headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print('Product List API Response: $responseBody');
        return json.decode(responseBody);
      } else {
        print('Product List API Error: ${response.reasonPhrase}');
        throw Exception(
          'Failed to load product list: ${response.statusCode} - ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      print('Product List API Exception: $e');
      throw Exception('Network error: $e');
    }
  }
}
