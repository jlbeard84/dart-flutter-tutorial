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
      home: RandomWords()
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final _suggestions = <WordPair>[];
    final _biggerFont = const TextStyle(fontSize: 18.0);

    Widget _buildRow(WordPair pair) {
      return ListTile(
        title: Text(
          "${capitalize(pair.first)} ${capitalize(pair.second)}",
          style: _biggerFont
        )
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Random Name Generator"),
      ),
      body: _buildSuggestions()
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
