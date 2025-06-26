import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SummaryScreen extends StatefulWidget {
  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  List<Map<String, dynamic>> order = [];
  double? caloriesNeeded;
  bool isInitialized = false;
  bool isLoading = false;

  void getArguments() {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && !isInitialized) {
      order = List<Map<String, dynamic>>.from(args['order']);
      caloriesNeeded = args['caloriesNeeded'];
      isInitialized = true; 
    }
  }

  Future<void> placeOrder() async {
    setState(() {
      isLoading = true;
    });

    try {
      final url = Uri.parse('https://uz8if7.buildship.run/placeOrder');

      List<Map<String, dynamic>> items = [];
      for (var item in order) {
        items.add({
          'name': item['name'],
          'total_price': (item['price'] ?? 10) * (item['quantity'] ?? 1),
          'quantity': item['quantity'] ?? 1,
        });
      }

      final body = jsonEncode({
        'items': items,
      });

      print('Sending request to: $url');
      print('Request body: $body');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['result'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Order placed successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushNamedAndRemoveUntil(
              context, '/welcome', (route) => false);
        } else {
          throw Exception('API returned false');
        }
      } else {
        throw Exception('Failed to place order: ${response.statusCode}');
      }
    } catch (e) {
      print('Error placing order: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to place order. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateQuantity(int index, int delta) {
    setState(() {
      int currentQuantity = order[index]['quantity'] ?? 0;
      int newQuantity = currentQuantity + delta;

      if (newQuantity <= 0) {
        order.removeAt(index);
      } else {
        order[index]['quantity'] = newQuantity;
      }
    });
  }

  String getImageUrl(String foodName) {
    Map<String, String> foodImages = {
      'Bell Pepper':
          "https://i5.walmartimages.com/asr/5d3ca3f5-69fa-436a-8a73-ac05713d3c2c.7b334b05a184b1eafbda57c08c6b8ccf.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF",
      'Carrot':
          "https://cdn11.bigcommerce.com/s-kc25pb94dz/images/stencil/1280x1280/products/271/762/Carrot__40927.1634584458.jpg?c=2",
      'Broccoli':
          "https://cdn.britannica.com/25/78225-050-1781F6B7/broccoli-florets.jpg",
      'Spinach':
          "https://www.daysoftheyear.com/cdn-cgi/image/dpr=1%2Cf=auto%2Cfit=cover%2Cheight=650%2Cq=40%2Csharpen=1%2Cwidth=956/wp-content/uploads/fresh-spinach-day.jpg",
      'Lean Beef':
          "https://www.mashed.com/img/gallery/the-truth-about-lean-beef/l-intro-1621886574.jpg",
      'Salmon':
          "https://cdn.apartmenttherapy.info/image/upload/f_jpg,q_auto:eco,c_fill,g_auto,w_1500,ar_1:1/k%2F2023-04-baked-salmon-how-to%2Fbaked-salmon-step6-4792",
      'Chicken Breast':
          "https://www.savorynothings.com/wp-content/uploads/2021/02/airy-fryer-chicken-breast-image-8.jpg",
      'Turkey':
          "https://fox59.com/wp-content/uploads/sites/21/2022/11/white-meat.jpg?w=2560&h=1440&crop=1",
      'Sweet Corn':
          "https://m.media-amazon.com/images/I/41F62-VbHSL._AC_UF1000,1000_QL80_.jpg",
      'Brown Rice':
          "https://assets-jpcust.jwpsrv.com/thumbnails/k98gi2ri-720.jpg",
      'Oats':
          "https://media.post.rvohealth.io/wp-content/uploads/2020/03/oats-oatmeal-732x549-thumbnail.jpg",
      'Black Beans':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwxSM9Ib-aDXTUIATZlRPQ6qABkkJ0sJwDmA&usqp=CAU",
    };
    return foodImages[foodName] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    getArguments();

    double totalCalories = 0;
    double totalPrice = 0;

    for (var item in order) {
      int quantity = item['quantity'] ?? 1;
      double calories = (item['calories'] ?? 0).toDouble();
      double price = (item['price'] ?? 10).toDouble();

      totalCalories += calories * quantity;
      totalPrice += price * quantity;
    }

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
          'Order summary',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: order.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_basket_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your order is empty',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: Text(
                      'Go Back to Order',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      itemCount: order.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: Colors.grey[200],
                      ),
                      itemBuilder: (context, index) {
                        final item = order[index];
                        int quantity = item['quantity'] ?? 1;
                        double itemPrice = (item['price'] ?? 10).toDouble();

                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    getImageUrl(item['name']),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[200],
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey[400],
                                          size: 30,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '${item['calories']} Cal',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '\$${itemPrice.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(width: 16),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => updateQuantity(index, -1),
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 40,
                                    height: 30,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$quantity',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => updateQuantity(index, 1),
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
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
                              'Cals',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${totalCalories.toInt()} Cal out of ${(caloriesNeeded ?? 0).toInt()} Cal',
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
                              '\$ ${totalPrice.toStringAsFixed(0)}',
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
                            onPressed: isLoading ? null : placeOrder,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: isLoading
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    'Confirm',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
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
