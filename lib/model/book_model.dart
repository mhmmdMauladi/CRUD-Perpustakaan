class Book {
  final String image;
  final String name;
  final String author;
  final double rate;
  final int review;

  Book(
      {required this.image,
      required this.name,
      required this.author,
      required this.rate,
      required this.review});
}

List<Book> books = [
  Book(
    image: 'assets/Terang.png',
    name: 'Habis Gelap Terbitlah Terang',
    author: 'Raden Adjeng Kartini',
    rate: 4.8,
    review: 120,
  ),
  Book(
    image: 'assets/habit.png',
    name: 'The Power of Habit',
    author: 'Charles Duhigg',
    rate: 4.5,
    review: 80,
  ),
];
