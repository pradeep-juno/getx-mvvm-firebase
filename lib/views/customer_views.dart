import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/customer_controller.dart';
import '../models/customer_model.dart';

class CustomerView extends StatelessWidget {
  final CustomerController customerController = Get.put(CustomerController());
  final RxString filterAddress = ''.obs;
  final RxInt filterAge = 0.obs; // Initialize with 0
  final RxString filterGender = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mansion Hotel Customers'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _filterDialog(context),
          ),
        ],
      ),
      body: Obx(() {
        final filteredCustomers =
            customerController.customers.where((customer) {
          final addressMatch = filterAddress.value.isEmpty ||
              customer.address.contains(filterAddress.value);
          final ageMatch =
              filterAge.value == 0 || customer.age == filterAge.value;
          final genderMatch = filterGender.value.isEmpty ||
              customer.gender.contains(filterGender.value);

          return addressMatch && ageMatch && genderMatch;
        }).toList();

        if (filteredCustomers.isEmpty) {
          return Center(child: Text('No Data Found'));
        }

        return ListView.builder(
          itemCount: filteredCustomers.length,
          itemBuilder: (context, index) {
            final customer = filteredCustomers[index];
            return ListTile(
              title: Text(customer.name),
              subtitle: Text(
                  'Phone: ${customer.phone}\nAddress: ${customer.address}'),
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
    final phoneController = TextEditingController();
    final ageController = TextEditingController();
    final genderController = TextEditingController();
    final addressController = TextEditingController();
    final idProofController = TextEditingController();

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
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone')),
            TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number),
            TextField(
                controller: genderController,
                decoration: InputDecoration(labelText: 'Gender')),
            TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address')),
            TextField(
                controller: idProofController,
                decoration: InputDecoration(labelText: 'ID Proof')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final id = Random().nextInt(1000).toString();
              final customer = Customer(
                id: id,
                name: nameController.text,
                phone: phoneController.text,
                age: int.tryParse(ageController.text) ?? 0,
                gender: genderController.text,
                address: addressController.text,
                idProof: idProofController.text,
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
    final phoneController = TextEditingController(text: customer.phone);
    final ageController = TextEditingController(text: customer.age.toString());
    final genderController = TextEditingController(text: customer.gender);
    final addressController = TextEditingController(text: customer.address);
    final idProofController = TextEditingController(text: customer.idProof);

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
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone')),
            TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number),
            TextField(
                controller: genderController,
                decoration: InputDecoration(labelText: 'Gender')),
            TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address')),
            TextField(
                controller: idProofController,
                decoration: InputDecoration(labelText: 'ID Proof')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final updatedCustomer = Customer(
                id: customer.id,
                name: nameController.text,
                phone: phoneController.text,
                age: int.tryParse(ageController.text) ?? 0,
                gender: genderController.text,
                address: addressController.text,
                idProof: idProofController.text,
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

  void _filterDialog(BuildContext context) {
    final addressController = TextEditingController(text: filterAddress.value);
    final ageController =
        TextEditingController(text: filterAge.value.toString());
    final genderController = TextEditingController(text: filterGender.value);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Filter Customers'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address')),
            TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number),
            TextField(
                controller: genderController,
                decoration: InputDecoration(labelText: 'Gender')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              filterAddress.value = addressController.text;
              filterAge.value = int.tryParse(ageController.text) ?? 0;
              filterGender.value = genderController.text;
              Get.back();
            },
            child: Text('Apply'),
          ),
          TextButton(
            onPressed: () {
              filterAddress.value = '';
              filterAge.value = 0; // Reset to default
              filterGender.value = '';
              Get.back();
            },
            child: Text('Clear'),
          ),
        ],
      ),
    );
  }
}
