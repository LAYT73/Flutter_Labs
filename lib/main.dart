import 'package:flutter/material.dart';

void main() {
  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лабораторная 3',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Place {
  final String title;
  final String location;
  final String imageUrl;

  Place({required this.title, required this.location, required this.imageUrl});
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Список мест
    final List<Place> places = [
      Place(
        title: 'Париж',
        location: 'Франция',
        imageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=500',
      ),
      Place(
        title: 'Токио',
        location: 'Япония',
        imageUrl: 'https://images.unsplash.com/photo-1545251142-f32339076e6d?w=500',
      ),
      Place(
        title: 'Сидней',
        location: 'Австралия',
        imageUrl: 'https://images.unsplash.com/photo-1506973035872-a4ec16b8e8d9?w=500',
      ),
      Place(
        title: 'Рим',
        location: 'Италия',
        imageUrl: 'https://images.unsplash.com/photo-1552832230-c0197dd311b5?w=500',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Шипилов Никита Сергеевич ПИбд-31'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network(
                    place.imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Text('Ошибка загрузки'));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        place.location,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}