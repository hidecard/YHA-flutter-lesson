import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// CartItem class to represent an item in the cart
class CartItem {
  final String name;
  final double price;

  CartItem({required this.name, required this.price});
}

// CartModel class to manage the cart state
class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items; // Getter for the cart items
  double get totalPrice => _items.fold(0, (sum, item) => sum + item.price); // Getter for total price

  void addItem(String name, double price) {
    _items.add(CartItem(name: name, price: price));
    notifyListeners(); // Notify listeners to update the UI
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners(); // Notify listeners to update the UI
  }
}

void main() {
  runApp(
    // Provide the CartModel to the widget tree
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
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input fields for item name and price
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Item Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Button to add item to cart
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    priceController.text.isNotEmpty) {
                  double? price = double.tryParse(priceController.text);
                  if (price != null) {
                    Provider.of<CartModel>(context, listen: false)
                        .addItem(nameController.text, price);
                    nameController.clear();
                    priceController.clear();
                  }
                }
              },
              child: const Text('Add to Cart'),
            ),
            const SizedBox(height: 20),
            // Display total price
            Consumer<CartModel>(
              builder: (context, cart, child) {
                return Text(
                  'Total Price: \$${cart.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                );
              },
            ),
            const SizedBox(height: 20),
            // Display cart items
            Expanded(
              child: Consumer<CartModel>(
                builder: (context, cart, child) {
                  return ListView.builder(
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}