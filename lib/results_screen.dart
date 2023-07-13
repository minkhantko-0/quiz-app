import 'package:first_app/data/questions.dart';
import 'package:first_app/questions_summary.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    required this.chosenAnswers,
    required this.onRestart,
    super.key,
  });

  final List<String> chosenAnswers;
  final Function() onRestart;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i],
        },
      );
    }
    return summary;
  }

  @override
  Widget build(context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectAnswers = summaryData
        .where(
          (summary) => summary["user_answer"] == summary["correct_answer"],
        )
        .length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectAnswers out of $numTotalQuestions questions correctly!',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 201, 153, 251),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            QuestionsSummary(getSummaryData()),
            const SizedBox(height: 30),
            TextButton.icon(
              onPressed: onRestart,
              icon: const Icon(Icons.restart_alt_sharp),
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 237, 223, 252),
              ),
              label: Text(
                "Restart Quiz!",
                style: GoogleFonts.lato(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
