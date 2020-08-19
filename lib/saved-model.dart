import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class SavedModel extends ChangeNotifier {
  final value = Set<WordPair>();

  void add(WordPair pair) {
    value.add(pair);
    notifyListeners();
  }

  void remove(WordPair pair) {
    value.remove(pair);
    notifyListeners();
  }

  void clear() {
    value.clear();
    notifyListeners();
  }

  bool contains(WordPair pair) {
    return value.contains(pair);
  }

  returnSaved() {
    return value;
  }
}
