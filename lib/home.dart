import 'package:flutter/material.dart';
import 'package:drink_ordering_app/components/drink.dart';
import 'package:drink_ordering_app/details.dart';
import 'package:drink_ordering_app/model.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Menu",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: DrinkModel.drinks.length,
        itemBuilder: (context, index) {
          final drink = DrinkModel.drinks[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => DrinkDetails(),
                ),
              ),
              child: Drink(
                name: drink.name,
                title: drink.title,
                image: drink.image,
              ),
            ),
          );
        },
      ),
    );
  }
}