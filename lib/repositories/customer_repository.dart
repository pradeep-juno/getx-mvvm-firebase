import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/customer_model.dart';

class CustomerRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = "customers";

  // Fetch customers from Firestore
  Future<List<Customer>> getCustomers() async {
    final querySnapshot = await _firestore.collection(collectionPath).get();
    return querySnapshot.docs
        .map((doc) => Customer.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Add a customer to Firestore
  Future<void> addCustomer(Customer customer) async {
    await _firestore
        .collection(collectionPath)
        .doc(customer.id)
        .set(customer.toJson());
  }

  // Update a customer in Firestore
  Future<void> updateCustomer(String id, Customer newCustomer) async {
    await _firestore
        .collection(collectionPath)
        .doc(id)
        .update(newCustomer.toJson());
  }

  // Delete a customer from Firestore
  Future<void> deleteCustomer(String id) async {
    await _firestore.collection(collectionPath).doc(id).delete();
  }
}
