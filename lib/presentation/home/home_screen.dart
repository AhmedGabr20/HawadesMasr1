import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حوادث مصر')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () => context.go('/home/incidents'),
            child: const Text('قائمة الحوادث'),
          ),
          ElevatedButton(
            onPressed: () => context.go('/home/incidents/new'),
            child: const Text('إضافة حادث جديد'),
          ),
        ],
      ),
    );
  }
}
