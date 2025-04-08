import 'dart:math';

enum OperationType { Addition, Subtraction, Multiplication, Division }

class NumberGenerator {
  static List<int> generateNumbersForOperation(OperationType operation, int level) {
    final random = Random();
    int num1 = 0;
    int num2 = 0;
    switch (operation) {
      case OperationType.Addition:
        num1 = random.nextInt(10 * level);
        num2 = random.nextInt(10 * level);
        break;
      case OperationType.Subtraction:
        num1 = random.nextInt(10 * level) + 5;
        num2 = random.nextInt(num1);
        break;
      case OperationType.Multiplication:
        num1 = random.nextInt(5 * level) + 1;
        num2 = random.nextInt(5 * level) + 1;
        break;
      case OperationType.Division:
        num2 = random.nextInt(5 * level) + 1;
        num1 = num2 * (random.nextInt(5 * level) + 1);
        break;
    }
    return [num1, num2];
  }
}