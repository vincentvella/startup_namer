import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/saved-model.dart';

class SavedPage extends StatelessWidget {
  final _biggerFont = TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Consumer<SavedModel>(builder: (_, saved, __) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Saved Suggestions'),
        ),
        body: ListView(
            children: ListTile.divideTiles(
                context: context,
                tiles: saved.value.map((WordPair pair) {
                  return ListTile(
                    title: Text(
                      pair.asPascalCase,
                      style: _biggerFont,
                    ),
                    trailing: Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      saved.remove(pair);
                    },
                  );
                })).toList()),
      );
    });
  }
}
