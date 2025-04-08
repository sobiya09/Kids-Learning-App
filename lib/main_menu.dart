import 'package:flutter/material.dart';
import 'package:kidsmathapp/alphabet_learning.dart';
import 'package:kidsmathapp/arithmetic.dart';
import 'package:kidsmathapp/drawing.dart';
import 'package:kidsmathapp/story_telling_menu.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final List<Map<String, dynamic>> options = [
      {
        'label': 'ARITHMETIC',
        'image': 'assets/images/arithmetic.png',
        'page': ArithmeticSelectPage(),
      },
      {
        'label': 'STORY TELLING',
        'image': 'assets/images/story_telling.png',
        'page': StoryMenuPage(),
      },
      {
        'label': 'DRAWING',
        'image': 'assets/images/draw.png',
        'page': DrawingPage(),
      },
      {
        'label': 'ALPHABET',
        'image': 'assets/images/alphabet.png',
        'page': AlphabetLearningPage(),
      },
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade600, Colors.pinkAccent.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.05),
              child: Text(
                'Kids Learning Fun!',
                style: TextStyle(
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Comic Sans MS',
                  shadows: [
                    Shadow(blurRadius: 4, color: Colors.black26, offset: Offset(2, 2)),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.03),
                    child: Image.asset(
                      'assets/images/learning.png',
                      height: screenHeight * 0.25,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'SELECT A FUN ACTIVITY!',
                    style: TextStyle(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: screenWidth * 0.04,
                    mainAxisSpacing: screenHeight * 0.02,
                  ),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final option = options[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => option['page']),
                        );
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(screenWidth * 0.05),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5,
                              offset: Offset(3, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              option['image'],
                              height: screenHeight * 0.08,
                              width: screenWidth * 0.2,
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              option['label'],
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
