import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/saved-model.dart';
import 'package:startup_namer/saved.dart';

void main() =>
    runApp(ChangeNotifierProvider(create: (_) => SavedModel(), child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(primaryColor: Colors.teal),
      home: RandomWords(),
      routes: <String, WidgetBuilder>{
        '/saved': (BuildContext context) => SavedPage(),
      },
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18);

  Widget _buildRow(WordPair pair) {
    return Consumer<SavedModel>(builder: (context, saved, child) {
      final alreadySaved = saved.contains(pair);
      return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              saved.remove(pair);
            } else {
              saved.add(pair);
            }
          });
        },
      );
    });
  }

  Widget _buildSuggestions() {
    return RefreshIndicator(
      child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemBuilder: (BuildContext _context, int i) {
            if (i.isOdd) {
              return Divider();
            }
            final int index = i ~/ 2;
            if (index >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10));
            }
            return _buildRow(_suggestions[index]);
          }),
      onRefresh: () async {
        return await Future.delayed(Duration(seconds: 3), () {
          // Clears the suggestions actually uses the list logic to regenerate
          // new names.
          setState(() {
            _suggestions.clear();
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.pushNamed(context, '/saved');
            },
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}
