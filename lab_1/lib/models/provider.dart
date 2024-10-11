import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  var counter = 0;
  var actions = List.empty(growable: true);
  String message = 'Presiona los botones para jugar';
  String displayedIcon = 'assets/icons/o_icon.svg';

  String oIcon = 'assets/icons/o_icon.svg';
  String winIcon = 'assets/icons/victory_icon.svg';
  String gameOverIcon = 'assets/icons/game_over_icon.svg';

  void incrementCounter() {
    counter++;

    if (counter == 5) {
      showGameOverDisplay();
    }

    if (counter == 10) {
      showVictoryDisplay();
    }

    notifyListeners();
  }

  void decrementCounter() {
    if (counter == 0) return;
    counter--;

    if (counter == 5) {
      showGameOverDisplay();
    }

    if (counter == 10) {
      showVictoryDisplay();
    }

    notifyListeners();
  }

  void resetCounter() {
    counter = 0;

    showNormalDisplay();

    notifyListeners();
  }

  void showVictoryDisplay() {
    message = 'Felicidades, has Ganado!!!';
    displayedIcon = winIcon;
    notifyListeners();
  }

  void showGameOverDisplay() {
    message = 'Has Perdido\n(pista: sigue presionando el botón)';
    displayedIcon = gameOverIcon;
    notifyListeners();
  }

  void showNormalDisplay() {
    message = 'Presiona los botones para jugar';
    displayedIcon = oIcon;
    notifyListeners();
  }

  void addToAudits(String line) {
    actions.add(line);
  }

  List<Widget> showAudit() {
    var texts = <Widget>[];

    for (int i = 0; i < actions.length; i++) {
      texts.add(Text(actions[i]));
    }

    return texts;
  }
}
