import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();
  Future<Map<String, dynamic>> loadCategory() {
    return BaseNetwork.get("categories.php");
  }

  Future<Map<String, dynamic>> loadMeal(String kategori) {
    String category = kategori.toString();
    return BaseNetwork.get("filter.php?c=$category");
  }

  Future<Map<String, dynamic>> loadDetailMeal(String idMeal) {
    String id = idMeal.toString();
    return BaseNetwork.get("lookup.php?i=$id");
  }
}
