import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:roussha_store/functions/store_auth_info.dart';
import 'package:roussha_store/models/product.dart';
import 'package:roussha_store/services/api.dart';

class ProductController extends GetxController{

  final Product product;

  ProductController({required this.product});

  List<String> gallery = [];
  RxBool PRODUCTS_HAS_GALLERY = false.obs;

  late List<String> productSizes = <String>[].obs;
  late List<Color> productColors = <Color>[].obs;
  RxBool LOADING_PRODUCT_PROPERTIES = true.obs;

  late List<Product> relatedProducts = <Product>[].obs;
  RxBool LOADING_RELATED_PRODUCTS = true.obs;

  RxInt in_wishlist = 0.obs;
  RxInt in_cart = 0.obs;

  RxBool CART_WISH_ADD_REMOVE_LOADING = false.obs;
  RxString message = "".obs;

  RxString selected_color_attr = "".obs;
  RxString selected_size_attr = "".obs;

  RxInt saleState = 0.obs;

  initializeProduct() async {

    if(product.images != null){
      getGallery(product.images!);
    }
    getProperties();

    selected_color_attr("");
    selected_size_attr("");

    await isLogin().then((value) => {
      if(value == true){
        inWishlist(),
        inCart()
      }
    });

    await ApiData.increaseViews(product.id).then((value) => {
      // nothing to happen
    });

  }

  getGallery(String images){
    gallery.clear();
    PRODUCTS_HAS_GALLERY(true);
    List<String> temp = images.split(",");
    for(String t in temp){
      if(t.isNotEmpty){
        gallery.add(t);
      }
    }
  }

  getProperties() async {
    LOADING_PRODUCT_PROPERTIES(true);

    await ApiData.getProductColors(product.id).then((value) => {
      if(value.isNotEmpty){
        pikColors(value)
      }
    });

    await ApiData.getProductSizes(product.id).then((value) => {
      if(value.isNotEmpty){
        productSizes.addAll(value)
      }
    });

    LOADING_PRODUCT_PROPERTIES(false);
  }

  pikColors(List<String> val){
    for(String s in val){
      switch(s) {

        case "red": { productColors.add(Colors.red); } break;
        case "green": { productColors.add(Colors.green); } break;
        case "blue": { productColors.add(Colors.blue); } break;
        case "black": { productColors.add(Colors.black); } break;
        case "brown": { productColors.add(Colors.brown); } break;
        case "pink": { productColors.add(Colors.pink); } break;
        case "gold": { productColors.add(Colors.amber); } break;
        case "purple": { productColors.add(Colors.purple); } break;
        case "white": { productColors.add(Colors.white); } break;
        case "orange": { productColors.add(Colors.orange); } break;

        default: {
          //statements;
        }
        break;
      }
    }
  }

  fetchRelatedProducts() async {
    relatedProducts.clear();
    LOADING_RELATED_PRODUCTS(true);
    await ApiData.relatedProducts(product.id).then((value) => {
      if(value.isNotEmpty){
        relatedProducts.addAll(value)
      }
    });
    LOADING_RELATED_PRODUCTS(false);
  }

  inWishlist() async {
    String? token = await getToken();
    await ApiData.inWishlist(token: token!, id: product.id).then((value) => {
      in_wishlist(value)
    });
  }

  inCart() async {
    String? token = await getToken();
    await ApiData.inCart(token: token!, id: product.id).then((value) => {
      in_cart(value)
    });
  }

  Future addToWishlist() async {
    CART_WISH_ADD_REMOVE_LOADING(true);
    String? token = await getToken();
    await ApiData.addToWishlist(token: token!, id: product.id).then((value) => {
      if(value == 1){
        message("Product added to Wishlist successfully!"), inWishlist()
      },
      if(value == 0){
        message("Failed adding product to Wishlist!")
      },
      if(value == -1){
        message("something wrong error!")
      },
      CART_WISH_ADD_REMOVE_LOADING(false)
    });
    CART_WISH_ADD_REMOVE_LOADING(false);
  }

  Future removeProductFromWishlist() async {
    CART_WISH_ADD_REMOVE_LOADING(true);
    String? token = await getToken();
    await ApiData.removeProductFromWishlist(token: token!, id: product.id).then((value) => {
      if(value == 1){
        message("Product removed from Wishlist successfully!"), inWishlist()
      },
      if(value == 0){
        message("Failed removing product from Wishlist!")
      },
      if(value == -1){
        message("something wrong error!")
      },
      CART_WISH_ADD_REMOVE_LOADING(false)
    });
    CART_WISH_ADD_REMOVE_LOADING(false);
  }

  Future addToCart() async {
    CART_WISH_ADD_REMOVE_LOADING(true);
    String? token = await getToken();

    int onSale = 0;
    saleState.value == 1 && product.sale_price != null? onSale = 1 : onSale = 0;

    await ApiData.addToCart(token: token!, id: product.id, color: selected_color_attr.value, size: selected_size_attr.value, onSale: onSale).then((value) => {
      if(value == 1){
        message("Product added to Cart successfully!"), inCart()
      },
      if(value == 0){
        message("Failed adding product to Cart!")
      },
      if(value == -1){
        message("something wrong error!")
      },
      CART_WISH_ADD_REMOVE_LOADING(false)
    });
    CART_WISH_ADD_REMOVE_LOADING(false);
  }

  Future removeProductFromCart() async {
    CART_WISH_ADD_REMOVE_LOADING(true);
    String? token = await getToken();
    await ApiData.removeProductFromCart(token: token!, id: product.id).then((value) => {
      if(value == 1){
        message("Product removed from Cart successfully!"), inCart()
      },
      if(value == 0){
        message("Failed removing product from Cart!")
      },
      if(value == -1){
        message("something wrong error!")
      },
      CART_WISH_ADD_REMOVE_LOADING(false)
    });
    CART_WISH_ADD_REMOVE_LOADING(false);
  }

  calculateColorFromString(Color color) {

    if(color == Colors.red){ selected_color_attr("red"); }
    if(color == Colors.green){ selected_color_attr("green"); }
    if(color == Colors.blue){ selected_color_attr("blue"); }
    if(color == Colors.black){ selected_color_attr("black"); }
    if(color == Colors.brown){ selected_color_attr("brown"); }
    if(color == Colors.pink){ selected_color_attr("pink"); }
    if(color == Colors.amber){ selected_color_attr("gold"); }
    if(color == Colors.purple){ selected_color_attr("purple"); }
    if(color == Colors.white){ selected_color_attr("white"); }
    if(color == Colors.orange){ selected_color_attr("orange"); }

  }

  @override
  void onInit() async {

    initializeProduct();
    fetchRelatedProducts();

    await ApiData.onSale().then((value) => {
      saleState(value)
    });

    super.onInit();
  }
}