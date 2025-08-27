import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// CartItem class
class CartItem {
  final String name;
  final double price;

  CartItem({required this.name, required this.price});
}

// CartModel with API integration
class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];
  String? _error;

  List<CartItem> get items => _items;
  String? get error => _error;
  double get totalPrice => _items.fold(0, (sum, item) => sum + item.price);

  Future<void> fetchCart() async {
    try {
      // Simulate API call (replace with real API endpoint)
      await Future.delayed(const Duration(seconds: 2));
      _items.addAll([
        CartItem(name: 'Shirt', price: 15.00),
        CartItem(name: 'Shoes', price: 30.00),
      ]);
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  void addItem(String name, double price) {
    _items.add(CartItem(name: name, price: price));
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ShoppingCartPage(),
    );
  }
}

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart with API'),
      ),
      body: FutureBuilder(
        future: Provider.of<CartModel>(context, listen: false).fetchCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Consumer<CartModel>(
            builder: (context, cart, child) {
              if (cart.error != null) {
                return Center(child: Text('Error: ${cart.error}'));
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Total Price: \$${cart.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final item = cart.items[index];
                          return ListTile(
                            title: Text(item.name),
                            subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                Provider.of<CartModel>(context, listen: false)
                                    .removeItem(index);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}