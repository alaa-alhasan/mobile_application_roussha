

import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product{

  int id;
  String name;
  String slug;
  String? short_description;
  String description;
  String regular_price;
  String? sale_price;
  String SKU;
  String stock_status;
  int featured;
  int quantity;
  String? image;
  String? images;
  int? category_id;
  String? created_at;
  String? updated_at;
  int? subcategory_id;
  int vtimes;


  Product({
    required this.id,
    required this.name,
    required this.slug,
    this.short_description,
    required this.description,
    required this.regular_price,
    this.sale_price,
    required this.SKU,
    required this.stock_status,
    required this.featured,
    required this.quantity,
    this.image,
    this.images,
    this.category_id,
    this.created_at,
    this.updated_at,
    this.subcategory_id,
    required this.vtimes

  });

  factory Product.fromJson(Map<String,dynamic> data) => _$ProductFromJson(data);

  Map<String,dynamic> toJson() => _$ProductToJson(this);

}