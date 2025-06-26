class FoodItem {
  final String foodName;
  final int calories;
  final String imageUrl;
  final int price;

  FoodItem({
    required this.foodName,
    required this.calories,
    required this.imageUrl,
    required this.price,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      foodName: json['food_name'] ?? '',
      calories: json['calories'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      price: 12,
    );
  } 

  Map<String, dynamic> toJson() {
    return {
      'food_name': foodName,
      'calories': calories,
      'image_url': imageUrl,
      'price': price,
    };
  }
}
