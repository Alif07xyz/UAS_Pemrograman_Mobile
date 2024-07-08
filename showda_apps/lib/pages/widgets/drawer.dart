import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 255, 245, 221),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50),
        children: [
          ListTile(
              leading: const Icon(Icons.cookie),
              title: const Text(
                "Product",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/product');
              }),
          ListTile(
              leading: const Icon(Icons.storage),
              title: const Text(
                "Stock",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/stock');
              }),
          ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                "Daftar Reseler",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/reseler');
              }),
          ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text(
                "Invoice",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/invoice');
              }),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text(
              "Keluar",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Keluar Aplikasi"),
                    content: const Text("Apakah Anda yakin ingin keluar?"),
                    actions: <Widget>[
                      TextButton(
                        child: const Text("Ya"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Future.delayed(const Duration(milliseconds: 100), () {
                            SystemNavigator.pop();
                          });
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
          ),
        ],
      ),
    );
  }
}
