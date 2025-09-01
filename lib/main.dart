// lib/main.dart
import 'package:flutter/material.dart';
import 'package:lab_flutter/repositories/book_repository.dart';
import 'package:lab_flutter/services/book_service_impl.dart';
import 'package:provider/provider.dart';
import 'data/database/app_database.dart';
import 'screens/search_screen.dart';
import 'localization/app_localizations_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const BookSearchApp());
}

class BookSearchApp extends StatefulWidget {
  const BookSearchApp({super.key});

  @override
  State<BookSearchApp> createState() => _BookSearchAppState();
}

class _BookSearchAppState extends State<BookSearchApp> {
  Locale _locale = const Locale('ru'); // текущий язык

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => BookServiceImpl()),
        ProxyProvider<BookServiceImpl, BookRepository>(
          update: (_, service, __) => BookRepository(service),
        ),
        FutureProvider<AppDatabase?>(
          create: (_) async => AppDatabase(),
          initialData: null,
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Book Search',
        theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
        home: SearchScreen(setLocale: setLocale), // передаём в SearchScreen
        debugShowCheckedModeBanner: false,
        locale: _locale,
        supportedLocales: const [Locale('en'), Locale('ru')],
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales!) {
            if (supportedLocale.languageCode == locale?.languageCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
      ),
    );
  }
}