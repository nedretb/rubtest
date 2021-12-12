import 'package:flutter/material.dart';
import 'package:rubicom_test/movies_page.dart';
import 'package:rubicom_test/tvshows_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  Color firstColor = Colors.blue;
  Color secondColor = Colors.white;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('An App');
  String searchValue = '';

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customIcon = const Icon(Icons.cancel);
                  customSearchBar = ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: TextField(
                     onChanged: (val){
                       setState(() {
                           searchValue = val;
                       });
                     },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                } else {
                  customIcon = const Icon(Icons.search);
                  customSearchBar = const Text('An App');
                }
              });
            },
            icon: customIcon,
          )
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TabBar(
              onTap: (index){
                print(index);
                setState(() {
                  if(index == 1){
                    firstColor = Colors.white;
                    secondColor = Colors.blue;
                  }
                  else{
                    firstColor = Colors.blue;
                    secondColor = Colors.white;
                  }
                });
              },
              unselectedLabelColor: Colors.blue,
              labelColor: Colors.white,
            tabs: [
            Container(
              decoration: BoxDecoration(

                  color: firstColor,
                  border: Border.all(color: Colors.blueAccent)
              ),
              child: Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Movies"),
                ),
              ),
            ),
              Tab(
                child: Container(
                  color: secondColor,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("TV Shows"),
                  ),
                ),

              ),
          ],
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        Expanded(
          child: TabBarView(
            children: [
              Container(
                  child: MoviesPage(searchValue)
              )
              ,
              Container(
                child: TVShowsPage(),
              )
            ],
            controller: _tabController,
          ),
        ),
        ],
      ),
    ),);
  }
}