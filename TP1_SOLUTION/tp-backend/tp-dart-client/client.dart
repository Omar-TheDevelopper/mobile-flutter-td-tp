import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> getProducts(String baseUrl) async {
  final response = await http.get(Uri.parse('$baseUrl/products'));

  if (response.statusCode == 200) {
    List<dynamic> products = jsonDecode(response.body);
    print('Available Products:');
    for (var product in products) {
      print('Name: ${product['name']}, Price: ${product['price']}');
    }
  } else {
    print('Failed to fetch products');
  }
}

Future<void> addProduct(String baseUrl, Map<String, dynamic> product) async {
  final response = await http.post(
    Uri.parse('$baseUrl/products'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(product),
  );

  if (response.statusCode == 201) {
    print('Product added successfully');
  } else {
    print('Failed to add product');
  }
}

Future<void> getOrders(String baseUrl) async {
  final response = await http.get(Uri.parse('$baseUrl/orders'));

  if (response.statusCode == 200) {
    List<dynamic> orders = jsonDecode(response.body);
    print('Available Orders:');
    for (var order in orders) {
      print('Product: ${order['product']}, Quantity: ${order['quantity']}');
    }
  } else {
    print('Failed to fetch orders');
  }
}

Future<void> addOrder(String baseUrl, Map<String, dynamic> order) async {
  final response = await http.post(
    Uri.parse('$baseUrl/orders'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(order),
  );

  if (response.statusCode == 201) {
    print('Order created successfully');
  } else {
    print('Failed to create order');
  }
}

void main() async {
  final String baseUrl = 'http://localhost:3000';

  // Fetch all products
  await getProducts(baseUrl);

  // Add a new product
  final newProduct = {'name': 'Product 1', 'price': 100};
  await addProduct(baseUrl, newProduct);

  // Fetch all orders
  await getOrders(baseUrl);

  // Add a new order
  final newOrder = {'product': 'Product 1', 'quantity': 2};
  await addOrder(baseUrl, newOrder);
}
