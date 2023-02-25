

import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category{

  int id;
  String name;
  String slug;
  String? created_at;
  String? updated_at;


  Category({
    required this.id,
    required this.name,
    required this.slug,
    this.created_at,
    this.updated_at

  });

  factory Category.fromJson(Map<String,dynamic> data) => _$CategoryFromJson(data);

  Map<String,dynamic> toJson() => _$CategoryToJson(this);

}