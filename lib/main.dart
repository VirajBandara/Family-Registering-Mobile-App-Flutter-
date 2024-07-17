import 'package:flutter/material.dart';
import 'package:family_reg/family_registering.dart';
import 'package:family_reg/family_data_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Family Aid',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const FamilyRegistering(),
      routes: {
        '/family-registering': (context) => const FamilyRegistering(),
        '/family-data': (context) => const FamilyDataScreen(),
      },
    );
  }
}
