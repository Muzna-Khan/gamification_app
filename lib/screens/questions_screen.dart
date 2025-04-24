import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamification_app/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/question_model.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key , required this.onSelectedAnswer});
  final void Function(String answer) onSelectedAnswer;


  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  int currentQuestionIndex = 0;
  bool isPlaying = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addListener(() {
            setState(() {});
          });

    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.2)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }
  //
  // @override
  // void dispose() {
  //   _audioPlayer.dispose();
  //   _controller.dispose();
  //   super.dispose();
  // }

  void playAudio({required String audioPath}) async {
    if (isPlaying) {
      await _audioPlayer.stop();
      _controller.stop();

      setState(() {
        isPlaying = false;
      });
    } else {
      try {
        await _audioPlayer.setSource(AssetSource(audioPath));
        await _audioPlayer.resume();
        _controller.repeat(reverse: true);
        setState(() {
          isPlaying = true;

        });
        _audioPlayer.onPlayerComplete.listen((event){
          _controller.stop();
          setState(() {
            isPlaying = false;
          });
        });


      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: Text("Cant play audio"),
        ));
        print(e);
      }
    }
  }

  void answerQuestion(String selectedAns){

   widget.onSelectedAnswer(selectedAns);
    //final currentQustion = questions[currentQuestionIndex];
    if(currentQuestionIndex < questions.length-1){
      setState(() {
        currentQuestionIndex ++;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    final QuizQuestions currentQuestion = questions[currentQuestionIndex];
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.green, Colors.yellow])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () => playAudio(audioPath: currentQuestion.audioPath),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (isPlaying)
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green.withOpacity(0.3))),
                    ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.green,
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 45,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 500,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  itemCount: currentQuestion.answers.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: ()=> answerQuestion(currentQuestion.answers[index]),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage(currentQuestion.images[index]),
                            ),
                            SizedBox(height: 8,),
                            Text(currentQuestion.answers[index], style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),)
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
