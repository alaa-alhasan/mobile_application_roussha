// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as int,
    name: json['name'] as String,
    slug: json['slug'] as String,
    short_description: json['short_description'] as String?,
    description: json['description'] as String,
    regular_price: json['regular_price'] as String,
    sale_price: json['sale_price'] as String?,
    SKU: json['SKU'] as String,
    stock_status: json['stock_status'] as String,
    featured: json['featured'] as int,
    quantity: json['quantity'] as int,
    image: json['image'] as String?,
    images: json['images'] as String?,
    category_id: json['category_id'] as int?,
    created_at: json['created_at'] as String?,
    updated_at: json['updated_at'] as String?,
    subcategory_id: json['subcategory_id'] as int?,
    vtimes: json['vtimes'] as int,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'short_description': instance.short_description,
      'description': instance.description,
      'regular_price': instance.regular_price,
      'sale_price': instance.sale_price,
      'SKU': instance.SKU,
      'stock_status': instance.stock_status,
      'featured': instance.featured,
      'quantity': instance.quantity,
      'image': instance.image,
      'images': instance.images,
      'category_id': instance.category_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'subcategory_id': instance.subcategory_id,
      'vtimes': instance.vtimes,
    };
