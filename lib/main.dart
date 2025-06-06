import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterMart',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

/// =============================
/// 1. FIRST SCREEN (From updated_fluttermart_main.dart, made more responsive)
/// =============================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use LayoutBuilder + MediaQuery for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final paddingHorizontal = screenWidth * 0.05;
    final headingFontSize = (screenWidth * 0.08).clamp(24.0, 32.0);
    final subheadingFontSize = (screenWidth * 0.05).clamp(16.0, 20.0);
    final buttonFontSize = (screenWidth * 0.045).clamp(14.0, 16.0);
    final cardWidth = (screenWidth - (paddingHorizontal * 2) - 24) / 2;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal,
            vertical: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to FlutterMart',
                style: TextStyle(
                  fontSize: headingFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Browse through curated categories\nand find the best products.',
                style: TextStyle(
                  fontSize: subheadingFontSize,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Responsive grid of category cards
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = (constraints.maxWidth > 600) ? 3 : 2;
                  final spacing = 12.0;
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      childAspectRatio: (cardWidth / (cardWidth * 1.1)),
                    ),
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      return CategoryCard(
                        title: cat['name'] as String,
                        icon: cat['icon'] as IconData,
                        color: cat['color'] as Color,
                        onPressed: () {
                          // Navigate to ProductsScreen from main (1).dart
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductsScreen(
                                category: cat['name'] as String,
                                products: cat['products'] as List<dynamic>,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// =============================
/// CategoryCard (from updated_fluttermart_main.dart)
/// =============================
class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: onPressed,
            child: const Text(
              'Explore',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// =============================
/// 2. DATA MODELS & DUMMY DATA (from main (1).dart, extended with icon & color)
/// =============================
final List<Map<String, dynamic>> categories = [
  {
    'name': 'Electronics',
    'icon': Icons.electrical_services,
    'color': Colors.deepOrange,
    'image': 'assets/electronics.png',
    'products': [
      {
        'name': 'Headphones',
        'price': 5999,
        'image': 'assets/headphones.jpeg',
        'description': 'High-quality wireless headphones with noise cancellation.',
      },
      {
        'name': 'Iphone 14 pro max',
        'price': 169999,
        'image': 'assets/phone.jpg',
        'description': 'Latest-gen smartphone with cutting-edge features.',
      },
    ],
  },
  {
    'name': 'Books',
    'icon': Icons.book,
    'color': Colors.blue,
    
    'products': [
      {
        'name': 'Flutter for Beginners',
        'price': 2999,
        'image': 'assets/flutter_book.jpg',
        'description': 'A comprehensive guide to learning Flutter from scratch.',
      },
      {
        'name': 'Advanced Dart',
        'price': 3499,
        'image': 'assets/dart_book.jpg',
        'description': 'Deep dive into Dart language features and best practices.',
      },
    ],
  },
  {
    'name': 'Fashion',
    'icon': Icons.watch,
    'color': Colors.purple,
    'products': [
      {
        'name': 'Jeans',
        'price': 8999,
        'image': 'assets/jeans.jpg',
        'description': 'Comfortable and stylish sneakers for everyday wear.',
      },
      {
        'name': 'Tshirt',
        'price': 11999,
        'image': 'assets/tshirt.jpg',
        'description': 'Warm jacket made with premium materials.',
      },
    ],
  },
];

/// =============================
/// 3. PRODUCTS LIST SCREEN (from main (1).dart, unchanged)
/// =============================
class ProductsScreen extends StatelessWidget {
  final String category;
  final List<dynamic> products;

  const ProductsScreen({
    super.key,
    required this.category,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.7,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final item = products[index] as Map<String, dynamic>;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(
                      product: item,
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          item['image'],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(
                      item['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '\₹${item['price'].toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// =============================
/// 4. PRODUCT DETAIL SCREEN (from main (1).dart, unchanged)
/// =============================
class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                product['image'],
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              product['name'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product['description'],
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              '\₹${product['price'].toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 22,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CartScreen(
                      product: product,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Add to Cart',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =============================
/// 5. CART SCREEN (from main (1).dart, unchanged)
/// =============================
class CartScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const CartScreen({super.key, required this.product});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final price = product['price'] as double;
    final subtotal = price * quantity;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Image.asset(
                product['image'],
                fit: BoxFit.contain,
                width: 60,
                height: 60,
              ),
              title: Text(product['name']),
              subtitle: Text('\$${price.toStringAsFixed(2)}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text(
                    '$quantity',
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
            ),
            const Divider(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Subtotal: \$${subtotal.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderSummaryScreen(
                        product: product,
                        quantity: quantity,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Proceed to Checkout',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

/// =============================
/// 6. ORDER SUMMARY SCREEN (from main (1).dart, unchanged)
/// =============================
class OrderSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  final int quantity;

  const OrderSummaryScreen({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final price = product['price'] as double;
    final subtotal = price * quantity;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListTile(
              leading: Image.asset(
                product['image'],
                fit: BoxFit.contain,
                width: 60,
                height: 60,
              ),
              title: Text(product['name']),
              subtitle: Text('Quantity: $quantity'),
              trailing: Text('\₹${subtotal.toStringAsFixed(2)}'),
            ),
            const Divider(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  SummaryRow(label: 'Item Total', value: subtotal),
                  SummaryRow(label: 'Tax (5%)', value: subtotal * 0.05),
                  SummaryRow(label: 'Shipping', value: 5.00),
                  const Divider(),
                  SummaryRow(
                    label: 'Grand Total',
                    value: subtotal * 1.05 + 5.00,
                    isBold: true,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Order Confirmed'),
                      content: const Text(
                          'Thank you for your purchase! Your order has been placed.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.popUntil(
                              context,
                              (route) => route.isFirst,
                            );
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 174, 137, 237),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Confirm Order',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

/// =============================
/// 7. SUMMARY ROW WIDGET (from main (1).dart)
/// =============================
class SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isBold;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyle),
          Text(
            '\₹${value.toStringAsFixed(2)}',
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
