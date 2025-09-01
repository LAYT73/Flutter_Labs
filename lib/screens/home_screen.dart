import 'package:flutter/material.dart';
import '../models/place.dart';
import '../widgets/place_card.dart';
import 'detail_screen.dart';

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
          return PlaceCard(
            place: places[index],
            index: index,
            isLiked: _isLiked[index] ?? false,
            onLikeToggle: (liked) {
              setState(() {
                _isLiked[index] = liked;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(liked ? 'Добавлено в избранное' : 'Убрано из избранного'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(place: places[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}