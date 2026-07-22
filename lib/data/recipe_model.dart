import '../domain/recipe.dart';

class RecipeModel extends Recipe {
  RecipeModel({
    required String title,
    required String ingredients,
    required String instructions,
  }) : super(
          title: title,
          ingredients: ingredients,
          instructions: instructions,
        );

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      title: json['title'],
      ingredients: json['ingredients'],
      instructions: json['instructions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'ingredients': ingredients,
      'instructions': instructions,
    };
  }
}
