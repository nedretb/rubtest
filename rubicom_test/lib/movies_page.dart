import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rubicom_test/movies_get10.dart';
import 'package:rubicom_test/view_data.dart';
import 'movies_get10.dart';
import 'package:http/http.dart' as http;


class MoviesPage extends StatefulWidget {
  final searchValue;
  const MoviesPage(this.searchValue);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {


  late Future<MoviesGet> moviesData;

  @override
  void initState() {
    super.initState();
    moviesData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FutureBuilder<MoviesGet>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if(widget.searchValue.length >= 3){
                print(snapshot.data!.result[0]['title']);
                print(snapshot.data!.result[0]['title'].toLowerCase().contains(widget.searchValue.toLowerCase()));
              }
              final children = <Widget>[];
              for (var i = 0; i < 10; i++) {
                int rang = i+1;

                if(widget.searchValue.length >=3){
                  if(snapshot.data!.result[i]['title'].toLowerCase().contains(widget.searchValue.toLowerCase())){
                    children.add(ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewData(
                                snapshot.data!.result[i]['title'],
                                snapshot.data!.result[i]['overview'],
                                snapshot.data!.result[i]['backdrop_path'])));
                      },
                      title: Text('$rang ' + snapshot.data!.result[i]['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          )),
                      subtitle: Text('Description'),
                      leading: Image.network('https://image.tmdb.org/t/p/w500' +
                          snapshot.data!.result[i]['poster_path']),
                      trailing: Icon(Icons.arrow_forward_ios_sharp),
                    ));
                    const Divider();
                  }
                }
                else{
                  children.add(ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewData(
                              snapshot.data!.result[i]['title'],
                              snapshot.data!.result[i]['overview'],
                              snapshot.data!.result[i]['backdrop_path'])));
                    },
                    title: Text('$rang ' + snapshot.data!.result[i]['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        )),
                    subtitle: Text('Description'),
                    leading: Image.network('https://image.tmdb.org/t/p/w500' +
                        snapshot.data!.result[i]['poster_path']),
                    trailing: Icon(Icons.arrow_forward_ios_sharp),
                  ));
                  const Divider();
                }

              }
              return ListView(
                children: children,
              );
            } else if (snapshot.hasError) {
              return Text('$snapshot.erros');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Future<MoviesGet> fetchData() async {
  const _key = '4cb43616f0d02a7feb600c5ab9098e8d';
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/movie/top_rated?api_key=$_key&language=en-US&page=1'));
  return MoviesGet.fromJson(jsonDecode(response.body));
}

// ListTile _tile(String title, String subtitle, String icon, int count) {
//   return ListTile(
//     title: Text('$count ' + title,
//         style: const TextStyle(
//           fontWeight: FontWeight.w500,
//           fontSize: 20,
//         )),
//     subtitle: Text(subtitle),
//     leading: Image.network('https://image.tmdb.org/t/p/w500' + icon),
//     trailing: Icon(Icons.arrow_forward_ios_sharp),
//   );
// }
