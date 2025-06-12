class GetByIdProduct {
  bool success;
  Data? data;

  GetByIdProduct({required this.success, this.data});

  factory GetByIdProduct.fromJson(Map<String, dynamic> json) {
    return GetByIdProduct(
      success: json['success'] ?? false,
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class Data {
  String id;
  String name;
  String description;
  String details;
  List<String> images;
  Category category;
  double basePrice;
  double discountPercentage;
  String unit;
  String sku;
  String slug;
  String createdAt;
  String updatedAt;
  int v;
  bool inWishlist;

  Data({
    required this.id,
    required this.name,
    required this.description,
    required this.details,
    required this.images,
    required this.category,
    required this.basePrice,
    required this.discountPercentage,
    required this.unit,
    required this.sku,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.inWishlist,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    final List<String> imageUrls = (json['images'] as List<dynamic>? ?? [])
        .map((url) => url.toString().replaceFirst('http://localhost:4055', 'http://192.168.15.66:4055'))
        .toList();

    return Data(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      details: json['details'] ?? '',
      images: imageUrls,
      category: Category.fromJson(json['category'] ?? {}),
      basePrice: (json['basePrice']?.toDouble() ?? 0.0),
      discountPercentage: (json['discountPercentage']?.toDouble() ?? 0.0),
      unit: json['unit'] ?? '',
      sku: json['sku'] ?? '',
      slug: json['slug'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
      inWishlist: json['inWishlist'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'details': details,
      'images': images,
      'category': category.toJson(),
      'basePrice': basePrice,
      'discountPercentage': discountPercentage,
      'unit': unit,
      'sku': sku,
      'slug': slug,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'inWishlist': inWishlist,
    };
  }
}

class Category {
  String id;
  String name;
  String description;
  String image;
  int v;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.v,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'image': image,
      '__v': v,
    };
  }
}