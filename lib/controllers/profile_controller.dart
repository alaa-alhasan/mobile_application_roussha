import 'package:get/get.dart';
import 'package:roussha_store/functions/check_internet.dart';
import 'package:roussha_store/functions/store_auth_info.dart';
import 'package:roussha_store/models/product.dart';
import 'package:roussha_store/models/wishlist.dart';
import 'package:roussha_store/services/api.dart';

class ProfileController extends GetxController {

  RxBool INTERNET_CONNECTION = false.obs;


  RxString username = "".obs;
  RxString image = "".obs;

  RxBool LOGOUT_DONE = false.obs;
  RxBool LOGOUT_LOADING = false.obs;


  late List<Wishlist> my_wishlist = <Wishlist>[].obs;
  RxBool WISHLIST_LOADING = false.obs;
  RxBool REMOVE_ITEM_WISHLIST_LOADING = false.obs;

  RxInt saleState = 0.obs;

  getNameAndImage() async {
    String? token = await getToken();
    await ApiData.nameAndImage(token!).then((value) => {
      username(value['username']?? ""),
      image(value['image']?? "")
    });

    await setUsername(username.value);

  }

  Future<bool> logout() async {
    LOGOUT_LOADING(true);
    String? token = await getToken();
    await ApiData.logout(token!).then((value) => {
      if(value == 1){
        clearData(),
        setUsername(username.value),
        LOGOUT_DONE(true),
      }
    });
    LOGOUT_LOADING(false);
    if(LOGOUT_DONE.value == true){
      return true;
    }else{
      return false;
    }
  }


  fetchMyWishlist() async {
    my_wishlist.clear();
    WISHLIST_LOADING(true);
    String? token = await getToken();
    await ApiData.myWishlist(token!).then((value) => {
      if(value.isNotEmpty){
        combinWishlist(value)
      }
    });
    WISHLIST_LOADING(false);
  }

  combinWishlist(var value) async {
    for(var v in value){
      String rowId = v['rowId'];
      Product product = await productById(v['id']);

      my_wishlist.add(Wishlist(rowId, product));
    }
  }

  Future<Product> productById(int id) async {
    late Product p;
    await ApiData.productById(id).then((value) => {
      p = value
    });
    return p;
  }

  removeItemWishlist(String rowId) async {

      REMOVE_ITEM_WISHLIST_LOADING(true);

      String? token = await getToken();
      await ApiData.removeItemWishlist(token!, rowId).then((value) => {
        if(value == 1){
          REMOVE_ITEM_WISHLIST_LOADING(false),
          fetchMyWishlist()
        }
      });

      REMOVE_ITEM_WISHLIST_LOADING(false);
    }

  moveToCart(String rowId, int index) async {

    REMOVE_ITEM_WISHLIST_LOADING(true);

    String? token = await getToken();

    int onSale = 0;
    saleState.value == 1 && my_wishlist[index].product.sale_price != null? onSale = 1 : onSale = 0;

    await ApiData.moveToCart(token!, rowId, onSale).then((value) => {
      if(value == 1){
        REMOVE_ITEM_WISHLIST_LOADING(false),
        fetchMyWishlist()
      }
    });

    REMOVE_ITEM_WISHLIST_LOADING(false);
  }

  clearWishlist() async {

    REMOVE_ITEM_WISHLIST_LOADING(true);

    String? token = await getToken();

    await ApiData.clearWishlist(token!).then((value) => {
      if(value == 1){
        REMOVE_ITEM_WISHLIST_LOADING(false),
        fetchMyWishlist()
      }
    });

    REMOVE_ITEM_WISHLIST_LOADING(false);

  }


  initController() async {
    await getUsername().then((value) => value?? username(value));
    getNameAndImage();
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
