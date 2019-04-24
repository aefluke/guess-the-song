import 'package:simple_song_quiz/utils/question.dart';

class Quiz {
  List<Question> _questions;
  int _currentQuestionIndex = -1;
  int _score = 0;

  Quiz(List<Question> questions){
    questions.shuffle();
    this._questions = questions.take(5).toList();
  }

  List<Question> get questions => _questions;

  int get score => _score;

  int get length => _questions.length;

  int get questionNumber => _currentQuestionIndex + 1;

  Question get nextQuestion {
    if (++_currentQuestionIndex >= length) return null;
    return _questions.elementAt(_currentQuestionIndex);
  }

  void answer(bool isCorrect){
    if (isCorrect) _score++;
  }
}
