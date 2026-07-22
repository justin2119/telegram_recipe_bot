class Recipe {
  final String title;
  final String ingredients;
  final String instructions;

  Recipe({
    required this.title,
    required this.ingredients,
    required this.instructions,
  });
}

abstract class RecipeRepository {
  Future<List<Recipe>> getAllRecipes();
  Future<Recipe?> getRecipeByTitle(String title);
  Future<void> addRecipe(Recipe recipe);
}
