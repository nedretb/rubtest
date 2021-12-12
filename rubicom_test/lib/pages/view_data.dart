import 'package:flutter/material.dart';

class ViewData extends StatelessWidget {
  const ViewData(this.title, this.description, this.image);

  final image;
  final title;
  final description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        // leading: Icon(Icons.arrow_back_ios),
      ),
      body: Column(
        children: [
          Image.network('https://image.tmdb.org/t/p/w500'+image, width: double.infinity,height: 200),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description),
          )
        ],
      ),
    );
  }
}
