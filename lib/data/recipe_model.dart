import '../domain/recipe.dart';

class RecipeModel extends Recipe {
  RecipeModel({
    required String title,
    required String description,
    required String preparationTime,
    required String ingredients,
    required String instructions,
  }) : super(
          title: title,
          description: description,
          preparationTime: preparationTime,
          ingredients: ingredients,
          instructions: instructions,
        );

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      preparationTime: json['preparation_time'] ?? '',
      ingredients: json['ingredients'] ?? '',
      instructions: json['instructions'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'preparation_time': preparationTime,
      'ingredients': ingredients,
      'instructions': instructions,
    };
  }
}
