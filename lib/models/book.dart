 import 'package:flutter/material.dart';

class Book {
  final String id;
  final String title;
  final String? coverUrl; 
  final String review;
  final int rating;
  final String? ownerName; 

  Book({
    required this.id,
    required this.title,
    this.coverUrl,
    required this.review,
    required this.rating,
    this.ownerName,
  });
}

List<Book> _myInitialBooks = [
  Book(id: '1', title: 'Título do Livro 1', review: 'Excelente leitura!', rating: 5),
  Book(id: '2', title: 'Título do Livro 2', review: 'Gostei bastante.', rating: 4),
  Book(id: '3', title: 'Título do Livro 3', review: 'Mediano.', rating: 3),
  Book(id: '4', title: 'Título do Livro 1', review: 'Excelente leitura!', rating: 5),
  Book(id: '5', title: 'Título do Livro 2', review: 'Gostei bastante.', rating: 4),
  Book(id: '6', title: 'Título do Livro 3', review: 'Mediano.', rating: 3),
  Book(id: '7', title: 'Título do Livro 1', review: 'Excelente leitura!', rating: 5),
  Book(id: '8', title: 'Título do Livro 2', review: 'Gostei bastante.', rating: 4),
  Book(id: '9', title: 'Título do Livro 3', review: 'Mediano.', rating: 3),
];

List<Book> _friendsInitialBooks = [
  Book(id: '14', title: 'Livro do Amigo A', review: 'Muito bom!', rating: 4, ownerName: 'Amigo A'),
  Book(id: '15', title: 'Livro do Amigo B', review: 'Incrível.', rating: 5, ownerName: 'Amigo B'),
  Book(id: '16', title: 'Livro do Amigo A', review: 'Muito bom!', rating: 4, ownerName: 'Amigo A'),
  Book(id: '17', title: 'Livro do Amigo B', review: 'Incrível.', rating: 5, ownerName: 'Amigo B'),
  Book(id: '18', title: 'Livro do Amigo A', review: 'Muito bom!', rating: 4, ownerName: 'Amigo A'),
  Book(id: '19', title: 'Livro do Amigo B', review: 'Incrível.', rating: 5, ownerName: 'Amigo B'),
];

final ValueNotifier<List<Book>> myBooksNotifier = ValueNotifier(_myInitialBooks);
final ValueNotifier<List<Book>> friendsBooksNotifier = ValueNotifier(_friendsInitialBooks);