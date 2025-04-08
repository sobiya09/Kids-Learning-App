import 'package:flutter/material.dart';
import 'package:kidsmathapp/arithmetic_game.dart';

class ArithmeticSelectPage extends StatelessWidget {
  const ArithmeticSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final List<Map<String, dynamic>> operations = [
      {
        'label': 'ADDITION',
        'symbol': '+',
        'image': 'assets/images/add.png',
        'color': Colors.green,
      },
      {
        'label': 'SUBTRACTION',
        'symbol': '-',
        'image': 'assets/images/min.png',
        'color': Colors.blue,
      },
      {
        'label': 'MULTIPLICATION',
        'symbol': '×',
        'image': 'assets/images/mul.png',
        'color': Colors.orange,
      },
      {
        'label': 'DIVISION',
        'symbol': '÷',
        'image': 'assets/images/div.png',
        'color': Colors.red,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select an Operation!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
        elevation: 8,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade900,Colors.purpleAccent.shade400 ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.03),
              child: Image.asset(
                'assets/images/math4kids.png',
                height: screenHeight * 0.25,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.04), // Space at the top

            SizedBox(height: screenHeight * 0.04), // Space between title and grid
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: screenWidth * 0.05,
                  mainAxisSpacing: screenHeight * 0.05,
                  children: operations.map((op) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OperationSelectedPage(
                              operation: op['symbol'],
                              label: op['label'],
                              image: op['image'],
                              color: op['color'],
                            ),
                          ),
                        );
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(screenWidth * 0.06),
                          color: Colors.white.withOpacity(0.15), // Glass effect
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(4, 4),
                            ),
                          ],
                          border: Border.all(color: op['color']!, width: 3),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              op['image'],
                              height: screenHeight * 0.1,
                              width: screenWidth * 0.2,
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            Text(
                              op['label'],
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 4,
                                    color: Colors.black38,
                                    offset: Offset(2, 2),
                                  ),
                                ],
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
      ),

    );
  }
}

class OperationSelectedPage extends StatelessWidget {
  final String operation;
  final String label;
  final String image;
  final Color color;

  const OperationSelectedPage({
    Key? key,
    required this.operation,
    required this.label,
    required this.image,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Get Ready!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: color,
        centerTitle: true,
        elevation: 6,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You selected:",
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Image.asset(
              image,
              height: screenHeight * 0.2,
              width: screenWidth * 0.4,
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              label,
              style: TextStyle(
                fontSize: screenWidth * 0.08,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArithmeticGamePage(operation: operation),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1,
                  vertical: screenHeight * 0.02,
                ),
              ),
              child: Text(
                "Start Game",
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
