import 'package:flutter/material.dart';
import 'package:simple_song_quiz/pages/landing_page.dart';

class ScorePage extends StatelessWidget {
  final int score;
  final int totalQuestion;

  const ScorePage(this.score, this.totalQuestion);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Skor: ",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 50)),
          Text(score.toString() + "/" + totalQuestion.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 50)),
          Text(getFinalMessage(score / totalQuestion * 100),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30)),
          IconButton(
            icon: Icon(Icons.arrow_right),
            color: Colors.white,
            iconSize: 120,
            onPressed: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => LandingPage()))
                },
          )
        ],
      ),
    );
  }
}

String getFinalMessage(double percentage) {
  if (percentage > 99)
    return "Olağanüstü!";
  else if (percentage > 80)
    return "Çok iyi";
  else if (percentage > 60)
    return "İyi";
  else if (percentage > 40)
    return "İdare eder";
  else if (percentage > 20)
    return "Kötü";
  else
    return "Çok Kötü";
}
