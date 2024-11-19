class Recipe {
  final String name;
  final List<String> ingredients;
  final String instructions;

  Recipe({
    required this.name,
    required this.ingredients,
    required this.instructions,
  });

  @override
  String toString() {
    return 'Recipe: $name\nIngredients: ${ingredients.join(', ')}\nInstructions: $instructions';
  }
}
