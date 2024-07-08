import 'package:flutter/material.dart';
import 'package:showda_apps/api/reseler.dart';
import 'package:showda_apps/model/reseler.dart';

class ReselerForm extends StatefulWidget {
  final Reseler? reseler;

  const ReselerForm({super.key, this.reseler});

  @override
  _ReselerFormState createState() => _ReselerFormState();
}

class _ReselerFormState extends State<ReselerForm> {
  final ReselerApi reselerApi = ReselerApi();

  final _buyerController = TextEditingController();
  final _phnController = TextEditingController();
  final _dateController = TextEditingController();
  final _statusController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.reseler != null) {
      _buyerController.text = widget.reseler!.buyer;
      _phnController.text = widget.reseler!.phone;
      _dateController.text = widget.reseler!.date;
      _statusController.text = widget.reseler!.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.reseler == null ? 'Tambah Reseler' : 'Edit Reseler',
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 41, 182, 146),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 138, 230, 207),
              Color.fromARGB(255, 0, 165, 129)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _buyerController,
                  decoration: const InputDecoration(labelText: 'Buyer'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan buyer';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phnController,
                  decoration: const InputDecoration(labelText: 'No HP'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Nomor HP';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(labelText: 'Tanggal'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan tanggal';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _statusController,
                  decoration: const InputDecoration(labelText: 'status'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan status buyer';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool response;
                      if (widget.reseler == null) {
                        // Tambah reseler baru
                        response = await reselerApi.createReseler(
                          _buyerController.text,
                          _phnController.text,
                          _dateController.text,
                          _statusController.text,
                        );
                      } else {
                        // Update reseler yang ada
                        response = await reselerApi.updateReseler(
                          Reseler(
                            id: widget.reseler!.id,
                            buyer: _buyerController.text,
                            phone: _phnController.text,
                            date: _dateController.text,
                            status: _statusController.text,
                          ),
                          widget.reseler!.id,
                        );
                      }

                      if (response == true) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 1),
                          content: Text(widget.reseler == null
                              ? "Buyer berhasil ditambahkan"
                              : "Buyer berhasil diperbarui"),
                        ));
                        Navigator.of(context).popAndPushNamed('/reseler');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 1),
                          content: Text(widget.reseler == null
                              ? "Buyer gagal ditambahkan"
                              : "Buyer gagal diperbarui"),
                        ));
                      }
                    }
                  },
                  child: Center(
                    child: Text(
                      widget.reseler == null ? 'Simpan' : 'Update',
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
