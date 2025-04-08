import 'package:flutter/material.dart';
import 'package:kidsmathapp/arithmetic_game.dart';


class OperationSelectPage extends StatelessWidget {
  const OperationSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final List<Map<String, dynamic>> options = [
      {
        'label': 'ADDITION',
        'symbol': '+',
        'image': 'assets/images/add.png',
        'page': ArithmeticGamePage(operation: '+'),
      },
      {
        'label': 'SUBTRACTION',
        'symbol': '-',
        'image': 'assets/images/min.png',
        'page': ArithmeticGamePage(operation: '-'),
      },
      {
        'label': 'MULTIPLICATION',
        'symbol': '×',
        'image': 'assets/images/mul.png',
        'page': ArithmeticGamePage(operation: '×'),
      },
      {
        'label': 'DIVISION',
        'symbol': '÷',
        'image': 'assets/images/div.png',
        'page': ArithmeticGamePage(operation: '÷'),
      },

    ];

    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.05),
                  child: Image.asset(
                    'assets/images/math4kids.png',
                    height: screenHeight * 0.2,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'SELECT FUNCTION',
                  style: TextStyle(
                    fontSize: screenWidth * 0.09,
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
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: screenWidth * 0.04,
                mainAxisSpacing: screenHeight * 0.02,
                children: options.map((option) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => option['page']),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[400],
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            option['image'],
                            height: screenHeight * 0.07,
                            width: screenWidth * 0.15,
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
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
