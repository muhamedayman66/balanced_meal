import 'package:balanced_meal/core/theme.dart';
import 'package:balanced_meal/screens/details_screen.dart';
import 'package:balanced_meal/screens/order_screen.dart';
import 'package:balanced_meal/screens/summary_screen.dart';
import 'package:balanced_meal/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/details': (context) => DetailsScreen(),
        '/order': (context) => OrderScreen(),
        '/summary': (context) => SummaryScreen(),
      },
    );
  }
}
 