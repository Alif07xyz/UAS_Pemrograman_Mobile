import 'package:flutter/material.dart';
import 'package:showda_apps/pages/fiturtambahan/DaftarReseler/daftar_reseler.dart';
import 'package:showda_apps/pages/fiturtambahan/DaftarReseler/formreseler.dart';
import 'package:showda_apps/pages/fiturtambahan/invoice/daftar_invoice.dart';
import 'package:showda_apps/pages/fiturtambahan/invoice/forminvoice.dart';
import 'package:showda_apps/pages/produk/formproduk.dart';
import 'package:showda_apps/pages/produk/produk.dart';
import 'package:showda_apps/pages/stock/formstock.dart';
import 'package:showda_apps/pages/stock/stock.dart';
import 'package:showda_apps/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/product': (context) => const ProdukPage(),
          '/add-product': (context) => const ProdukForm(),
          '/stock': (context) => const StokcPage(),
          '/add-stock': (context) => const StockForm(),
          '/reseler': (context) => const reselerPages(),
          '/add-reseler': (context) => const ReselerForm(),
          '/invoice': (context) => const InvoicePage(),
          '/add-invoice': (context) => const InvoiceForm(),
        },
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 138, 224, 191),
          useMaterial3: true,
        ),
        home: const WelcomePages());
  }
}
