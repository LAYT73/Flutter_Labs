enum BookStatus { available, borrowed, reserved }

class Book {
  final String title;
  final String author;
  BookStatus status;

  Book({required this.title, required this.author, this.status = BookStatus.available});

  void borrow() {
    if (status == BookStatus.available) {
      status = BookStatus.borrowed;
      print("Книга '${title}' взята читателем.");
    } else {
      print("Книга '${title}' недоступна для выдачи (статус: $status).");
    }
  }

  void returnBook() {
    if (status == BookStatus.borrowed) {
      status = BookStatus.available;
      print("Книга '${title}' возвращена.");
    }
  }

  @override
  String toString() => "'$title' от $author ($status)";
}

class Library<T extends Book> {
  List<T> books = [];

  void addBook(T book) {
    books.add(book);
    print("Книга добавлена: $book");
  }

  void showAvailableBooks() {
    print("\nДоступные книги:");
    books.where((book) => book.status == BookStatus.available).forEach((book) {
      print(" - $book");
    });
  }

  Future<T?> findBookByTitle(String title) async {
    await Future.delayed(Duration(seconds: 2));

    try {
      return books.firstWhere((book) => book.title == title);
    } on StateError {
      return null;
    }
  }
}

extension FormatStatus on BookStatus {
  String get label {
    switch (this) {
      case BookStatus.available:
        return "Доступна";
      case BookStatus.borrowed:
        return "Взята";
      case BookStatus.reserved:
        return "Зарезервирована";
    }
  }
}

void main() async {
  var library = Library<Book>();

  var book1 = Book(title: "Война и мир", author: "Лев Толстой");
  var book2 = Book(title: "Преступление и наказание", author: "Фёдор Достоевский");
  var book3 = Book(title: "Мастер и Маргарита", author: "Михаил Булгаков");

  library.addBook(book1);
  library.addBook(book2);
  library.addBook(book3);

  var booksToBorrow = [book1, book2];
  booksToBorrow.forEach((book) => book.borrow());

  library.showAvailableBooks();

  print("\nСтатус книги '${book1.title}': ${book1.status.label}");

  var found = await library.findBookByTitle("Мастер и Маргарита");
  if (found != null) {
    print("Найдена: $found");
    found.borrow();
  } else {
    print("Книга не найдена.");
  }

  book1.returnBook();

  library.showAvailableBooks();
}