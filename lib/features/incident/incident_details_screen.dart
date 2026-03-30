import 'package:flutter/material.dart';

import '../../core/widgets/status_badge.dart';

class IncidentDetailsScreen extends StatelessWidget {
  const IncidentDetailsScreen({super.key, this.incident});

  static const routeName = '/incident-details';
  final Map<String, dynamic>? incident;

  @override
  Widget build(BuildContext context) {
    final data = incident ??
        {
          'title': 'حادث افتراضي',
          'status': 'جديد',
          'description': 'تفاصيل الحادث غير متاحة.',
          'date': '30 مارس 2026',
          'image': 'https://images.unsplash.com/photo-1449824913935-59a10b8d2000',
        };

    return Scaffold(
      appBar: AppBar(title: const Text('تفاصيل الحادث')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 18),
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(22)),
            child: Image.network(
              data['image'] as String,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 220,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.image_not_supported_outlined, size: 44),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        data['title'] as String,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    StatusBadge(status: data['status'] as String),
                  ],
                ),
                const SizedBox(height: 8),
                Text(data['date'] as String),
                const SizedBox(height: 16),
                Text(data['description'] as String, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 24),
                Text('تسلسل الحالة', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                ...const [
                  _TimelineItem(title: 'تم استقبال البلاغ', time: '09:12 ص'),
                  _TimelineItem(title: 'تم توجيه أقرب دورية', time: '09:20 ص'),
                  _TimelineItem(title: 'جاري المعالجة الميدانية', time: '09:45 ص'),
                ],
                const SizedBox(height: 24),
                Text('تعليقات', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                const Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Icon(Icons.person)),
                    title: Text('أحمد سامي'),
                    subtitle: Text('تم تحويل الحركة المرورية للطريق البديل.'),
                  ),
                ),
                const Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Icon(Icons.person)),
                    title: Text('غرفة العمليات'),
                    subtitle: Text('المتابعة مستمرة حتى انتهاء الإصلاحات.'),
                  ),
                ),
                const SizedBox(height: 24),
                Text('الموقع', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.map_outlined, size: 40),
                        SizedBox(height: 8),
                        Text('Map Placeholder'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({required this.title, required this.time});

  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(title)),
          Text(time, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
