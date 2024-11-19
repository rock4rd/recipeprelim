// lib/services/recipe_service.dart

import 'package:riverpod/riverpod.dart';
import '../models/recipe.dart';

class RecipeService {
  final List<Recipe> _recipes = [];

  List<Recipe> get allRecipes => List.unmodifiable(_recipes);

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
  }

  void updateRecipe(int index, Recipe newRecipe) {
    if (index >= 0 && index < _recipes.length) {
      _recipes[index] = newRecipe;
    }
  }

  void deleteRecipe(int index) {
    if (index >= 0 && index < _recipes.length) {
      _recipes.removeAt(index);
    }
  }

  Recipe? getRecipe(int index) {
    if (index >= 0 && index < _recipes.length) {
      return _recipes[index];
    }
    return null;
  }
}

final recipeServiceProvider = Provider((ref) => RecipeService());
