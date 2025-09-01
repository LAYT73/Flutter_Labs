import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'repositories/book_repository.dart';
import 'services/book_service_impl.dart';
import 'screens/search_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => BookServiceImpl()),
        ProxyProvider<BookServiceImpl, BookRepository>(
          update: (_, service, __) => BookRepository(service),
        ),
      ],
      child: const BookSearchApp(),
    ),
  );
}

class BookSearchApp extends StatelessWidget {
  const BookSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лабораторная 6',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const SearchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}