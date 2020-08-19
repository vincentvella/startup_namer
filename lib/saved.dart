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
          body: Center(child: Builder(builder: (context) {
            if (saved.value.length > 0)
              return ListView(
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
                      })).toList());
            else
              return Center(
                child: Text("No Saved Startup Names", style: _biggerFont),
              );
          })));
    });
  }
}
