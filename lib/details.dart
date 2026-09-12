import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:drink_ordering_app/components/toggle_widget.dart';
import 'package:drink_ordering_app/model.dart';

class DrinkDetails extends StatefulWidget {
  const DrinkDetails({super.key});

  @override
  State<DrinkDetails> createState() => _DrinkDetailsState();
}

class _DrinkDetailsState extends State<DrinkDetails> {
  final PageController _controller = PageController(viewportFraction: 0.50);
  double _currentPage = 0;
  int selectedIndex = 0;
  int? selectedSize;
  bool isSelectedSize = false;
  double drinkSize = 1.1;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page ?? 1;
      });
    });
  }
  final drinks = DrinkModel.drinks;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // En-tête avec nom et prix
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      drinks[_currentPage.round()].name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      drinks[_currentPage.round()].title,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Text(
                  "£${drinks[_currentPage.round()].price}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),

          // Carrousel des images
          Positioned(
            top: screenHeight * 0.15,
            left: 0,
            right: 0,
            height: screenHeight * 0.45,
            child: PageView.builder(
              controller: _controller,
              itemCount: drinks.length,
              itemBuilder: (context, index) {
                final scale = drinkSize - (_currentPage - index).abs() * 0.3;
                return Transform.scale(
                  scale: scale.clamp(0.7, 1.0),
                  child: Hero(
                    tag: 'drink-${drinks[index].name.toLowerCase()}',
                    child: Image.asset(
                      drinks[index].image,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
          ),

          // Contrôles en bas
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Column(
              children: [
                // Sélecteur de taille
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return GestureDetector(
                        onTap: () => setState(() => selectedSize = index),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectedSize == index
                                ? Colors.orange
                                : Colors.white,
                            border: Border.all(
                              color: selectedSize == index
                                  ? Colors.orange
                                  : Colors.grey[300]!,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.local_drink,
                            color: selectedSize == index
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 20),

                // Contrôles de température et quantité
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: DrinkToggle(),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: QuantitySelector(),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Bouton d'ajout au panier
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}