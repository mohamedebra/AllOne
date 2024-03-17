class LocaleModelProduct{
  int? id;
  String? title;
  String? image;
  int? quantity;


  LocaleModelProduct(
      {this.id,
        this.image,
        this.quantity,
        this.title,
      });

  factory LocaleModelProduct.fromJson(Map<String, dynamic> json) => LocaleModelProduct(
    id: json['id'],
    title: json['title'],
    image: json['image'],
    quantity: json['quantity'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['quantity'] = this.quantity;

    return data;
  }

}

