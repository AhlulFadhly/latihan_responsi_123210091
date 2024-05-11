class MealDetailModel {
  final List<Meals>? meals;

  MealDetailModel({
    this.meals,
  });

  factory MealDetailModel.fromJson(Map<String, dynamic> json) {
    return MealDetailModel(
      meals: (json['meals'] as List<dynamic>?)
          ?.map((e) => Meals.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meals': meals?.map((e) => e.toJson()).toList(),
    };
  }
}

class Meals {
  final String? idMeal;
  final String? strMeal;
  final dynamic strDrinkAlternate;
  final String? strCategory;
  final String? strArea;
  final String? strInstructions;
  final String? strMealThumb;
  final String? strTags;
  final String? strYoutube;
  final List<String?> ingredients;
  final List<String?> measures;
  final dynamic strSource;
  final dynamic strImageSource;
  final dynamic strCreativeCommonsConfirmed;
  final dynamic dateModified;

  Meals({
    this.idMeal,
    this.strMeal,
    this.strDrinkAlternate,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    required this.ingredients,
    required this.measures,
    this.strSource,
    this.strImageSource,
    this.strCreativeCommonsConfirmed,
    this.dateModified,
  });

  factory Meals.fromJson(Map<String, dynamic> json) {
    List<String?> ingredients = [];
    List<String?> measures = [];

    for (int i = 1; i <= 20; i++) {
      ingredients.add(json['strIngredient$i']);
      measures.add(json['strMeasure$i']);
    }

    return Meals(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strDrinkAlternate: json['strDrinkAlternate'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strInstructions: json['strInstructions'],
      strMealThumb: json['strMealThumb'],
      strTags: json['strTags'],
      strYoutube: json['strYoutube'],
      ingredients: ingredients,
      measures: measures,
      strSource: json['strSource'],
      strImageSource: json['strImageSource'],
      strCreativeCommonsConfirmed: json['strCreativeCommonsConfirmed'],
      dateModified: json['dateModified'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strDrinkAlternate': strDrinkAlternate,
      'strCategory': strCategory,
      'strArea': strArea,
      'strInstructions': strInstructions,
      'strMealThumb': strMealThumb,
      'strTags': strTags,
      'strYoutube': strYoutube,
      'strSource': strSource,
      'strImageSource': strImageSource,
      'strCreativeCommonsConfirmed': strCreativeCommonsConfirmed,
      'dateModified': dateModified,
    };

    for (int i = 0; i < 20; i++) {
      data['strIngredient${i + 1}'] = ingredients[i];
      data['strMeasure${i + 1}'] = measures[i];
    }

    return data;
  }
}
