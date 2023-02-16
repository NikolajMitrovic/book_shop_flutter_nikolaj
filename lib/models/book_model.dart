import 'package:flutter/cupertino.dart';

class BooksModel {
  final String? title;
  final String? author;
  final String? description;
  final int? number;
  final String? genre;
  final String? publisher;
  final DateTime? datePublished;
  final Image? photo;

  BooksModel({
    this.title,
    this.author,
    this.description,
    this.number,
    this.genre,
    this.publisher,
    this.datePublished,
    this.photo,
  });

  factory BooksModel.fromJson(Map<String, dynamic> json) {
    return BooksModel(
      title: json['title'],
      author: json['author'],
      description: json['description'],
      number: json['number'],
      genre: json['genre'],
      publisher: json['publisher'],
      datePublished: json['datePublished'],
      photo: json['photo'],
    );
  }
}
