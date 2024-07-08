import 'package:flutter/material.dart';
import 'package:showda_apps/api/stock.dart';
import 'package:showda_apps/model/stock.dart';
import 'package:showda_apps/pages/stock/detailstock.dart';
import 'package:showda_apps/pages/stock/formstock.dart';

import 'package:showda_apps/pages/widgets/drawer.dart';

class StokcPage extends StatefulWidget {
  const StokcPage({super.key});

  @override
  State<StokcPage> createState() => _StokcPageState();
}

class _StokcPageState extends State<StokcPage> {
  late Future<List<Stock>> listStock;
  final StockService = StockApi();

  @override
  void initState() {
    super.initState();
    listStock = StockService.getStock();
  }

  void refreshStock() {
    setState(() {
      listStock = StockService.getStock();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title: const Text('Daftar Soda Stock'),
        backgroundColor: const Color.fromARGB(255, 41, 182, 146),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).popAndPushNamed('/add-stock'),
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder<List<Stock>>(
            future: listStock,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Stock> isiStock = snapshot.data!;
                return ListView.builder(
                  itemCount: isiStock.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detailstock(
                                      stocks: isiStock[index],
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
                                  child: Text(isiStock[index].name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.black)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  child: Text(
                                      'Pemasok : ${isiStock[index].issuer}'),
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
                                        builder: (context) => StockForm(
                                          stock: isiStock[index],
                                        ),
                                      ),
                                    ).then((_) => refreshStock());
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Hapus Stock"),
                                          content: const Text(
                                              "Apakah Anda yakin ingin menghapus Produk ini?"),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text("Ya"),
                                              onPressed: () async {
                                                bool response =
                                                    await StockService
                                                        .deleteStock(
                                                            isiStock[index].id);
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
                                                          "Stock berhasil dihapus"),
                                                    ),
                                                  );
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.of(context).pop();
                                                  refreshStock();
                                                } else {
                                                  // ignore: use_build_context_synchronously
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      duration:
                                                          Duration(seconds: 1),
                                                      backgroundColor:
                                                          Colors.red,
                                                      content: Text(
                                                          "Stock gagal dihapus"),
                                                    ),
                                                  );
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.of(context).pop();
                                                  refreshStock();
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
      ),
    );
  }
}
