import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/primary_button.dart';

class CreateIncidentScreen extends StatefulWidget {
  const CreateIncidentScreen({super.key});

  static const routeName = '/create-incident';

  @override
  State<CreateIncidentScreen> createState() => _CreateIncidentScreenState();
}

class _CreateIncidentScreenState extends State<CreateIncidentScreen> {
  String _selectedType = AppConstants.incidentTypes.first;
  String _selectedSeverity = AppConstants.severities.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إنشاء بلاغ جديد')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 170,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
            ),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add_a_photo_outlined, size: 38),
                  SizedBox(height: 8),
                  Text('Image Picker Placeholder'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const CustomTextField(label: 'عنوان البلاغ', hint: 'اكتب عنوانًا واضحًا'),
          const SizedBox(height: 12),
          const CustomTextField(
            label: 'وصف البلاغ',
            hint: 'اكتب تفاصيل البلاغ',
            maxLines: 4,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedType,
            decoration: const InputDecoration(labelText: 'النوع'),
            items: AppConstants.incidentTypes
                .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => _selectedType = value);
            },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedSeverity,
            decoration: const InputDecoration(labelText: 'الخطورة'),
            items: AppConstants.severities
                .map((severity) => DropdownMenuItem(value: severity, child: Text(severity)))
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => _selectedSeverity = value);
            },
          ),
          const SizedBox(height: 16),
          Container(
            height: 130,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on_outlined, size: 34),
                  SizedBox(height: 6),
                  Text('Location Placeholder'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            label: 'إرسال البلاغ',
            icon: Icons.send_outlined,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إرسال البلاغ (وهميًا).')),
              );
            },
          ),
        ],
      ),
    );
  }
}
