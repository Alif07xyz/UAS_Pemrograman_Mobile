import 'package:flutter/material.dart';
import 'package:showda_apps/api/invoice.dart';
import 'package:showda_apps/model/invoice.dart';

class InvoiceForm extends StatefulWidget {
  final Invoice? invoice;

  const InvoiceForm({super.key, this.invoice});

  @override
  _InvoiceFormState createState() => _InvoiceFormState();
}

class _InvoiceFormState extends State<InvoiceForm> {
  final InvoiceApi invoiceApi = InvoiceApi();

  final _saleidController = TextEditingController();
  final _productidController = TextEditingController();
  final _qtyController = TextEditingController();
  final _issuerController = TextEditingController();
  final _createdAtController = TextEditingController();
  final _updatedAtController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.invoice != null) {
      _saleidController.text = widget.invoice!.saleid;
      _productidController.text = widget.invoice!.productid;
      _qtyController.text = widget.invoice!.qty.toString();
      _issuerController.text = widget.invoice!.issuer;
      _createdAtController.text = widget.invoice!.createdAt.toString();
      _updatedAtController.text = widget.invoice!.updatedAt.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.invoice == null ? 'Tambah invoice' : 'Edit invoice',
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
                  controller: _saleidController,
                  decoration: const InputDecoration(
                    labelText: 'Sale ID',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Sale ID';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _productidController,
                  decoration: const InputDecoration(
                    labelText: 'Produk ID',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Produk ID';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _qtyController,
                  decoration: const InputDecoration(
                    labelText: 'Kuantitas',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan kuantitas stock';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _issuerController,
                  decoration: const InputDecoration(
                    labelText: 'Reseler',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan nama Reseler';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool response;
                        if (widget.invoice == null) {
                          // Tambah produk baru
                          response = await invoiceApi.createInvoice(
                            _saleidController.text,
                            _productidController.text,
                            num.parse(_qtyController.text),
                            _issuerController.text,
                          );
                        } else {
                          // Update produk yang ada
                          response = await invoiceApi.updateInvoice(
                            Invoice(
                              id: widget.invoice!.id,
                              saleid: _saleidController.text,
                              productid: _productidController.text,
                              qty: num.parse(_qtyController.text),
                              issuer: _issuerController.text,
                              createdAt: num.parse(_createdAtController.text),
                              updatedAt: num.parse(_updatedAtController.text),
                            ),
                            widget.invoice!.id,
                          );
                        }

                        if (response == true) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 1),
                            content: Text(widget.invoice == null
                                ? "Invoice berhasil ditambahkan"
                                : "Invoice berhasil diperbarui"),
                          ));
                          Navigator.of(context).popAndPushNamed('/invoice');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 1),
                            content: Text(widget.invoice == null
                                ? "Invoice gagal ditambahkan"
                                : "Invoice gagal diperbarui"),
                          ));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      widget.invoice == null ? 'Simpan' : 'Update',
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
