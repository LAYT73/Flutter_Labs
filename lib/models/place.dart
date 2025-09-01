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