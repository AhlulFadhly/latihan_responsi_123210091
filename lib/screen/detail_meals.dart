import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latiha_responsi_fix/model/detail_meal.dart';
import 'package:latiha_responsi_fix/source/load_data_source.dart';
import 'package:url_launcher/url_launcher.dart';

class PageDetailMeal extends ConsumerWidget {
  final String idMeal;
  final String mealName;

  const PageDetailMeal({
    super.key,
    required this.idMeal,
    required this.mealName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String id = idMeal;
    return Scaffold(
      appBar: AppBar(
        title: Text(mealName),
      ),
      body: _buildListUsersBody(),
    );
  }

  Widget _buildListUsersBody() {
    String id = idMeal;
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadDetailMeal(id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
// Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
// Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            MealDetailModel usersModel =
                MealDetailModel.fromJson(snapshot.data);
            return _buildSuccessSection(usersModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(MealDetailModel data) {
    return ListView.builder(
      itemCount: data.meals!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemDetailMeals(context, data.meals![index]);
      },
    );
  }

  Widget _buildItemDetailMeals(BuildContext context, Meals meal) {
    return InkWell(
      child: Column(
        children: [
          Hero(
            tag: meal.idMeal!,
            child: Image.network(
              meal.strMealThumb!,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            // Mengelompokkan strCategory dan strArea dalam satu baris
            mainAxisAlignment:
                MainAxisAlignment.center, // Menengahkan widget dalam Row
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Category : ' + meal.strCategory!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Region : ' + meal.strArea!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Ingredients',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 14),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: meal.ingredients.length,
            itemBuilder: (context, index) {
              if (meal.ingredients[index] != "") {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          meal.ingredients[index]!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          meal.measures[index]!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox
                    .shrink(); // Jika bahan makanan null, widget tidak ditampilkan
              }
            },
          ),
          const SizedBox(height: 24),
          Text(
            'Steps',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: Text(
              meal.strInstructions!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              launchURL(meal.strYoutube!);
            },
            child: Text('Watch Tutorial'),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

Future<void> launchURL(String url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw "Couldn`t launch $_url";
  }
}
