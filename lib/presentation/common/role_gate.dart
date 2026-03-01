import 'package:flutter/widgets.dart';

import '../../core/constants/app_constants.dart';

class RoleGate extends StatelessWidget {
  const RoleGate({super.key, required this.role, required this.allowed, required this.child, required this.fallback});

  final UserRole role;
  final Set<UserRole> allowed;
  final Widget child;
  final Widget fallback;

  @override
  Widget build(BuildContext context) => allowed.contains(role) ? child : fallback;
}
