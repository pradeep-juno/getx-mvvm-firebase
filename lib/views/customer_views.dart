import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/customer_controller.dart';
import '../models/customer_model.dart';

class CustomerView extends StatelessWidget {
  final CustomerController customerController = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mansion Hotel Customers'),
      ),
      body: Obx(() {
        if (customerController.customers.isEmpty) {
          return Center(child: Text('No Customers Found'));
        }
        return ListView.builder(
          itemCount: customerController.customers.length,
          itemBuilder: (context, index) {
            final customer = customerController.customers[index];
            return ListTile(
              title: Text(customer.name),
              subtitle: Text(customer.email),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  customerController.deleteCustomer(customer.id);
                },
              ),
              onTap: () => _editCustomerDialog(context, customer),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addCustomerDialog(context),
      ),
    );
  }

  void _addCustomerDialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Add Customer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name')),
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email')),
            TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final id = Random().nextInt(1000).toString();
              final customer = Customer(
                id: id,
                name: nameController.text,
                email: emailController.text,
                phone: phoneController.text,
              );
              customerController.addCustomer(customer);
              Get.back();
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editCustomerDialog(BuildContext context, Customer customer) {
    final nameController = TextEditingController(text: customer.name);
    final emailController = TextEditingController(text: customer.email);
    final phoneController = TextEditingController(text: customer.phone);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit Customer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name')),
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email')),
            TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final updatedCustomer = Customer(
                id: customer.id,
                name: nameController.text,
                email: emailController.text,
                phone: phoneController.text,
              );
              customerController.updateCustomer(customer.id, updatedCustomer);
              Get.back();
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
}
