class Stock {
  String id;
  String name;
  num qty;
  String attr;
  num weight;
  String issuer;

  Stock({
    required this.id,
    required this.name,
    required this.qty,
    required this.attr,
    required this.weight,
    required this.issuer,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['id'],
      name: json['name'],
      qty: json['qty'],
      attr: json['attr'],
      weight: json['weight'],
      issuer: json['issuer']
    );
  }
}
