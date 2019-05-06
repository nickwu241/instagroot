import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:instagroot/models.dart';
import 'package:instagroot/post_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagroot',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _tabSelectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() => _tabSelectedIndex = index);
  }

  Widget _buildBody() {
    switch (_tabSelectedIndex) {
      case 0:
        return HomeFeedPage();
      default:
        return Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.grey[100],
        title: Row(
          children: <Widget>[
            Icon(OMIcons.cameraAlt, color: Colors.black, size: 32.0),
            Container(width: 12.0),
            Text(
              'Instagroot',
              style: TextStyle(
                  fontFamily: 'Billabong', color: Colors.black, fontSize: 32.0),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            color: Colors.black,
            icon: Icon(OMIcons.liveTv),
            onPressed: () {},
          ),
          IconButton(
            color: Colors.black,
            icon: Icon(OMIcons.nearMe),
            onPressed: () {},
          )
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 32.0,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(OMIcons.home), title: Container()),
          BottomNavigationBarItem(icon: Icon(Icons.search), title: Container()),
          BottomNavigationBarItem(
              icon: Icon(OMIcons.addBox), title: Container()),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), title: Container()),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), title: Container()),
        ],
        currentIndex: _tabSelectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

class HomeFeedPage extends StatefulWidget {
  @override
  _HomeFeedPageState createState() => _HomeFeedPageState();
}

class _HomeFeedPageState extends State<HomeFeedPage> {
  final _posts = <Post>[
    Post(
      user: User(name: 'nickwu241', imageUrl: 'assets/images/nickwu241.jpg'),
      imageUrls: [
        'assets/images/groot1.jpg',
        'assets/images/groot4.jpg',
        'assets/images/groot5.jpg',
      ],
      location: 'Earth',
      postedAt: DateTime(2019, 5, 4, 12, 35, 0),
    ),
    Post(
      user: User(name: 'nickwu241', imageUrl: 'assets/images/nickwu241.jpg'),
      imageUrls: ['assets/images/groot2.jpg'],
      location: 'Knowhere',
      postedAt: DateTime(2019, 5, 3, 6, 0, 0),
    ),
    Post(
      user: User(name: 'nickwu241', imageUrl: 'assets/images/nickwu241.jpg'),
      imageUrls: ['assets/images/groot6.jpg'],
      location: 'Nine Realms',
      postedAt: DateTime(2019, 5, 2, 0, 0, 0),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, i) {
        return PostWidget(_posts[i]);
      },
      itemCount: _posts.length,
    );
  }
}
