import 'package:flutter/material.dart';
import 'package:simple_song_quiz/pages/score_page.dart';
import 'package:simple_song_quiz/utils/circle_clipper.dart';
import 'package:simple_song_quiz/utils/question.dart';
import 'package:simple_song_quiz/utils/quiz.dart';
import 'package:simple_song_quiz/ui/correct_wrong_overlay.dart';
import 'package:audioplayer/audioplayer.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question(
        "ŞIMARIK",
        "https://p.scdn.co/mp3-preview/0a99127093fa2b1b2bb9724576f27729f15b5411?cid=774b29d4f13844c495f206cafdad9c86",
        "https://i.scdn.co/image/df136a90338003c21b1554be87841ca249b0ff5c"),
    new Question(
        "KEDİ GİBİ",
        "https://p.scdn.co/mp3-preview/5fc39338772800eb8f4112a9f7eef98e585842bb?cid=774b29d4f13844c495f206cafdad9c86",
        "https://i.scdn.co/image/05e5bfa44803e95d387c5a419604e09066c82eba"),
    new Question(
        "AY",
        "https://p.scdn.co/mp3-preview/29ca668b13720eb7ab37acb92959b1a1c13d9b12?cid=774b29d4f13844c495f206cafdad9c86",
        "https://i.scdn.co/image/a13f0e8cb580743999942da889958ac9d54e643e"),
    new Question(
        "KIŞ GÜNEŞİ",
        "https://p.scdn.co/mp3-preview/db0e700c303a19a8f2f02b2965e7f99a92ba82f0?cid=774b29d4f13844c495f206cafdad9c86",
        "https://i.scdn.co/image/a8b10344c874089eb73ff0e91b5e4bdd0c4191b9"),
    new Question(
        "KUZU KUZU",
        "https://p.scdn.co/mp3-preview/278966ba033f489c92ae09898b7bac830e0036e7?cid=774b29d4f13844c495f206cafdad9c86",
        "https://i.scdn.co/image/a13f0e8cb580743999942da889958ac9d54e643e"),
    new Question(
        "ÖLÜRÜM SANA",
        "https://p.scdn.co/mp3-preview/d0bcab99493845f34b306c11a367ed7a88a25fef?cid=774b29d4f13844c495f206cafdad9c86",
        "https://i.scdn.co/image/df136a90338003c21b1554be87841ca249b0ff5c"),
    new Question(
        "SEN BAŞKASIN",
        "https://p.scdn.co/mp3-preview/d34206a9d528b59871d745752170b301be01911f?cid=774b29d4f13844c495f206cafdad9c86",
        "https://i.scdn.co/image/a13f0e8cb580743999942da889958ac9d54e643e"),
  ]);
  String songTitle;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;
  final TextEditingController _textEditingController =
      new TextEditingController();
  AudioPlayer audioPlayer = new AudioPlayer();
  FocusNode focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    songTitle = currentQuestion.songTitle;
    questionNumber = quiz.questionNumber;
    play(currentQuestion.songUrl);
  }

  void _submission(String value) {
    audioPlayer.stop();
    var userAnswer = _textEditingController.text.trim().toUpperCase();
    var actual = currentQuestion.songTitle.toUpperCase();
    print("Cevap: " + userAnswer);
    print("Doğru Cevap: " + actual);
    isCorrect = (userAnswer == actual);
    print(isCorrect);
    quiz.answer(isCorrect);
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueAccent,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 90,
                          spreadRadius: 0,
                          offset: Offset(10, 10))
                          
                    ],
                    shape: BoxShape.circle
                    ),
                    child: ClipOval(
                      clipper: new CircleClipper(),
                      child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.network(currentQuestion.coverUrl)),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        focusNode: focusNode,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
                        enableInteractiveSelection: false,
                        autocorrect: false,
                        autofocus: true,
                        cursorWidth: 3,
                        cursorColor: Colors.red[300],
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.red[300],
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            helperStyle: TextStyle(fontSize: 20),
                            hintStyle:
                                TextStyle(fontSize: 30, color: Colors.white),
                            hintText: "Şarkının adını girin..."),
                        enabled: true,
                        maxLength: currentQuestion.songTitle.length,
                        maxLengthEnforced: true,
                        controller: _textEditingController,
                        onSubmitted: _submission,
                      )),
                ],
              ),
              Column()
            ],
          ),
          overlayShouldBeVisible
              ? CorrectWrongOverlay(isCorrect, () {
                  print("BASTIN");
                  currentQuestion = quiz.nextQuestion;
                  if (currentQuestion == null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ScorePage(quiz.score, quiz.questions.length)));
                  }
                  if (!mounted) return;
                  this.setState(() {
                    _textEditingController.clear();
                    overlayShouldBeVisible = false;
                    songTitle = currentQuestion.songTitle;
                    questionNumber = quiz.questionNumber;
                    play(currentQuestion.songUrl);
                    print(questionNumber);
                    FocusScope.of(context).requestFocus(focusNode);
                  });
                })
              : Container()
        ],
      ),
    );
  }

  Future play(String url) async {
    await audioPlayer.play(url);
  }
}
