import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Menu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        scaffoldBackgroundColor: Colors.orange.shade50,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              fontFamily: 'Raleway', fontSize: 18, color: Colors.orange),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo : Food Order'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> _foodMenu = [
    {
      'name': 'Pizza',
      'icon': '🍕',
      'ingredients': ['Dough', 'Tomato Sauce', 'Cheese', 'Pepperoni'],
      'price': 8.99,
      'review': 4.5
    },
    {
      'name': 'Burger',
      'icon': '🍔',
      'ingredients': ['Bun', 'Beef Patty', 'Lettuce', 'Tomato', 'Cheese'],
      'price': 6.49,
      'review': 4.2
    },
    {
      'name': 'Sushi',
      'icon': '🍣',
      'ingredients': ['Rice', 'Nori', 'Fish', 'Wasabi'],
      'price': 12.99,
      'review': 4.8
    },
    {
      'name': 'Pasta',
      'icon': '🍝',
      'ingredients': ['Pasta', 'Tomato Sauce', 'Garlic', 'Parmesan'],
      'price': 7.99,
      'review': 4.3
    },
    {
      'name': 'Salad',
      'icon': '🥗',
      'ingredients': ['Lettuce', 'Tomato', 'Cucumber', 'Dressing'],
      'price': 5.49,
      'review': 4.0
    },
    {
      'name': 'Steak',
      'icon': '🥩',
      'ingredients': ['Beef', 'Salt', 'Pepper', 'Butter'],
      'price': 15.99,
      'review': 4.7
    },
    {
      'name': 'Ice Cream',
      'icon': '🍨',
      'ingredients': ['Milk', 'Sugar', 'Vanilla', 'Cream'],
      'price': 3.99,
      'review': 4.1
    },
    {
      'name': 'Taco',
      'icon': '🌮',
      'ingredients': ['Tortilla', 'Beef', 'Cheese', 'Lettuce', 'Salsa'],
      'price': 4.49,
      'review': 4.3
    },
    {
      'name': 'Donut',
      'icon': '🍩',
      'ingredients': ['Flour', 'Sugar', 'Milk', 'Eggs', 'Chocolate Glaze'],
      'price': 1.99,
      'review': 4.2
    },
    {
      'name': 'Fried Chicken',
      'icon': '🍗',
      'ingredients': ['Chicken', 'Flour', 'Eggs', 'Spices', 'Oil'],
      'price': 9.99,
      'review': 4.6
    },
  ];

  final Random _random = Random();
  final List<Map<String, dynamic>> _randomMenu = [];

  double get _totalPrice =>
      _randomMenu.fold(0, (sum, item) => sum + (item['price'] as double));

  void _addRandomFood() {
    setState(() {
      _randomMenu.add({
        ..._foodMenu[_random.nextInt(_foodMenu.length)],
        'orderNumber': _randomMenu.length + 1
      });
    });
  }

  void _removeFood(int index) {
    setState(() {
      _randomMenu.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            if (_randomMenu.isNotEmpty)
              Text(
                'Total: \$${_totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
          ],
        ),
        centerTitle: true,
        elevation: 8,
        shadowColor: Colors.orange.withOpacity(0.4),
      ),
      body: _randomMenu.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.restaurant_menu,
                    size: 100,
                    color: Colors.orangeAccent,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No food added yet!\nTap the button to start. 🍴',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _randomMenu.length,
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  shadowColor: Colors.orange.withOpacity(0.3),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Colors.orange.shade100,
                              Colors.orange.shade200
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _randomMenu[index]['icon']!,
                            style: const TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order #${_randomMenu[index]['orderNumber']}: ${_randomMenu[index]['name']!}',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Ingredients: ' +
                                    (_randomMenu[index]['ingredients']
                                            as List<String>)
                                        .join(', '),
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$' +
                                        _randomMenu[index]['price']
                                            .toStringAsFixed(2),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          size: 16, color: Colors.amber),
                                      const SizedBox(width: 4),
                                      Text(
                                        _randomMenu[index]['review'].toString(),
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.amber),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeFood(index),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRandomFood,
        tooltip: 'Add Food',
        backgroundColor: Colors.orangeAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
