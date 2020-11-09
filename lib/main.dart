import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter in MaterialApp',
      home: new RandomWords(),
      theme: new ThemeData(
        primaryColor: Colors.white,

      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: new ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, i) {
            if (i.isOdd) return new Divider();
            final index = i ~/ 2;
            if (index >= _suggestions.length - 10) {
              _suggestions.addAll(generateWordPairs().take(10));
            }
            return new ListTile(
              title: new Text(
                i.toString()+":"+_suggestions[index].asPascalCase,
                style: _biggerFont,
              ),
              trailing: new Icon(
                alreadySaved(_suggestions[index])?Icons.favorite: Icons.favorite_border,
                color: alreadySaved(_suggestions[index])?Colors.red:null,
              ),
              onTap: (){setState((){saveOrUnsave(index);});},
            );
          }
      ),
    );
  }
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  void saveOrUnsave(int index) {
    if(alreadySaved(_suggestions[index])) {
      _saved.remove(_suggestions[index]);
    } else{
      _saved.add(_suggestions[index]);
    }
  }

  bool alreadySaved(WordPair wordPair) {
    return _saved.contains(wordPair);
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map((pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}