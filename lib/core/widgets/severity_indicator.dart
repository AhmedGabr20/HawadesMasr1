import 'package:flutter/material.dart';

class SeverityIndicator extends StatelessWidget {
  const SeverityIndicator({required this.severity, super.key});

  final String severity;

  Color _color(BuildContext context) {
    switch (severity) {
      case 'منخفض':
        return Colors.green;
      case 'متوسط':
        return Colors.orange;
      case 'عالي':
        return Colors.deepOrange;
      case 'حرج':
        return Colors.red;
      default:
        return Theme.of(context).colorScheme.outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _color(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          severity,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
