import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:roussha_store/models/auth.dart';
import 'package:roussha_store/models/category.dart';
import 'package:roussha_store/models/order_items.dart';
import 'package:roussha_store/models/product.dart';

import '../app_properties.dart';

class ApiData {

  // Home Page Api
  static Future<List<Product>> recentlyAddedProducts() async {
    http.Response response;
    List<dynamic>? jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}recentlyAddedProducts'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body)["result"];
        return jsonResponse!.map((data) => Product.fromJson(data)).toList();
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<Product>> mostViewedProducts() async {
    http.Response response;
    List<dynamic>? jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}mostViewedProducts'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body)["result"];
        return jsonResponse!.map((data) => Product.fromJson(data)).toList();
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<Product>> featuredProducts() async {
    http.Response response;
    List<dynamic>? jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}featuredProducts'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body)["result"];
        return jsonResponse!.map((data) => Product.fromJson(data)).toList();
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<Category>> allCategories() async {
    http.Response response;
    List<dynamic>? jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}allCategories'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body)["result"];
        return jsonResponse!.map((data) => Category.fromJson(data)).toList();
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<Product>> productsByCategory(int id) async {
    http.Response response;
    List<dynamic>? jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}productsByCategory/${id}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body)["result"];
        return jsonResponse!.map((data) => Product.fromJson(data)).toList();
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<Product>> productsSaleByCategory(int id) async {
    http.Response response;
    List<dynamic>? jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}productsSaleByCategory/${id}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body)["result"];
        return jsonResponse!.map((data) => Product.fromJson(data)).toList();
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  // Search Page Api
  static Future<List<Product>> search(String str) async {
    http.Response response;
    List<dynamic>? jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}search/${str}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body)["result"];
        return jsonResponse!.map((data) => Product.fromJson(data)).toList();
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  // Filter Page Api
  static Future<List<Product>> randomProducts() async {
    http.Response response;
    List<dynamic>? jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}randomProducts'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body)["result"];
        return jsonResponse!.map((data) => Product.fromJson(data)).toList();
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<String>> getColors() async {
    List<String> result = [];
    http.Response response;
    var jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}getColors'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body)["result"];
        for (var j in jsonResponse) {
          result.add(j);
        }
        return result;
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<String>> getSizes() async {
    List<String> result = [];
    http.Response response;
    var jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}getSizes'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body)["result"];
        for (var j in jsonResponse) {
          result.add(j);
        }
        return result;
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<int>> getPriceFilter() async {
    List<int> result = [];
    http.Response response;
    var jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}getPriceFilter'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body)["result"];
        for (var j in jsonResponse) {
          result.add(j);
        }
        return result;
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<Product>> filteredProducts(
      {String? color, String? size, int? minprice, int? maxprice}) async {
    http.Response response;
    List<dynamic>? jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}filteredProducts'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({
            if(color != "") 'color': color,
            if(size != "") 'size': size,
            if(minprice != 0) 'minprice': minprice,
            if(maxprice != 0) 'maxprice': maxprice
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body)["result"];
        return jsonResponse!.map((data) => Product.fromJson(data)).toList();
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  // Product Page Api
  static Future<List<String>> getProductColors(int id) async {
    List<String> result = [];
    http.Response response;
    var jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}getProductColors/${id}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body)["result"];
        for (var j in jsonResponse) {
          result.add(j);
        }
        return result;
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<String>> getProductSizes(int id) async {
    List<String> result = [];
    http.Response response;
    var jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}getProductSizes/${id}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body)["result"];
        for (var j in jsonResponse) {
          result.add(j);
        }
        return result;
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<Product>> relatedProducts(int id) async {
    http.Response response;
    List<dynamic>? jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}relatedProducts/${id}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body)["result"];
        return jsonResponse!.map((data) => Product.fromJson(data)).toList();
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<int> increaseViews(int id) async {
    http.Response response;
    int jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}increaseViews/${id}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  static Future<int> onSale() async {
    http.Response response;
    int jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}onSale'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  // Auth Page Api
  static Future<Auth> login(String email, String password) async {
    http.Response response;
    var jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}login'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({
            'email': email,
            'password': password
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return Auth.fromJson(jsonResponse);
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return Future.error("error!");
    }
  }

  static Future<Auth> register(String name, String email, String password) async {
    http.Response response;
    var jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}register'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({
            'name': name,
            'email': email,
            'password': password
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return Auth.fromJson(jsonResponse);
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return Future.error("error!");
    }
  }

  // Profile Page Api
  static Future<dynamic> nameAndImage(String token) async {
    http.Response response;
    var jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}nameAndImage'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        print('the response of api is: ${jsonResponse}');
        return jsonResponse;
      } else {
        print('here is problem');
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<int> logout(String token) async {
    http.Response response;
    int jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}logout'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  static Future<dynamic> myProfile(String token) async {
    http.Response response;
    var jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}myProfile'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse['result'];
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<int> updateMyProfile(
      {required String token,
      File? image_path,
      required String name,
      required String mobile,
      required String date_of_birth,
      required String line1,
      required String line2,
      required String city,
      required String province,
      required String country,
      required String zipcode}) async {

    try{

      var request = http.MultipartRequest('POST', Uri.parse('${apipath}updateMyProfile'));
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if(image_path != null){
        request.files.add(await http.MultipartFile.fromPath('image', image_path.path));
      }
      request.fields['name'] = name;
      request.fields['mobile'] = mobile;
      request.fields['date_of_birth'] = date_of_birth;
      request.fields['line1'] = line1;
      request.fields['line2'] = line2;
      request.fields['city'] = city;
      request.fields['province'] = province;
      request.fields['country'] = country;
      request.fields['zipcode'] = zipcode;

      var response = await request.send();
      var responsed = await http.Response.fromStream(response);
      final responseData = json.decode(responsed.body);

      if(response.statusCode == 200 || response.statusCode == 201){
        return 1;
      }else{
        return 0;
      }

    }catch (e){
      return 0;
    }

  }

  // Order Page Api
  static Future<List<dynamic>> myOrders(String token) async {
    http.Response response;
    List<dynamic> jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}myOrders'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<OrderItems>> orderItems(String token, int order_id) async {
    http.Response response;
    List<OrderItems> result = [];
    List<dynamic> jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}orderItems'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'order_id': order_id,
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        for (var item in jsonResponse) {
          OrderItems temp = OrderItems(
            price: item['price'],
            quantity: item['quantity'],
            option: item['option'],
            product: Product.fromJson(item['product'])
          );
          result.add(temp);
        }
        return result;
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<dynamic> orderShipping(String token, int order_id) async {
    http.Response response;
    var jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}orderShipping'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'order_id': order_id,
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<dynamic> orderTransaction(String token, int order_id) async {
    http.Response response;
    var jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}orderTransaction'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'order_id': order_id,
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  // Wishlist Page Api
  static Future<List<dynamic>> myWishlist(String token) async {
    http.Response response;
    List<dynamic> jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}myWishlist'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<Product> productById(int id) async {
    http.Response response;
    var jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}productById/${id}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body)["result"];
        return Product.fromJson(jsonResponse);
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return Future.error('error!');
    }
  }

  static Future<int> removeItemWishlist(String token, String rowId) async {
    http.Response response;
    int jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}removeItemWishlist'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'rowId': rowId,
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  static Future<int> moveToCart(String token, String rowId, int onSale) async {
    http.Response response;
    int jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}moveToCart'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'rowId': rowId,
            'onSale': onSale
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  static Future<int> clearWishlist(String token) async {
    http.Response response;
    int jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}clearWishlist'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  static Future<int> inWishlist({required String token, required int id}) async {
    http.Response response;
    int jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}inWishlist'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'product_id': id,
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return -1;
      }
    } catch (e) {
      print(e);
      return -1;
    }
  }

  static Future<int> addToWishlist({required String token, required int id}) async {
    http.Response response;
    int jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}addToWishlist'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'product_id': id,
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return -1;
      }
    } catch (e) {
      print(e);
      return -1;
    }
  }

  static Future<int> removeProductFromWishlist({required String token, required int id}) async {
    http.Response response;
    int jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}removeProductFromWishlist'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'id': id,
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return -1;
      }
    } catch (e) {
      print(e);
      return -1;
    }
  }

  // Cart Page Api
  static Future<List<dynamic>> myCart(String token) async {
    http.Response response;
    List<dynamic> jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}myCart'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return Future.error(response.reasonPhrase!);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<int> removeItemCart(String token, String rowId) async {
    http.Response response;
    int jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}removeItemCart'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'rowId': rowId,
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  static Future<int> clearCart(String token) async {
    http.Response response;
    int jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}clearCart'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  static Future<List<String>> cartSummary(String token) async {
    List<String> result = [];
    http.Response response;
    var jsonResponse;
    try {
      response = await http.get(
          Uri.parse('${apipath}cartSummary'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        for (var j in jsonResponse) {
          result.add(j);
        }
        return result;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<int> increaseItemCartQuantity(String token, String rowId) async {
    http.Response response;
    int jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}increaseItemCartQuantity'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'rowId': rowId,
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  static Future<int> decreaseItemCartQuantity(String token, String rowId) async {
    http.Response response;
    int jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}decreaseItemCartQuantity'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'rowId': rowId,
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  static Future<int> inCart({required String token, required int id}) async {
    http.Response response;
    int jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}inCart'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'product_id': id,
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return -1;
      }
    } catch (e) {
      print(e);
      return -1;
    }
  }

  static Future<int> addToCart({required String token, required int id, required String color, required String size, required int onSale}) async {
    http.Response response;
    int jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}addToCart'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'product_id': id,
            if(color != "") 'Color' : color,
            if(size != "") 'Size' : size,
            'onSale': onSale,
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return -1;
      }
    } catch (e) {
      print(e);
      return -1;
    }
  }

  static Future<int> removeProductFromCart({required String token, required int id}) async {
    http.Response response;
    int jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}removeProductFromCart'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'id': id,
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return -1;
      }
    } catch (e) {
      print(e);
      return -1;
    }
  }

  // Support Page Api
  static Future<int> sendMessage(String token, String name, String email, String phone, String comment) async {
    http.Response response;
    int jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}sendMessage'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'name': name,
            'email': email,
            'phone': phone,
            'comment': comment,
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }


  // Checkout Page Api
  static Future<List<dynamic>> applyCoupon(String token, String coupon_code) async {
    List<dynamic> result = [];
    http.Response response;
    var jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}applyCoupon'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'coupon_code': coupon_code,
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        for (var j in jsonResponse) {
          result.add(j);
        }
        return result;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<dynamic>> placeOrder({
    required String token,

    required String subtotal,
    required String discount,
    required String tax,
    required String total,

    required String firstname,
    required String lastname,
    required String email,
    required String mobile,
    required String line1,
    required String line2,
    required String city,
    required String province,
    required String country,
    required String zipcode,

    required int is_shipping_different,

    required String s_firstname,
    required String s_lastname,
    required String s_email,
    required String s_mobile,
    required String s_line1,
    required String s_line2,
    required String s_city,
    required String s_province,
    required String s_country,
    required String s_zipcode,

    required String number,
    required String exp_month,
    required String exp_year,
    required String cvc,

  }) async {
    List<dynamic> result = [];
    http.Response response;
    var jsonResponse;
    try {
      response = await http.post(
          Uri.parse('${apipath}placeOrder'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'subtotal' : subtotal,
            'discount' : discount,
            'tax' : tax,
            'total' : total,
            'firstname' : firstname,
            'lastname' : lastname,
            'email' : email,
            'mobile' : mobile,
            'line1' : line1,
            'line2' : line2,
            'city' : city,
            'province' : province,
            'country' : country,
            'zipcode' : zipcode,
            'is_shipping_different' : is_shipping_different,
            's_firstname' : s_firstname,
            's_lastname' : s_lastname,
            's_email' : s_email,
            's_mobile' : s_mobile,
            's_line1' : s_line1,
            's_line2' : s_line2,
            's_city' : s_city,
            's_province' : s_province,
            's_country' : s_country,
            's_zipcode' : s_zipcode,
            'number' : number,
            'exp_month' : exp_month,
            'exp_year' : exp_year,
            'cvc' : cvc
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        for (var j in jsonResponse) {
          result.add(j);
        }
        return result;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }



}