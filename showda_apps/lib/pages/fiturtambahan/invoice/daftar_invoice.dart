import 'package:flutter/material.dart';
import 'package:showda_apps/api/invoice.dart';
import 'package:showda_apps/model/invoice.dart';
import 'package:showda_apps/pages/fiturtambahan/invoice/detailinvoice.dart';
import 'package:showda_apps/pages/fiturtambahan/invoice/forminvoice.dart';
import 'package:showda_apps/pages/widgets/drawer.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  late Future<List<Invoice>> listInvoice;
  final InvoiceService = InvoiceApi();

  @override
  void initState() {
    super.initState();
    listInvoice = InvoiceService.getInvoice();
  }

  void refreshInvoices() {
    setState(() {
      listInvoice = InvoiceService.getInvoice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title: const Text('Daftar Invoice'),
        backgroundColor: const Color.fromARGB(255, 41, 182, 146),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).popAndPushNamed('/add-invoice'),
          ),
        ],
      ),
      body: FutureBuilder<List<Invoice>>(
          future: listInvoice,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Invoice> isiInvoice = snapshot.data!;
              return ListView.builder(
                itemCount: isiInvoice.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailInvoice(
                                    invoice: isiInvoice[index]
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
                                child: Text('Buyer: ${isiInvoice[index].issuer}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.black)),
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
                                      builder: (context) => InvoiceForm(
                                        invoice: isiInvoice[index],
                                      ),
                                    ),
                                  ).then((_) => refreshInvoices());
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Hapus Invoice"),
                                        content: const Text(
                                            "Apakah Anda yakin ingin menghapus Invoice ini?"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("Ya"),
                                            onPressed: () async {
                                              bool response =
                                                  await InvoiceService
                                                      .deleteInvoice(
                                                          isiInvoice[index].id);
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
                                                        "Invoice berhasil dihapus"),
                                                  ),
                                                );
                                                // ignore: use_build_context_synchronously
                                                Navigator.of(context).pop();
                                                refreshInvoices();
                                              } else {
                                                // ignore: use_build_context_synchronously
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    duration:
                                                        Duration(seconds: 1),
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        "Invoice gagal dihapus"),
                                                  ),
                                                );
                                                // ignore: use_build_context_synchronously
                                                Navigator.of(context).pop();
                                                refreshInvoices();
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
