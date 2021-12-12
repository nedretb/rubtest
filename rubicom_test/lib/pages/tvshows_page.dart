import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rubicom_test/services/parse_data.dart';
import 'package:rubicom_test/pages/view_data.dart';
import 'package:http/http.dart' as http;

class TVShowsPage extends StatefulWidget {
  final searchValue;
  const TVShowsPage(this.searchValue);

  @override
  _TVShowsPageState createState() => _TVShowsPageState();
}

class _TVShowsPageState extends State<TVShowsPage> {
  late Future<ParseData> tvShowsData;

  @override
  void initState() {
    super.initState();
    tvShowsData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FutureBuilder<ParseData>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final children = <Widget>[];
              for (var i = 0; i < 10; i++) {
                int rang = i+1;
                if(widget.searchValue.length >=3){
                  if(snapshot.data!.result[i]['name'].toLowerCase().contains(widget.searchValue.toLowerCase())){
                    children.add(ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewData(
                                snapshot.data!.result[i]['name'],
                                snapshot.data!.result[i]['overview'],
                                snapshot.data!.result[i]['backdrop_path'])));
                      },
                      title: Text('$rang ' + snapshot.data!.result[i]['name'],
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
                              snapshot.data!.result[i]['name'],
                              snapshot.data!.result[i]['overview'],
                              snapshot.data!.result[i]['backdrop_path'])));
                    },
                    title: Text('$rang ' + snapshot.data!.result[i]['name'],
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

Future<ParseData> fetchData() async {
  const _key = '4cb43616f0d02a7feb600c5ab9098e8d';
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/tv/top_rated?api_key=$_key&language=en-US&page=1'));
  return ParseData.fromJson(jsonDecode(response.body));
}