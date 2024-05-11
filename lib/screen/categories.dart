import 'package:flutter/material.dart';
import 'package:latiha_responsi_fix/model/category.dart';
import 'package:latiha_responsi_fix/screen/meals.dart';
import 'package:latiha_responsi_fix/source/load_data_source.dart';

class Kategori extends StatefulWidget {
  const Kategori({Key? key}) : super(key: key);
  @override
  State<Kategori> createState() => _KategoriState();
}

class _KategoriState extends State<Kategori>
    with SingleTickerProviderStateMixin{
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: _buildListUsersBody(),
    );
  }

  Widget _buildListUsersBody() {
    return Container(
        child: FutureBuilder(
          future: ApiDataSource.instance.loadCategory(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
// Jika data ada error maka akan ditampilkan hasil error
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
// Jika data ada dan berhasil maka akan ditampilkan hasil datanya
              CategoryModel usersModel = CategoryModel.fromJson(snapshot.data);
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
  @override
  Widget _buildSuccessSection(CategoryModel data) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
      child: GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: data.categories!.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItemCategory(data.categories![index]);
        },
      ),
    );
  }


  Widget _buildItemCategory(Categories kategory) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PageMeal(Kategori: kategory.strCategory!),
        ),
      ),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(kategory.strCategoryThumb!),
            fit: BoxFit.cover,
          ),
        ),
        child: Text(
          kategory.strCategory!,
          style: TextStyle(
            fontSize: 24, // Sesuaikan dengan ukuran teks Anda
            color: Theme.of(context).colorScheme.onBackground,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 3.0,
                color: Colors.black,
              ),
              Shadow(
                offset: Offset(-1, 1),
                blurRadius: 3.0,
                color: Colors.black,
              ),
              Shadow(
                offset: Offset(1, -1),
                blurRadius: 3.0,
                color: Colors.black,
              ),
              Shadow(
                offset: Offset(-1, -1),
                blurRadius: 3.0,
                color: Colors.black,
              ),
            ],
          ),
        ),

      ),
    );
  }

}
