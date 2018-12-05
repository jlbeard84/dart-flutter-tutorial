import "package:flutter/material.dart";
import "package:english_words/english_words.dart";

String capitalize(String s) {
  if (s == null || s.length == 0) {
    return "";
  }

  if (s.length == 1) {
    return s.toUpperCase();
  }

  return "${s[0].toUpperCase()}${s.substring(1)}";
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Random Word Generator",
      theme: new ThemeData(
        primaryColor: Colors.blueGrey
      ),
      home: RandomWords()
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Random Name Generator"),
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved
          )
        ],
      ),
      body: _buildSuggestions()
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return new ListTile(
                title: Text(
                  "${capitalize(pair.first)} ${capitalize(pair.second)}",
                  style: _biggerFont
                ),
              );
            }
          );
          final List<Widget> divided = ListTile
            .divideTiles(
              context: context,
              tiles: tiles
            ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: const Text("Saved Suggestions")
            ),
            body: new ListView(children: divided)
          );
        }
      )
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        "${capitalize(pair.first)} ${capitalize(pair.second)}",
        style: _biggerFont
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;

        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggestions[index]);
      },
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
