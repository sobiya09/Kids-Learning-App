import 'dart:math';
import 'package:flutter/material.dart';

class AlphabetLearningPage extends StatefulWidget {
  const AlphabetLearningPage({Key? key}) : super(key: key);

  @override
  _AlphabetLearningPageState createState() => _AlphabetLearningPageState();
}

class _AlphabetLearningPageState extends State<AlphabetLearningPage> {
  final Map<String, List<String>> alphabetExamples = {
    'A': ['Apple', 'Ant', 'Aeroplane', 'Avocado'],
    'B': ['Ball', 'Banana', 'Butterfly', 'Balloon'],
    'C': ['Cat', 'Carrot', 'Cake', 'Cloud'],
    'D': ['Dog', 'Dolphin', 'Dragon', 'Duck'],
    'E': ['Elephant', 'Eagle', 'Eggplant', 'Engine'],
    'F': ['Fish', 'Frog', 'Fire', 'Feather'],
    'G': ['Grapes', 'Guitar', 'Goat', 'Gift'],
    'H': ['Hat', 'Horse', 'Helicopter', 'Honey'],
    'I': ['Ice Cream', 'Igloo', 'Island', 'Insect'],
    'J': ['Juice', 'Jellyfish', 'Jacket', 'Jump'],
    'K': ['Kite', 'Kangaroo', 'Kiwi', 'King'],
    'L': ['Lion', 'Lemon', 'Lighthouse', 'Leaf'],
    'M': ['Monkey', 'Mango', 'Moon', 'Mountain'],
    'N': ['Nest', 'Notebook', 'Noodles', 'Nut'],
    'O': ['Orange', 'Octopus', 'Owl', 'Onion'],
    'P': ['Panda', 'Parrot', 'Pumpkin', 'Pizza'],
    'Q': ['Queen', 'Quokka', 'Quilt', 'Quiz'],
    'R': ['Rabbit', 'Rainbow', 'Rose', 'Rocket'],
    'S': ['Sun', 'Star', 'Strawberry', 'Snake'],
    'T': ['Tiger', 'Turtle', 'Train', 'Tree'],
    'U': ['Umbrella', 'Unicorn', 'Urchin', 'Uniform'],
    'V': ['Violin', 'Volcano', 'Vulture', 'Van'],
    'W': ['Whale', 'Watermelon', 'Watch', 'Window'],
    'X': ['Xylophone', 'X-ray', 'Xenon', 'Xerox'],
    'Y': ['Yoyo', 'Yak', 'Yacht', 'Yogurt'],
    'Z': ['Zebra', 'Zucchini', 'Zip', 'Zoo'],
  };

  final Random _random = Random();

  void _showRandomWord(String letter) {
    final words = alphabetExamples[letter]!;
    final randomWord = words[_random.nextInt(words.length)];

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: Colors.transparent, // Transparent to allow gradient
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple[400]!, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 10,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                letter,
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(color: Colors.black38, blurRadius: 10, offset: Offset(3, 3)),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Icon(
                Icons.lightbulb_outline,
                color: Colors.yellow[600],
                size: 50,
              ),
              SizedBox(height: 15),
              Text(
                'For example: $randomWord',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  elevation: 8,
                ),
                child: Text(
                  'Close',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final letters = alphabetExamples.keys.toList();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alphabet Learning',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),
        ),
        backgroundColor: Colors.deepPurple[500],
        centerTitle: true,
        elevation: 10,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple[500]!, Colors.deepPurple[600]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: screenWidth * 0.05,
            mainAxisSpacing: screenHeight * 0.03,
            children: letters.map((letter) {
              return GestureDetector(
                onTap: () => _showRandomWord(letter),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepPurple, Colors.purpleAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 8,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Comic Sans MS',
                        shadows: [
                          Shadow(
                            blurRadius: 5,
                            color: Colors.black26,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

