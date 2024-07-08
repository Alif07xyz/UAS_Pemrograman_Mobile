class Invoice {
  String id;
  String saleid;
  String productid;
  num qty;
  num createdAt;
  num updatedAt;
  String issuer;

  Invoice({
    required this.id,
    required this.saleid,
    required this.productid,
    required this.qty,
    required this.createdAt,
    required this.updatedAt,
    required this.issuer,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
        id: json['id'],
        saleid: json['sale_id'],
        productid: json['product_id'],
        qty: json['qty'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        issuer: json['issuer']);
  }
}
