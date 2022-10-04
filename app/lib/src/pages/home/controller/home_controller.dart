import 'package:app/src/models/category_model.dart';
import 'package:app/src/models/item_model.dart';
import 'package:app/src/pages/home/repository/home_repository.dart';
import 'package:app/src/pages/home/result/home_result.dart';
import 'package:app/src/services/utils_services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final homeRepository = HomeRepository();
  final utilsServices = UtilsServices();

  bool isLoading = false;
  List<CategoryModel> allCategories = [];
  CategoryModel? currentCategory;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    getAllCategories();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();

    getAllProducts();
  }

  Future<void> getAllCategories() async {
    setLoading(true);
    HomeResult<CategoryModel> homeResult =
        await homeRepository.getAllCategories();
    setLoading(false);

    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);

        if (allCategories.isEmpty) return;
        selectCategory(allCategories.first);
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> getAllProducts() async {
    setLoading(true);

    Map<String, dynamic> body = {
      "page": 0,
      "title": null,
      "categoryId": "5mjkt5ERRo",
      "itemsPerPage": 6
    };

    HomeResult<ItemModel> result = await homeRepository.getAllProducts(body);

    setLoading(false);

    result.when(
      success: (dara) {},
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
