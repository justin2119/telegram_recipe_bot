import 'dart:convert';
import 'dart:io';
import '../domain/recipe.dart';
import 'recipe_model.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final String filePath = 'recipes.json';

  final List<RecipeModel> _defaultRecipes = [
    RecipeModel(
      title: 'Fufu',
      ingredients: '1kg d\'igname (variété Laboco de préférence), de l\'eau pour la cuisson.',
      instructions: '1. Épluchez les tubercules d\'igname, coupez-les en gros morceaux et lavez-les soigneusement.\n2. Mettez les morceaux dans une marmite, ajoutez de l\'eau à hauteur et portez à ébullition jusqu\'à ce qu\'ils soient bien tendres.\n3. Égouttez les morceaux et pilez-les énergiquement dans un mortier (ou utilisez un robot pilonneur) jusqu\'à obtenir une pâte blanche, élastique, lisse et sans grumeaux.\n4. Formez des boules et servez chaud avec une sauce graine, une sauce arachide ou une sauce claire au poisson/viande.',
    ),
    RecipeModel(
      title: 'Ablo',
      ingredients: '250g de farine de maïs fin, 100g de farine de riz, 50g de sucre, 1 sachet de levure boulangère, une pincée de sel, eau tiède.',
      instructions: '1. Dans un saladier, mélangez la farine de maïs, la farine de riz, le sucre et le sel.\n2. Délayez la levure dans un peu d\'eau tiède, puis incorporez-la au mélange de farines.\n3. Ajoutez progressivement de l\'eau tiède tout en mélangeant pour obtenir une pâte homogène, légèrement plus épaisse qu\'une pâte à crêpes.\n4. Couvrez et laissez fermenter dans un endroit chaud pendant environ 3 à 4 heures (la pâte doit doubler de volume).\n5. Versez la pâte dans des petits moules préalablement huilés et faites cuire à la vapeur pendant 15 à 20 minutes jusqu\'à ce que les pains soient bien gonflés et moelleux.\n6. Dégustez avec du poisson frit et une sauce tomate pimentée.',
    ),
    RecipeModel(
      title: 'Riz au Gras / Jollof Togolais',
      ingredients: '500g de riz long grain, 500g de viande (boeuf ou poulet), 3 tomates fraîches mixées, 2 cuillères à soupe de concentré de tomate, 2 oignons, 1 poivron, piment vert, ail, gingembre, huile végétale, bouillon de cube, sel, laurier.',
      instructions: '1. Coupez la viande en morceaux, assaisonnez (ail, gingembre, sel) et faites-la dorer dans de l\'huile chaude.\n2. Retirez la viande et, dans la même huile, faites revenir les oignons émincés.\n3. Ajoutez le concentré de tomate, laissez cuire 2 minutes, puis versez les tomates fraîches mixées avec le poivron.\n4. Laissez mijoter la sauce jusqu\'à ce que l\'huile remonte à la surface.\n5. Remettez la viande, ajoutez de l\'eau (ou du bouillon) et portez à ébullition.\n6. Lavez le riz et versez-le dans la marmite. Le liquide doit dépasser le riz d\'environ 2 cm.\n7. Ajoutez le laurier et le piment entier. Couvrez hermétiquement et laissez cuire à feu très doux pendant 20 à 25 minutes jusqu\'à ce que le riz soit tendre et les grains bien détachés.',
    ),
    RecipeModel(
      title: 'Akpan',
      ingredients: '500g de pâte de maïs fermentée (Ogi/Kamou), eau, sucre selon le goût, lait concentré (sucré ou non), glaçons.',
      instructions: '1. Prélevez une partie de la pâte de maïs fermentée et délayez-la dans une grande quantité d\'eau pour obtenir un liquide fluide.\n2. Portez ce mélange à ébullition dans une casserole tout en remuant sans cesse avec une spatule en bois.\n3. Continuez de remuer jusqu\'à ce que le mélange épaississe et devienne translucide (comme une bouillie très épaisse).\n4. Retirez du feu et versez dans un récipient pour laisser refroidir complètement.\n5. Pour servir, prélevez des morceaux de cette gelée, mettez-les dans un bol, ajoutez du lait, du sucre et des glaçons. Mélangez bien et consommez très frais.',
    ),
    RecipeModel(
      title: 'Djenkoumé',
      ingredients: '300g de farine de maïs rouge (maïs légèrement torréfié avant mouture), 1 litre de bouillon de poulet bien assaisonné, 2 cuillères à soupe d\'huile de palme ou d\'huile végétale, 1 oignon mixé, 2 tomates mixées, ail, gingembre, piment.',
      instructions: '1. Dans une cocotte, préparez une base de sauce en faisant revenir l\'oignon, l\'ail, le gingembre et la tomate dans l\'huile.\n2. Versez le bouillon de poulet (très important pour le goût) et portez à ébullition.\n3. Prélevez un bol de ce bouillon et mettez-le de côté.\n4. Versez la farine de maïs en pluie dans la cocotte tout en remuant vigoureusement pour éviter les grumeaux.\n5. Si la pâte est trop dure, ajoutez progressivement le bouillon mis de côté.\n6. Travaillez la pâte sur le feu pendant environ 10 minutes jusqu\'à ce qu\'elle se détache des parois de la cocotte et soit bien cuite.\n7. Formez des boules et servez avec du poulet frit et une sauce tomate pimentée.',
    ),
  ];

  Future<void> _saveToFile(List<RecipeModel> recipes) async {
    final file = File(filePath);
    final jsonString = jsonEncode(recipes.map((e) => e.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  @override
  Future<List<Recipe>> getAllRecipes() async {
    final file = File(filePath);
    
    if (!await file.exists()) {
      await _saveToFile(_defaultRecipes);
      return _defaultRecipes;
    }
    
    final jsonString = await file.readAsString();
    if (jsonString.trim().isEmpty) {
      await _saveToFile(_defaultRecipes);
      return _defaultRecipes;
    }

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => RecipeModel.fromJson(e)).toList();
    } catch (e) {
      await _saveToFile(_defaultRecipes);
      return _defaultRecipes;
    }
  }

  @override
  Future<Recipe?> getRecipeByTitle(String title) async {
    final recipes = await getAllRecipes();
    try {
      return recipes.firstWhere((r) => r.title.toLowerCase() == title.toLowerCase());
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> addRecipe(Recipe recipe) async {
    final recipes = await getAllRecipes();
    final models = recipes.map((e) => RecipeModel(
      title: e.title,
      ingredients: e.ingredients,
      instructions: e.instructions,
    )).toList();
    
    models.add(RecipeModel(
      title: recipe.title,
      ingredients: recipe.ingredients,
      instructions: recipe.instructions,
    ));
    
    await _saveToFile(models);
  }
}
