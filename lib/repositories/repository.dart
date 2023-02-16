import 'dart:convert';

import 'package:book_shop_flutter/models/book_model.dart';
import 'package:http/http.dart';

class BooksRepository {
  String baseApiUrl = 'fakerapi.it';
  String endpoint = '/api/v1/books';
  Future<List<BooksModel>>? getBooks({int? quantity = 10}) async {
    Response response = await get(
      Uri.http(baseApiUrl, endpoint, {'_quantity': '$quantity'}),
    );

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result
          .map(
            (e) => BooksModel.fromJson(e),
          )
          .toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
