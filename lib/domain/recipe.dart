class Recipe {
  final String title;
  final String description;
  final String preparationTime;
  final String ingredients;
  final String instructions;

  Recipe({
    required this.title,
    required this.description,
    required this.preparationTime,
    required this.ingredients,
    required this.instructions,
  });
}

abstract class RecipeRepository {
  Future<List<Recipe>> getAllRecipes();
  Future<Recipe?> getRecipeByTitle(String title);
  Future<void> addRecipe(Recipe recipe);
}
