class Produk {
  String id;
  String name;
  num price;
  num qty;
  String attr;
  num weight;
  num createdAt;
  num updatedAt;

  Produk({
    required this.id,
    required this.name,
    required this.price,
    required this.qty,
    required this.attr,
    required this.weight,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      qty: json['qty'],
      attr: json['attr'],
      weight: json['weight'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
