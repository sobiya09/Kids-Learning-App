// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:kidsmathapp/const.dart';
// import 'package:kidsmathapp/util/my_button.dart';
// import 'package:kidsmathapp/util/result_message.dart';
// import 'package:kidsmathapp/util/number_generator.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class HomePage extends StatefulWidget {
//   final String operation;
//   const HomePage({Key? key, required this.operation}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   List<String> numberPad = [
//     '7',
//     '8',
//     '9',
//     'C',
//     '4',
//     '5',
//     '6',
//     'DEL',
//     '1',
//     '2',
//     '3',
//     '=',
//     '',
//     '0',
//     '',
//   ];
//
//   int numberA = 1;
//   int numberB = 1;
//   String userAnswer = '';
//
//   int score = 0;
//   int remainingTime = 60;
//   int lives = 3;
//   int highScore = 0;
//   late Timer timer;
//
//   @override
//   void initState() {
//     super.initState();
//     loadHighScore();
//     generateQuestion();
//     startTimer();
//   }
//
//   @override
//   void dispose() {
//     timer.cancel();
//     super.dispose();
//   }
//
//   Future<void> loadHighScore() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       highScore = prefs.getInt('highScore') ?? 0;
//     });
//   }
//
//   Future<void> saveHighScore(int newScore) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('highScore', newScore);
//     setState(() {
//       highScore = newScore;
//     });
//   }
//
//   void startTimer() {
//     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (!mounted) return;
//       setState(() {
//         if (remainingTime > 0) {
//           remainingTime--;
//         } else {
//           timer.cancel();
//           showEndDialog('Time ran out!');
//         }
//       });
//     });
//   }
//
//   void resetGame() {
//     timer.cancel();
//     setState(() {
//       score = 0;
//       lives = 3;
//       remainingTime = 60;
//       userAnswer = '';
//     });
//     generateQuestion();
//     startTimer();
//   }
//
//   void buttonTapped(String button) {
//     setState(() {
//       if (button == '=') {
//         if (userAnswer.isEmpty) return;
//         checkResult();
//       } else if (button == 'C') {
//         userAnswer = '';
//       } else if (button == 'DEL') {
//         if (userAnswer.isNotEmpty) {
//           userAnswer = userAnswer.substring(0, userAnswer.length - 1);
//         }
//       } else if (button.isNotEmpty && userAnswer.length < 4) {
//         userAnswer += button;
//       }
//     });
//   }
//
//   void checkResult() {
//     int correctAnswer;
//     switch (widget.operation) {
//       case '+':
//         correctAnswer = numberA + numberB;
//         break;
//       case '-':
//         correctAnswer = numberA - numberB;
//         break;
//       case '×':
//         correctAnswer = numberA * numberB;
//         break;
//       case '÷':
//         correctAnswer = numberB != 0 ? numberA ~/ numberB : 0;
//         break;
//       default:
//         correctAnswer = 0;
//     }
//
//     if (int.tryParse(userAnswer) == correctAnswer) {
//       score += 10;
//       showDialog(
//         context: context,
//         builder: (context) => ResultMessage(
//           message: 'Correct!',
//           onTap: goToNextQuestion,
//           icon: Icons.arrow_forward,
//         ),
//       );
//     } else {
//       setState(() {
//         userAnswer = '';
//         lives -= 1;
//       });
//       if (lives == 0) {
//         timer.cancel();
//         showEndDialog('Out of lives!');
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) => ResultMessage(
//             message: 'Incorrect! Try Again.',
//             onTap: goBackToQuestion,
//             icon: Icons.rotate_left,
//           ),
//         );
//       }
//     }
//   }
//
//   void generateQuestion() {
//     int difficultyLevel = (score ~/ 50) + 1;
//     final operationType = _getOperationType(widget.operation);
//     final numbers = NumberGenerator.generateNumbersForOperation(
//         operationType, difficultyLevel);
//     setState(() {
//       numberA = numbers[0];
//       numberB = numbers[1];
//     });
//   }
//
//   OperationType _getOperationType(String operation) {
//     switch (operation) {
//       case '+':
//         return OperationType.Addition;
//       case '-':
//         return OperationType.Subtraction;
//       case '×':
//         return OperationType.Multiplication;
//       case '÷':
//         return OperationType.Division;
//       default:
//         throw Exception('Invalid operation type');
//     }
//   }
//
//   void goToNextQuestion() {
//     Navigator.of(context).pop();
//     setState(() {
//       userAnswer = '';
//     });
//     generateQuestion();
//   }
//
//   void goBackToQuestion() {
//     Navigator.of(context).pop();
//   }
//
//   void showEndDialog(String reason) {
//     bool isNewHighScore = score > highScore;
//     if (isNewHighScore) {
//       saveHighScore(score);
//     }
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         backgroundColor: Colors.deepPurple,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         title: Text(
//           'Game Over: $reason',
//           style: whiteTextStyle.copyWith(fontSize: 24),
//           textAlign: TextAlign.center,
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'Score: $score',
//               style: whiteTextStyle.copyWith(fontSize: 20),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'High Score: ${isNewHighScore ? score : highScore}',
//               style: whiteTextStyle.copyWith(fontSize: 20),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'Time Left: $remainingTime seconds',
//               style: whiteTextStyle.copyWith(fontSize: 20),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 3,
//                 (index) => Icon(
//                   Icons.favorite,
//                   color: index < lives ? Colors.red : Colors.grey,
//                   size: 30,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               resetGame();
//             },
//             child: Text(
//               'Restart',
//               style: whiteTextStyle.copyWith(fontSize: 18),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.pop(context);
//             },
//             child: Text(
//               'Exit',
//               style: whiteTextStyle.copyWith(fontSize: 18),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String getImageForOperation() {
//     switch (widget.operation) {
//       case '+':
//         return 'assets/images/addT.png';
//       case '-':
//         return 'assets/images/subT.png';
//       case '×':
//         return 'assets/images/multT.png';
//       case '÷':
//         return 'assets/images/divT.png';
//       default:
//         return '';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.deepPurple[300],
//       body: Column(
//         children: [
//           Container(
//             height: 200,
//             color: Colors.deepPurple,
//             child: Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Positioned(
//                   top: 10,
//                   left: 10,
//                   child: IconButton(
//                     icon: Icon(
//                       Icons.arrow_back,
//                       size: 50,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ),
//                 Positioned(
//                   top: -109,
//                   left: 0,
//                   right: 0,
//                   child: Center(
//                     child: Image.asset(
//                       getImageForOperation(),
//                       height: 300,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 155,
//                   left: 10,
//                   right: 10,
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Time: $remainingTime',
//                             style: whiteTextStyle.copyWith(fontSize: 30),
//                           ),
//                           Row(
//                             children: List.generate(
//                               3,
//                               (index) => Icon(
//                                 Icons.favorite,
//                                 color: index < lives ? Colors.red : Colors.grey,
//                                 size: 30,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         'Score: $score',
//                         style: whiteTextStyle.copyWith(fontSize: 32),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     '$numberA ${widget.operation} $numberB = ',
//                     style: whiteTextStyle.copyWith(fontSize: 35),
//                   ),
//                   Container(
//                     height: 50,
//                     width: 100,
//                     decoration: BoxDecoration(
//                       color: Colors.deepPurple[400],
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Center(
//                       child: Text(
//                         userAnswer,
//                         style: whiteTextStyle,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: GridView.builder(
//                 itemCount: numberPad.length,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 4,
//                 ),
//                 itemBuilder: (context, index) {
//                   final button = numberPad[index];
//                   return MyButton(
//                     child: button,
//                     onTap: button.isEmpty ? () {} : () => buttonTapped(button),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
