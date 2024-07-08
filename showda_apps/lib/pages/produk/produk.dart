import 'package:flutter/material.dart';
import 'package:showda_apps/api/product.dart';
import 'package:showda_apps/model/produk.dart';
import 'package:showda_apps/pages/fiturtambahan/checkout/cart.dart';
import 'package:showda_apps/pages/produk/detailproduk.dart';
import 'package:showda_apps/pages/produk/formproduk.dart';
import 'package:showda_apps/pages/widgets/drawer.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  late final Cart cart;
  late Future<List<Produk>> listProduct;
  final ProductService = ProductApi();

  @override
  void initState() {
    super.initState();
    listProduct = ProductService.getProduk();
  }

  void refreshProducts() {
    setState(() {
      listProduct = ProductService.getProduk();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        backgroundColor: const Color.fromARGB(255, 41, 182, 146),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).popAndPushNamed('/add-product'),
          ),
        ],
      ),
      body: FutureBuilder<List<Produk>>(
          future: listProduct,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Produk> isiProduk = snapshot.data!;
              return ListView.builder(
                itemCount: isiProduk.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Detailproduk(
                                    products: isiProduk[index],
                                    cart: Cart(),
                                  )));
                    },
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(isiProduk[index].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.black)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                child: Text(
                                    'Harga : Rp ${isiProduk[index].price}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                child: Text('Stock : ${isiProduk[index].qty}'),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProdukForm(
                                        product: isiProduk[index],
                                      ),
                                    ),
                                  ).then((_) => refreshProducts());
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Hapus Produk"),
                                        content: const Text(
                                            "Apakah Anda yakin ingin menghapus Produk ini?"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("Ya"),
                                            onPressed: () async {
                                              bool response =
                                                  await ProductService
                                                      .deleteProduk(
                                                          isiProduk[index].id);
                                              if (response) {
                                                // ignore: use_build_context_synchronously
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    duration:
                                                        Duration(seconds: 1),
                                                    backgroundColor:
                                                        Colors.green,
                                                    content: Text(
                                                        "Produk berhasil dihapus"),
                                                  ),
                                                );
                                                // ignore: use_build_context_synchronously
                                                Navigator.of(context).pop();
                                                refreshProducts();
                                              } else {
                                                // ignore: use_build_context_synchronously
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    duration:
                                                        Duration(seconds: 1),
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        "Produk gagal dihapus"),
                                                  ),
                                                );
                                                // ignore: use_build_context_synchronously
                                                Navigator.of(context).pop();
                                                refreshProducts();
                                              }
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("Tidak"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
