import 'package:http/http.dart' as http;
import 'package:showda_apps/model/invoice.dart';
import 'dart:convert';

class InvoiceApi {
  final String baseUrl = "https://api.kartel.dev";

  Future<List<Invoice>> getInvoice() async {
    final response = await http.get(Uri.parse('$baseUrl/goods'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Invoice> invoices =
          body.map((dynamic item) => Invoice.fromJson(item)).toList();
      return invoices;
    } else {
      throw "gagal memuat inovice";
    }
  }

  Future<bool> createInvoice(
    String saleid,
    String productid,
    num qty,
    String issuer,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/goods'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "sale_id": saleid,
        "product_id": productid,
        "qty": qty,
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

  Future<bool> updateInvoice(Invoice invoice, String id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/goods/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "sale_id": invoice.saleid,
        "product_id": invoice.productid,
        "qty": invoice.qty,
        "issuer": invoice.issuer,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteInvoice(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/goods/$id'));
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
