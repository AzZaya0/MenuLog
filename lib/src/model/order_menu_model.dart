// To parse this JSON data, do
//
//     final orderMenuModel = orderMenuModelFromJson(jsonString);

import 'dart:convert';

OrderMenuModel orderMenuModelFromJson(String str) =>
    OrderMenuModel.fromJson(json.decode(str));

String orderMenuModelToJson(OrderMenuModel data) => json.encode(data.toJson());

class OrderMenuModel {
  Menu? menu;

  OrderMenuModel({
    this.menu,
  });

  factory OrderMenuModel.fromJson(Map<String, dynamic> json) => OrderMenuModel(
        menu: json["menu"] == null ? null : Menu.fromJson(json["menu"]),
      );

  Map<String, dynamic> toJson() => {
        "menu": menu?.toJson(),
      };
}

class Menu {
  List<Category>? categories;

  Menu({
    this.categories,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class Category {
  String? name;
  List<Item>? items;

  Category({
    this.name,
    this.items,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  String? name;
  double? price;

  Item({
    this.name,
    this.price,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
      };
}
