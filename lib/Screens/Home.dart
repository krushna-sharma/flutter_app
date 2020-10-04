import 'package:flutter/material.dart';

class PostList {
  final String name;
  final Color color;

  PostList({this.name, this.color});

  factory PostList.fromJson(Map<String, dynamic> parsedJson) {
    return PostList(name: parsedJson['name'], color: parsedJson['color']);
  }
}

class ScratchHome extends StatelessWidget {
  final List<PostList> _postsList = [
    new PostList(name: 'Nihal', color: Colors.red),
    new PostList(name: 'Krushna', color: Colors.green),
    new PostList(name: 'Pratik', color: Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation Menu',
          onPressed: null,
        ),
        title: Text('Dashboard'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search), tooltip: 'Search', onPressed: null),
          IconButton(icon: Icon(Icons.favorite_outline), onPressed: null)
        ],
      ),
      body: Material(
          child: ListView.builder(
              itemCount: _postsList.length,
              itemBuilder: (context, i) {
                return SavedCards(
                  color: _postsList[i].color,
                  text: _postsList[i].name,
                );
              })),
//      floatingActionButton: FloatingActionButton(
//        tooltip: 'Add',
//        child: Icon(Icons.add),
//        onPressed: null,
//      ),
    );
  }
}

class SavedCards extends StatefulWidget {
  const SavedCards({
    Key key,
    this.color = const Color(0xFFFFFFFF),
    this.text,
  }) : super(key: key);

  final Color color;
  final String text;

  @override
  _SavedCardsState createState() => _SavedCardsState();
}

class _SavedCardsState extends State<SavedCards> {
  var _saved = [];

  Widget _buildCard(PostList postData) {
    final _alreadySaved = _saved.contains(postData.name);
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.white,
//        shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        height: 200.0,
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              Center(
                child: Text(
                  postData.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
              ),
              IconButton(
                  icon: Icon(
                    _alreadySaved ? Icons.favorite : Icons.favorite_outline,
                    color: _alreadySaved ? Colors.red : null,
                  ),
                  onPressed: null)
            ],
          ),
        ),
      ),
      onDoubleTap: () {
        setState(() {
          if (_alreadySaved) {
            _saved.remove(postData.name);
          } else {
            _saved.add(postData.name);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildCard(new PostList(name: widget.text, color: widget.color));
  }
}
