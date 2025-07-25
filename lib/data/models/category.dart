// To parse this JSON data, do
//
//     final espCategory = espCategoryFromJson(jsonString);

import 'dart:convert';
import 'product.dart';

EspCategory espCategoryFromJson(String str) =>
    EspCategory.fromJson(json.decode(str));

String espCategoryToJson(EspCategory data) => json.encode(data.toJson());

class EspCategory {
  int? status;
  String? message;
  Result? result;

  EspCategory({this.status, this.message, this.result});

  factory EspCategory.fromJson(Map<String, dynamic> json) => EspCategory(
    status: json["Status"],
    message: json["Message"],
    result: json["Result"] == null ? null : Result.fromJson(json["Result"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Result": result?.toJson(),
  };
}

class Result {
  List<Category>? category;

  Result({this.category});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    category: json["Category"] == null
        ? []
        : List<Category>.from(
            json["Category"]!.map((x) => Category.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "Category": category == null
        ? []
        : List<dynamic>.from(category!.map((x) => x.toJson())),
  };
}

class Category {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int? isAuthorize;
  final int? update080819;
  final int? update130919;
  final List<SubCategory>? subCategories;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.isAuthorize,
    this.update080819,
    this.update130919,
    this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['Id']?.toString() ?? json['id']?.toString() ?? '',
      name: json['Name'] ?? json['name'] ?? '',
      description: json['Description'] ?? json['description'] ?? '',
      imageUrl: json['ImageUrl'] ?? json['imageUrl'] ?? '',
      isAuthorize: json['IsAuthorize'] ?? json['isAuthorize'],
      update080819: json['Update080819'] ?? json['update080819'],
      update130919: json['Update130919'] ?? json['update130919'],
      subCategories: json['SubCategories'] != null
          ? List<SubCategory>.from(
              json['SubCategories']!.map((x) => SubCategory.fromJson(x)),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Description': description,
      'ImageUrl': imageUrl,
      'IsAuthorize': isAuthorize,
      'Update080819': update080819,
      'Update130919': update130919,
      'SubCategories': subCategories?.map((x) => x.toJson()).toList(),
    };
  }
}

class SubCategory {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String categoryId;
  final List<Product>? product;

  SubCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.categoryId,
    this.product,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['Id']?.toString() ?? json['id']?.toString() ?? '',
      name: json['Name'] ?? json['name'] ?? '',
      description: json['Description'] ?? json['description'] ?? '',
      imageUrl: json['ImageUrl'] ?? json['imageUrl'] ?? '',
      categoryId:
          json['CategoryId']?.toString() ??
          json['categoryId']?.toString() ??
          '',
      product: json['Product'] != null
          ? List<Product>.from(json['Product']!.map((x) => Product.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Description': description,
      'ImageUrl': imageUrl,
      'CategoryId': categoryId,
      'Product': product?.map((x) => x.toJson()).toList(),
    };
  }
}
