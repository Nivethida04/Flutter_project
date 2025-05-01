import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final String baseUrl = 'http://localhost:3000/';
  List<Product> _items = [];

  List<Product> get items => _items;

  Future<void> fetchFoodItems() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/foods'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        _items = data.map((e) => Product.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (e) {
      print("Fetch error: $e");
    }
  }

  Future<void> addOrUpdateProduct(Product product, {String? id}) async {
    final url = id == null ? '$baseUrl/add' : '$baseUrl/update/$id';
    final method = id == null ? http.post : http.put;

    try {
      final response = await method(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchFoodItems();
      }
    } catch (e) {
      print("Add/Update error: $e");
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));
      if (response.statusCode == 200) {
        await fetchFoodItems();
      }
    } catch (e) {
      print("Delete error: $e");
    }
  }
}
