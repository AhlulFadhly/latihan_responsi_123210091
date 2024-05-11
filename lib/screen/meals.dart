import 'package:flutter/material.dart';
import 'package:latiha_responsi_fix/model/meal.dart';
import 'package:latiha_responsi_fix/screen/detail_meals.dart';
import 'package:latiha_responsi_fix/source/load_data_source.dart';
import 'package:transparent_image/transparent_image.dart';

class PageMeal extends StatefulWidget {
  final String Kategori;

  PageMeal({required this.Kategori});
  @override
  State<PageMeal> createState() => _PageMealState();
}

class _PageMealState extends State<PageMeal> {
  @override
  Widget build(BuildContext context) {
    String id = widget.Kategori;
    return Scaffold(
      appBar: AppBar(
        title: Text(id),
      ),
      body: _buildListUsersBody(),
    );
  }

  Widget _buildListUsersBody() {
    String id = widget.Kategori;
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadMeal(id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
// Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
// Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            MealModel usersModel = MealModel.fromJson(snapshot.data);
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

  Widget _buildSuccessSection(MealModel data) {
    return ListView.builder(
      itemCount: data.meals!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemCategory(data.meals![index]);
      },
    );
  }

  Widget _buildItemCategory(Meals meals) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PageDetailMeal(
                    idMeal: meals.idMeal!, mealName: meals.strMeal!))),
        child: Stack(
          children: [
            Hero(
              tag: meals.idMeal!,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meals.strMealThumb!),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meals.strMeal!,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, // Very long text ...
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
