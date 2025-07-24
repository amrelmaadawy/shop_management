import 'package:hive_flutter/adapters.dart';
part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel extends HiveObject {
  @HiveField(0)
  final String categoryName;

  CategoryModel({required this.categoryName});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel &&
          runtimeType == other.runtimeType &&
          categoryName == other.categoryName;

  @override
  int get hashCode => categoryName.hashCode;

  @override
  String toString() => 'CategoryModel(categoryName: $categoryName)';
}
