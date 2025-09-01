import 'package:flutter/material.dart';

void main() {
  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лабораторная 4',
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
  final String description;
  final String bestTime;
  final int rating;

  Place({
    required this.title,
    required this.location,
    required this.imageUrl,
    this.description = 'Описание отсутствует.',
    this.bestTime = 'Любое время года',
    this.rating = 5,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<int, bool> _isLiked = {};

  @override
  Widget build(BuildContext context) {
    final List<Place> places = [
      Place(
        title: 'Париж',
        location: 'Франция',
        imageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=500',
        description: 'Столица Франции, город любви и моды. Здесь находятся Эйфелева башня, Лувр и собор Парижской Богоматери.',
        bestTime: 'Весна и осень',
        rating: 5,
      ),
      Place(
        title: 'Токио',
        location: 'Япония',
        imageUrl: 'https://images.unsplash.com/photo-1545251142-f32339076e6d?w=500',
        description: 'Мегаполис, сочетающий традиции и ультрасовременные технологии. Здесь можно увидеть как древние храмы, так и неоновые улицы.',
        bestTime: 'Весна (цветение сакуры)',
        rating: 5,
      ),
      Place(
        title: 'Сидней',
        location: 'Австралия',
        imageUrl: 'https://images.unsplash.com/photo-1506973035872-a4ec16b8e8d9?w=500',
        description: 'Известен своим оперным театром и великолепными пляжами. Отличное место для любителей природы и активного отдыха.',
        bestTime: 'Лето (декабрь-февраль)',
        rating: 4,
      ),
      Place(
        title: 'Рим',
        location: 'Италия',
        imageUrl: 'https://images.unsplash.com/photo-1552832230-c0197dd311b5?w=500',
        description: 'Город с богатой историей: Колизей, Ватикан, Фонтан Треви. Каждый камень здесь дышит древностью.',
        bestTime: 'Весна и осень',
        rating: 5,
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
          final isLiked = _isLiked[index] ?? false;

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Изображение
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(place: place),
                            ),
                          );
                        },
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
                    ),
                    // Кнопка лайка в углу
                    Positioned(
                      top: 12,
                      right: 12,
                      child: IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          bool newValue = !(isLiked ?? false);
                          setState(() {
                            _isLiked[index] = newValue;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(newValue ? 'Добавлено в избранное' : 'Убрано из избранного'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                // Текст
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

// Экран детальной информации
class DetailScreen extends StatelessWidget {
  final Place place;

  const DetailScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                place.imageUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              place.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              place.location,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Описание:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              place.description,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Лучшее время для посещения: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  place.bestTime,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  'Рейтинг: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...List.generate(5, (i) {
                  return Icon(
                    i < place.rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}