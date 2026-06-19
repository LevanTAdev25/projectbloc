class Product {
  final String id;
  final String name;
  final double price;
  final String category;
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
  });

  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Product{ id: $id, name: $name, price: $price, category: $category }";
  }
}
