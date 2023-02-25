import 'package:get/get.dart';
import 'package:roussha_store/functions/check_internet.dart';
import 'package:roussha_store/models/product.dart';
import 'package:roussha_store/services/api.dart';

class FilterController extends GetxController {

  RxString selectedColor = "".obs;
  RxString selectedSize = "".obs;
  RxInt minprice = 0.obs;  // not used!
  RxInt maxprice = 0.obs;

  RxBool INTERNET_CONNECTION = false.obs;


  late List<Product> filter_Results = <Product>[].obs;
  RxBool LOADING_PRODUCTS = true.obs;

  late List<String> colorFilter = <String>[].obs;
  RxBool LOADING_COLORS = true.obs;

  late List<String> sizeFilter = <String>[].obs;
  RxBool LOADING_SIZES = true.obs;

  late List<int> priceFilter = <int>[].obs;
  RxBool LOADING_PRICES = true.obs;

  RxBool RANDOMLY = true.obs;

  RxInt saleState = 0.obs;

  fetchColors() async {
    colorFilter.clear();
    LOADING_COLORS(true);
    await ApiData.getColors().then((value) => {
      if(value.isNotEmpty){
        colorFilter.addAll(value)
      }
    });
    LOADING_COLORS(false);
  }

  fetchSizes() async {
    sizeFilter.clear();
    LOADING_SIZES(true);
    await ApiData.getSizes().then((value) => {
      if(value.isNotEmpty){
        sizeFilter.addAll(value)
      }
    });
    LOADING_SIZES(false);
  }

  fetchPrices() async {
    priceFilter.clear();
    LOADING_PRICES(true);
    await ApiData.getPriceFilter().then((value) => {
      if(value.isNotEmpty){
        priceFilter.addAll(value)
      }
    });
    LOADING_PRICES(false);
  }

  fetchRandomProducts() async {
    filter_Results.clear();
    LOADING_PRODUCTS(true);
    RANDOMLY(true);
    await ApiData.randomProducts().then((value) => {
      if(value.isNotEmpty){
        filter_Results.addAll(value)
      }
    });
    LOADING_PRODUCTS(false);
  }

  fetchFilteredProducts() async {
    filter_Results.clear();
    LOADING_PRODUCTS(true);
    RANDOMLY(false);
    await ApiData.filteredProducts(
        color: selectedColor.value,
        size: selectedSize.value,minprice: minprice.value,
        maxprice: maxprice.value).then((value) => {
      if(value.isNotEmpty){
        filter_Results.addAll(value)
      }
    });
    LOADING_PRODUCTS(false);
  }

  clearFilter(){
    selectedColor("");
    selectedSize("");
    minprice(0);
    maxprice(0);
    fetchRandomProducts();
  }

  initController() async {
    fetchRandomProducts();
    fetchColors();
    fetchSizes();
    fetchPrices();
  }

  checkInternet() async {
    await CheckInternet().then((value) => {
      INTERNET_CONNECTION(value)
    });
  }

  @override
  void onInit() async {

    await CheckInternet().then((value) => {
      INTERNET_CONNECTION(value)
    });

    await ApiData.onSale().then((value) => {
      saleState(value)
    });
    super.onInit();
  }
}