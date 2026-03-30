import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/widgets/incident_card.dart';
import '../incident/create_incident_screen.dart';
import '../incident/incident_details_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _selectedFilter = 0;

  final List<Map<String, dynamic>> _incidents = const [
    {
      'title': 'تصادم سيارتين على الطريق الدائري',
      'status': 'جديد',
      'severity': 'عالي',
      'date': '30 مارس 2026',
      'description': 'حادث مروري تسبب في تباطؤ حركة المرور بالاتجاه الشرقي.',
      'image': 'https://images.unsplash.com/photo-1532634896-26909d0d4b6d',
    },
    {
      'title': 'حريق محدود داخل مخزن تجاري',
      'status': 'قيد المتابعة',
      'severity': 'متوسط',
      'date': '29 مارس 2026',
      'description': 'تمت السيطرة المبدئية على الحريق وتواجد فرق الحماية المدنية.',
      'image': 'https://images.unsplash.com/photo-1541976590-713941681591',
    },
    {
      'title': 'هبوط أرضي أمام أحد الأنفاق',
      'status': 'مغلق',
      'severity': 'حرج',
      'date': '27 مارس 2026',
      'description': 'تم تحويل المسار وإغلاق المنطقة لحين انتهاء أعمال الإصلاح.',
      'image': 'https://images.unsplash.com/photo-1489515217757-5fd1be406fef',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildIncidentList(context),
      const ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'لوحة الحوادث' : 'الملف الشخصي'),
      ),
      body: pages[_selectedIndex],
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () => Navigator.pushNamed(context, CreateIncidentScreen.routeName),
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('بلاغ جديد'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          setState(() => _selectedIndex = value);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.list_alt), label: 'الحوادث'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'حسابي'),
        ],
      ),
    );
  }

  Widget _buildIncidentList(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
      children: [
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ChoiceChip(
                label: Text(AppConstants.incidentFilters[index]),
                selected: _selectedFilter == index,
                onSelected: (_) => setState(() => _selectedFilter = index),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemCount: AppConstants.incidentFilters.length,
          ),
        ),
        const SizedBox(height: 14),
        ..._incidents.map(
          (incident) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: IncidentCard(
              incident: incident,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  IncidentDetailsScreen.routeName,
                  arguments: incident,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
