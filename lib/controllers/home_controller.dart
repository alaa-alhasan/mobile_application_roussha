
import 'package:get/get.dart';
import 'package:roussha_store/functions/check_internet.dart';
import 'package:roussha_store/functions/store_auth_info.dart';
import 'package:roussha_store/models/category.dart';
import 'package:roussha_store/models/product.dart';
import 'package:roussha_store/services/api.dart';

class HomeController extends GetxController{

  List<String> timelines = ['Recently Added', 'Most Viewed', 'Featured Products'];
  late String selectedTimeline;

  RxInt product_tag = 0.obs;


  RxBool INTERNET_CONNECTION = false.obs;

  late List<Product> products = <Product>[].obs;
  RxBool LOADING_PRODUCTS = true.obs;

  late List<Product> onSaleProducts = <Product>[].obs;
  RxBool LOADING_ON_SALE_PRODUCTS = true.obs;

  late List<Product> productsByCategory = <Product>[].obs;
  RxBool LOADING_PRODUCTS_BY_CATEGORY = true.obs;

  late List<Category> categories = <Category>[].obs;
  RxBool LOADING_CATEGORIES = true.obs;

  RxInt tab_category_selected_id = 0.obs;

  RxInt saleState = 0.obs;

  changeProductList() async {
    products.clear();
    LOADING_PRODUCTS(true);
    if(selectedTimeline == timelines[0]){
     await ApiData.recentlyAddedProducts().then((value) => {
       if(value.isNotEmpty){
         products.addAll(value)
       }
     });

    }else if(selectedTimeline == timelines[1]){
      await ApiData.mostViewedProducts().then((value) => {
        if(value.isNotEmpty){
          products.addAll(value)
        }
      });

    }else{
      await ApiData.featuredProducts().then((value) => {
        if(value.isNotEmpty){
          products.addAll(value)
        }
      });

    }
    LOADING_PRODUCTS(false);
  }

  getAllCategories() async {
    categories.clear();
    LOADING_CATEGORIES(true);
    await ApiData.allCategories().then((value) => {
      if(value.isNotEmpty){
        categories.addAll(value),
        tab_category_selected_id(categories[0].id),
        fetchOnSaleProducts(),
        fetchProductsByCategory()
      }
    });
    LOADING_CATEGORIES(false);
  }

  fetchOnSaleProducts() async {
    onSaleProducts.clear();
    LOADING_ON_SALE_PRODUCTS(true);
    await ApiData.productsSaleByCategory(tab_category_selected_id.value).then((value) => {
      if(value.isNotEmpty){
        onSaleProducts.addAll(value)
      }
    });
    LOADING_ON_SALE_PRODUCTS(false);
  }

  fetchProductsByCategory() async {
    productsByCategory.clear();
    LOADING_PRODUCTS_BY_CATEGORY(true);
    await ApiData.productsByCategory(tab_category_selected_id.value).then((value) => {
      if(value.isNotEmpty){
        productsByCategory.addAll(value)
      }
    });
    LOADING_PRODUCTS_BY_CATEGORY(false);
  }


  @override
  void onInit() async {

    selectedTimeline = timelines[0];
    changeProductList();

    await CheckInternet().then((value) => {
      INTERNET_CONNECTION(value)
    });

    getAllCategories();

    await ApiData.onSale().then((value) => {
      saleState(value)
    });


    super.onInit();
  }
}