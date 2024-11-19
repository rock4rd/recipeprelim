import 'package:riverpod/riverpod.dart';
import '../models/recipe.dart';

// RecipeListNotifier to manage the list of recipes
class RecipeListNotifier extends StateNotifier<List<Recipe>> {
  RecipeListNotifier() : super([]);

  // Add a new recipe to the list
  void addRecipe(Recipe recipe) {
    state = [...state, recipe]; // Adds the new recipe to the list
  }

  // Update an existing recipe at a specific index
  void updateRecipe(int index, Recipe updatedRecipe) {
    if (index >= 0 && index < state.length) {
      state = [
        ...state.sublist(0, index),
        updatedRecipe,
        ...state.sublist(index + 1)
      ]; // Updates the recipe at the given index
    }
  }

  // Delete a recipe at a specific index
  void deleteRecipe(int index) {
    if (index >= 0 && index < state.length) {
      state = [
        ...state.sublist(0, index),
        ...state.sublist(index + 1)
      ]; // Removes the recipe at the given index
    }
  }
}

// StateNotifierProvider to expose RecipeListNotifier
final recipeListProvider =
    StateNotifierProvider<RecipeListNotifier, List<Recipe>>((ref) {
  return RecipeListNotifier();
});
