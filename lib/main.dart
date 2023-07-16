import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'questionBrain.dart';

void main() => runApp(MaterialApp(
      home: Myapp(),
    ));

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  List<Icon> score = [];

  QuestionBrain brain = QuestionBrain();

  void checkAnswer(bool userAnswer) {
    if (score.length < brain.getLength() - 1) {
      if (brain.getAnswer() == userAnswer) {
        setState(() {
          score.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        });
      } else {
        setState(() {
          score.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        });
      }
      //
      brain.nextQuestion();
    } else {
      Alert(
        context: context,
        type: AlertType.success,
        title: "Quiz Done",
        desc: "you have successfully completed the quiz",
        buttons: [
          DialogButton(
            child: Text(
              "Restart",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              setState(() {
                score.clear();
                Navigator.pop(context);
                brain.reset();
              });
            },
            width: 120,
          )
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 100.0),
                  child: Center(
                    child: Text(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        brain.getText()),
                  ), // the String here has a problem
                ),
              ),
              Expanded(
                child: Card(
                  child: TextButton(
                    onPressed: () {
                      checkAnswer(true);
                    },
                    child: Text(style: TextStyle(color: Colors.white), "True"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: TextButton(
                    onPressed: () {
                      checkAnswer(false);
                    },
                    child: Text(style: TextStyle(color: Colors.white), "False"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: score,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
