import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const _key = '4cb43616f0d02a7feb600c5ab9098e8d';

class MoviesGet {

  late final result;

  MoviesGet({required this.result});

  Future getData() async {
    http.Response response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/top_rated?api_key=$_key&language=en-US&page=1'));
    print('---------------------------------');
    print('test');
    print(jsonDecode(response.body)['results'][0]);
    print('---------------------------------');
    // return jsonDecode(response.body);
  }

  factory MoviesGet.fromJson(Map<String, dynamic> json) {
    // print(json);
    // print(json['results'][0]['title']);
    return MoviesGet(
      result: json['results']
    );
  }
}