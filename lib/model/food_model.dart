class Food {
  String name;
  int price;
  String image;

  Food({
    this.name,
    this.price,
    this.image,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        name: json['name'],
        price: json['price'],
        image: json['image']);
  }
}

// List<String> foodTypes = [
//   'Salad',
//   'All',
//   'Pizza',
//   'Asian',
//   'Burger',
//   'Dessert',
// ];
