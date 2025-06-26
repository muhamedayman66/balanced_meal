import 'package:flutter/material.dart';
import '../core/food_item.dart';
import '../core/food_data.dart';
import 'summary_screen.dart';

class OrderScreen extends StatefulWidget {
  final double? caloriesNeeded;

  OrderScreen({this.caloriesNeeded});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Map<String, dynamic>> order = [];
  List<FoodItem> vegetables = FoodDataService.getVegetables();
  List<FoodItem> meats = FoodDataService.getMeats();
  List<FoodItem> carbs = FoodDataService.getCarbs();

  void addItem(String category, FoodItem item) { 
    setState(() {
      final existingIndex = order.indexWhere((o) => o['name'] == item.foodName);

      if (existingIndex != -1) {
        order[existingIndex]['quantity'] =
            (order[existingIndex]['quantity'] ?? 0) + 1;
      } else {
        order.add({
          'name': item.foodName,
          'calories': item.calories,
          'price': item.price,
          'quantity': 1,
          'category': category,
        });
      }
    });
  }

  void removeItem(String name) {
    setState(() {
      order.removeWhere((item) => item['name'] == name);
    });
  }

  void updateQuantity(String name, int delta) {
    setState(() {
      var item = order.firstWhere((o) => o['name'] == name);
      item['quantity'] = (item['quantity'] ?? 0) + delta;
      if ((item['quantity'] ?? 0) <= 0) removeItem(name);
    });
  }

  double getTotalCalories() {
    return order.fold(
        0,
        (sum, item) =>
            sum + ((item['calories'] ?? 0) * (item['quantity'] ?? 0)));
  }

  double getTotalPrice() {
    return order.fold(0,
        (sum, item) => sum + ((item['price'] ?? 0) * (item['quantity'] ?? 0)));
  }

  bool isOrderValid() {
    double totalCalories = getTotalCalories();
    double target = widget.caloriesNeeded ?? 0;
    return target > 0 &&
        (totalCalories >= target * 0.9 && totalCalories <= target * 1.1);
  }

  double getCaloriePercentage() {
    double totalCalories = getTotalCalories();
    double target = widget.caloriesNeeded ?? 1;
    return (totalCalories / target) * 100;
  }

  Color getPercentageColor() {
    double percentage = getCaloriePercentage();
    if (percentage >= 90 && percentage <= 110) {
      return Colors.green;
    } else if (percentage < 90) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Create your order',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Daily Calories Needed: ${(widget.caloriesNeeded ?? 0).toInt()} Cal',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Current: ${getTotalCalories().toInt()} Cal',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      '(${getCaloriePercentage().toStringAsFixed(1)}%)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: getPercentageColor(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                LinearProgressIndicator(
                  value: (getCaloriePercentage() / 100).clamp(0.0, 1.0),
                  backgroundColor: Colors.grey[300],
                  valueColor:
                      AlwaysStoppedAnimation<Color>(getPercentageColor()),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Vegetables',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: vegetables.length,
                    itemBuilder: (context, index) {
                      return FoodCard(
                        item: vegetables[index],
                        onAdd: () => addItem('vegetables', vegetables[index]),
                      );
                    },
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Meats',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: meats.length,
                    itemBuilder: (context, index) {
                      return FoodCard(
                        item: meats[index],
                        onAdd: () => addItem('meats', meats[index]),
                      );
                    },
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Carbs',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: carbs.length,
                    itemBuilder: (context, index) {
                      return FoodCard(
                        item: carbs[index],
                        onAdd: () => addItem('carbs', carbs[index]),
                      );
                    },
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cal',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${getTotalCalories().toInt()} Cal out of ${(widget.caloriesNeeded ?? 0).toInt()} Cal',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '\$ ${getTotalPrice().toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.orange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isOrderValid() && order.isNotEmpty
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SummaryScreen(),
                                  settings: RouteSettings(
                                    arguments: {
                                      'order': order,
                                      'caloriesNeeded': widget.caloriesNeeded,
                                    },
                                  ),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isOrderValid() && order.isNotEmpty
                            ? Colors.orange
                            : Colors.grey[300],
                        disabledBackgroundColor: Colors.grey[300],
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Place order',
                        style: TextStyle(
                          color: isOrderValid() && order.isNotEmpty
                              ? Colors.white
                              : Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  if (!isOrderValid() && order.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        'Order must be within 10% of your calorie needs',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final FoodItem item;
  final VoidCallback onAdd;

  FoodCard({required this.item, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey[400],
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.foodName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2),
                      Text(
                        '${item.calories} Cal',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${item.price}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      GestureDetector(
                        onTap: onAdd,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
