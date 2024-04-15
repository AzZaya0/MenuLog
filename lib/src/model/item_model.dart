// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ItemModel {
  final String? name;
  final String? price;
  final String? image;
  final String? category;

  ItemModel({
    this.name,
    this.price,
    this.image,
    this.category,
  });

  ItemModel copyWith({
    String? name,
    String? price,
    String? image,
    String? category,
  }) {
    return ItemModel(
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'image': image,
      'category': category,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemModel(name: $name, price: $price, image: $image, category: $category)';
  }

  @override
  bool operator ==(covariant ItemModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.price == price &&
        other.image == image &&
        other.category == category;
  }

  @override
  int get hashCode {
    return name.hashCode ^ price.hashCode ^ image.hashCode ^ category.hashCode;
  }
}
