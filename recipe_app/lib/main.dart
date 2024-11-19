import 'dart:io';
import 'package:riverpod/riverpod.dart';
import 'models/recipe.dart';
import 'providers/recipe_provider.dart';

void main() {
  final container = ProviderContainer();
  final recipeListNotifier = container.read(recipeListProvider.notifier);

  while (true) {
    print('Recipe System');
    print('1. View Recipes');
    print('2. Add Recipe');
    print('3. Update Recipe');
    print('4. Delete Recipe');
    print('5. Exit');
    stdout.write('Choose an option: ');

    final choice = stdin.readLineSync();

    if (choice == null || !['1', '2', '3', '4', '5'].contains(choice)) {
      print('Invalid option. Please enter a number between 1 and 5.');
      continue;
    }

    switch (choice) {
      case '1':
        viewRecipes(container);
        break;
      case '2':
        addRecipe(container);
        break;
      case '3':
        updateRecipe(container);
        break;
      case '4':
        deleteRecipe(container);
        break;
      case '5':
        print('Exiting...');
        return;
      default:
        print('Invalid option. Please try again.');
    }
  }
}

void viewRecipes(ProviderContainer container) {
  final recipeList = container.read(recipeListProvider);
  if (recipeList.isEmpty) {
    print('No recipes available.');
  } else {
    for (int i = 0; i < recipeList.length; i++) {
      print('$i. ${recipeList[i]}');
    }
  }
}

void addRecipe(ProviderContainer container) {
  stdout.write('Enter recipe name: ');
  final name = stdin.readLineSync() ?? '';
  stdout.write('Enter ingredients (comma separated): ');
  final ingredients = stdin.readLineSync() ?? '';
  stdout.write('Enter instructions: ');
  final instructions = stdin.readLineSync() ?? '';

  final newRecipe = Recipe(
    name: name,
    ingredients: ingredients.split(','),
    instructions: instructions,
  );

  container.read(recipeListProvider.notifier).addRecipe(newRecipe);
  print('Recipe added!');
}

void updateRecipe(ProviderContainer container) {
  stdout.write('Enter recipe index to update: ');
  final index = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
  final currentRecipe = container.read(recipeListProvider)[index];

  if (currentRecipe != null) {
    stdout.write('Enter new recipe name (current: ${currentRecipe.name}): ');
    final name = stdin.readLineSync() ?? currentRecipe.name;
    stdout.write('Enter new ingredients (comma separated, current: ${currentRecipe.ingredients}): ');
    final ingredients = stdin.readLineSync() ?? currentRecipe.ingredients.join(',');
    stdout.write('Enter new instructions (current: ${currentRecipe.instructions}): ');
    final instructions = stdin.readLineSync() ?? currentRecipe.instructions;

    final updatedRecipe = Recipe(
      name: name,
      ingredients: ingredients.split(','),
      instructions: instructions,
    );

    container.read(recipeListProvider.notifier).updateRecipe(index, updatedRecipe);
    print('Recipe updated!');
  } else {
    print('Invalid index.');
  }
}

void deleteRecipe(ProviderContainer container) {
  stdout.write('Enter recipe index to delete: ');
  final index = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
  container.read(recipeListProvider.notifier).deleteRecipe(index);
  print('Recipe deleted!');
}
