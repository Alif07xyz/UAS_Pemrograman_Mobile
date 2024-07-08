import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:showda_apps/model/stock.dart';

class StockApi {
  final String baseUrl = "https://api.kartel.dev";

  Future<List<Stock>> getStock() async {
    final response = await http.get(Uri.parse('$baseUrl/stocks'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Stock> stocks =
          body.map((dynamic item) => Stock.fromJson(item)).toList();
      return stocks;
    } else {
      throw "gagal memuat stock";
    }
  }

  Future<bool> createStock(
    String name,
    num qty,
    String attr,
    num weight,
    String issuer,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/stocks'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "name": name,
        "qty": qty,
        "attr": attr,
        "weight": weight,
        "issuer": issuer,
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

  Future<bool> updateStock(Stock stock, String id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/stocks/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "name": stock.name,
        "qty": stock.qty,
        "attr": stock.attr,
        "weight": stock.weight,
        "issuer": stock.issuer,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteStock(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/stocks/$id'));
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
