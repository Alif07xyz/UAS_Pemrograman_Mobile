import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:showda_apps/model/produk.dart';

class ProductApi {
  final String baseUrl = "https://api.kartel.dev";

  Future<List<Produk>> getProduk() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Produk> products =
          body.map((dynamic item) => Produk.fromJson(item)).toList();
      return products;
    } else {
      throw "gagal memuat produk";
    }
  }

  Future<bool> createProduct(
    String name,
    num price,
    num qty,
    String attr,
    num weight,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "name": name,
        "price": price,
        "qty": qty,
        "attr": attr,
        "weight": weight,
      }),
    );
    var data = jsonDecode(response.body);
    print(data);

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProduk(Produk product, String id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/products/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "name": product.name,
        "price": product.price,
        "qty": product.qty,
        "attr": product.attr,
        "weight": product.weight,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteProduk(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/products/$id'));
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
