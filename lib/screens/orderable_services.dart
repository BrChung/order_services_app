import 'package:flutter/material.dart';
import '../shared/shared.dart';

class OrderableServicesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Orderable Services'), backgroundColor: Colors.purple),

      bottomNavigationBar: AppBottomNav(),
    );
  }
}