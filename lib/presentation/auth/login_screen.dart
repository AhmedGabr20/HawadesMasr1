import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'auth_view_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider);

    ref.listen(authViewModelProvider, (_, next) {
      if (next.user != null) context.go('/home');
    });

    return Scaffold(
      appBar: AppBar(title: const Text('تسجيل الدخول')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _email, decoration: const InputDecoration(labelText: 'البريد الإلكتروني')),
            TextField(controller: _password, decoration: const InputDecoration(labelText: 'كلمة المرور'), obscureText: true),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: state.loading
                  ? null
                  : () => ref.read(authViewModelProvider.notifier).login(_email.text, _password.text),
              child: state.loading ? const CircularProgressIndicator() : const Text('دخول'),
            ),
            if (state.error != null) Text(state.error!, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
