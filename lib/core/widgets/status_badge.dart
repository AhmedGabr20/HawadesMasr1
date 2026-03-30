import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({required this.status, super.key});

  final String status;

  Color _statusColor(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    switch (status) {
      case 'جديد':
        return cs.primary;
      case 'قيد المتابعة':
        return cs.tertiary;
      case 'مغلق':
        return cs.secondary;
      default:
        return cs.outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        status,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
