import 'package:flutter/material.dart';

class Category {
  final String id;
  final String nama;
  final Color color;

  const Category({
    required this.id,
    required this.nama,
    required this.color,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      nama: json['nama'] as String,
      color: Color(json['color'] as int),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nama': nama,
    'color': color.value,
  };
}
