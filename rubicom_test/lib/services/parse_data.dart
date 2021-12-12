import 'package:flutter/material.dart';

class ParseData {
  late final result;

  ParseData({required this.result});

  factory ParseData.fromJson(Map<String, dynamic> json) {
    return ParseData(
      result: json['results']
    );
  }
}