import 'package:get/get.dart';

import '../models/customer_model.dart';
import '../repositories/customer_repository.dart';

class CustomerController extends GetxController {
  final CustomerRepository _customerRepository = CustomerRepository();

  var customers = <Customer>[].obs;

  @override
  void onInit() {
    fetchCustomers();
    super.onInit();
  }

  Future<void> fetchCustomers() async {
    customers.value = await _customerRepository.getCustomers();
  }

  Future<void> addCustomer(Customer customer) async {
    await _customerRepository.addCustomer(customer);
    fetchCustomers();
  }

  Future<void> updateCustomer(String id, Customer customer) async {
    await _customerRepository.updateCustomer(id, customer);
    fetchCustomers();
  }

  Future<void> deleteCustomer(String id) async {
    await _customerRepository.deleteCustomer(id);
    fetchCustomers();
  }
}
