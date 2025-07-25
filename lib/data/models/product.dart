// To parse this JSON data, do
//
//     final espProduct = espProductFromJson(jsonString);

import 'dart:convert';

EspProduct espProductFromJson(String str) =>
    EspProduct.fromJson(json.decode(str));

String espProductToJson(EspProduct data) => json.encode(data.toJson());

class EspProduct {
  int? status;
  String? message;
  List<Result>? result;

  EspProduct({this.status, this.message, this.result});

  factory EspProduct.fromJson(Map<String, dynamic> json) => EspProduct(
    status: json["Status"],
    message: json["Message"],
    result: json["Result"] == null
        ? []
        : List<Result>.from(json["Result"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Result": result == null
        ? []
        : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  String? name;
  String? priceCode;
  String? imageName;
  int? id;

  Result({this.name, this.priceCode, this.imageName, this.id});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    name: json["Name"],
    priceCode: json["PriceCode"],
    imageName: json["ImageName"],
    id: json["Id"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "PriceCode": priceCode,
    "ImageName": imageName,
    "Id": id,
  };
}

class Product {
  final String id;
  final String name;
  final String? description;
  final double? price;
  final String imageUrl;
  final String? subcategoryId;
  final List<String>? tags;
  final bool? isAvailable;
  final String? productCode;
  final String? categoryId;
  final String? priceCode;
  final String? imageName;

  Product({
    required this.id,
    required this.name,
    this.description,
    this.price,
    required this.imageUrl,
    this.subcategoryId,
    this.tags,
    this.isAvailable,
    this.productCode,
    this.categoryId,
    this.priceCode,
    this.imageName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['Id']?.toString() ?? json['id']?.toString() ?? '',
      name: json['Name'] ?? json['name'] ?? '',
      description: json['Description'] ?? json['description'],
      price: json['Price'] != null ? (json['Price'] as num).toDouble() : null,
      imageUrl: json['ImageName'] ?? json['ImageUrl'] ?? json['imageUrl'] ?? '',
      subcategoryId:
          json['SubcategoryId']?.toString() ??
          json['subcategoryId']?.toString(),
      tags: json['Tags'] != null
          ? List<String>.from(json['Tags'])
          : json['tags'] != null
          ? List<String>.from(json['tags'])
          : null,
      isAvailable: json['IsAvailable'] ?? json['isAvailable'],
      productCode: json['ProductCode'] ?? json['productCode'],
      categoryId:
          json['CategoryId']?.toString() ?? json['categoryId']?.toString(),
      priceCode: json['PriceCode'] ?? json['priceCode'],
      imageName: json['ImageName'] ?? json['imageName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Description': description,
      'Price': price,
      'ImageUrl': imageUrl,
      'SubcategoryId': subcategoryId,
      'Tags': tags,
      'IsAvailable': isAvailable,
      'ProductCode': productCode,
      'CategoryId': categoryId,
      'PriceCode': priceCode,
      'ImageName': imageName,
    };
  }
}
