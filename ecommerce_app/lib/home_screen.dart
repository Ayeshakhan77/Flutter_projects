import 'package:flutter/material.dart';
import 'product_model.dart';
import 'product_detail.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  List<Product> products = [
    Product(name: "Wireless Headphones", description: "Premium sound quality", price: 89.99),
    Product(name: "Smart Watch", description: "Track fitness & calls", price: 120.00),
    Product(name: "Gaming Mouse", description: "RGB ergonomic design", price: 45.50),
    Product(name: "Laptop Stand", description: "Adjustable aluminum stand", price: 35.00),
    Product(name: "Bluetooth Speaker", description: "Deep bass portable", price: 60.00),
    Product(name: "Backpack", description: "Waterproof stylish bag", price: 55.99),
    Product(name: "Power Bank", description: "10000mAh fast charging", price: 25.00),
    Product(name: "LED Desk Lamp", description: "Touch control brightness", price: 40.00),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1f1c2c),
        title: Text("Welcome, ${widget.username}"),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xffFF6B6B),
          tabs: [
            const Tab(text: "Products"),
            Tab(
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text("Cart"),
                  ),
                  if (cart.isNotEmpty)
                    Positioned(
                      right: 0,
                      top: 2,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          cart.length.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [

          // PRODUCTS TAB
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xfffceabb), Color(0xfff8b500)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text("\$${product.price}"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductDetail(product: product),
                        ),
                      );
                      setState(() {});
                    },
                  ),
                );
              },
            ),
          ),

          // CART TAB
          const CartScreen(),
        ],
      ),
    );
  }
}
