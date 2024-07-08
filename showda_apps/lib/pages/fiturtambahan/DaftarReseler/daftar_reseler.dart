import 'package:flutter/material.dart';
import 'package:showda_apps/api/reseler.dart';
import 'package:showda_apps/model/reseler.dart';
import 'package:showda_apps/pages/fiturtambahan/DaftarReseler/detailreseler.dart';
import 'package:showda_apps/pages/fiturtambahan/DaftarReseler/formreseler.dart';
import 'package:showda_apps/pages/widgets/drawer.dart';

class reselerPages extends StatefulWidget {
  const reselerPages({super.key});

  @override
  State<reselerPages> createState() => _reselerPagesState();
}

class _reselerPagesState extends State<reselerPages> {
  late Future<List<Reseler>> listReseler;
  final ReselerService = ReselerApi();

  @override
  void initState() {
    super.initState();
    listReseler = ReselerService.getReseler();
  }

  void refreshReselers() {
    setState(() {
      listReseler = ReselerService.getReseler();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title: const Text('Daftar Buyer'),
        backgroundColor: const Color.fromARGB(255, 41, 182, 146),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).popAndPushNamed('/add-reseler'),
          ),
        ],
      ),
      body: FutureBuilder<List<Reseler>>(
          future: listReseler,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Reseler> isiReseler = snapshot.data!;
              return ListView.builder(
                itemCount: isiReseler.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Detailreseler(
                                    reseler: isiReseler[index],
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
                                child: Text(isiReseler[index].buyer,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.black)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                child: Text(
                                    'Status : ${isiReseler[index].status}'),
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
                                      builder: (context) => ReselerForm(
                                        reseler: isiReseler[index],
                                      ),
                                    ),
                                  ).then((_) => refreshReselers());
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Hapus Reseler"),
                                        content: const Text(
                                            "Apakah Anda yakin ingin menghapus Produk ini?"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("Ya"),
                                            onPressed: () async {
                                              bool response =
                                                  await ReselerService
                                                      .deleteReseler(
                                                          isiReseler[index].id);
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
                                                        "Reseler berhasil dihapus"),
                                                  ),
                                                );
                                                // ignore: use_build_context_synchronously
                                                Navigator.of(context).pop();
                                                refreshReselers();
                                              } else {
                                                // ignore: use_build_context_synchronously
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    duration:
                                                        Duration(seconds: 1),
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        "Reseler gagal dihapus"),
                                                  ),
                                                );
                                                // ignore: use_build_context_synchronously
                                                Navigator.of(context).pop();
                                                refreshReselers();
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
