import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class DrawingPage extends StatefulWidget {
  const DrawingPage({Key? key}) : super(key: key);

  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  List<DrawnObject> drawnObjects = [];
  List<DrawnObject> undoneObjects = []; // New list to keep track of undone objects
  DrawnObject? currentObject;
  Color selectedColor = Colors.black;
  double strokeWidth = 4.0;
  bool isErasing = false;
  DrawingMode drawingMode = DrawingMode.freeDraw;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Drawing Pad 🎨', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(icon: Icon(Icons.undo), onPressed: _undo),
          IconButton(icon: Icon(Icons.redo), onPressed: _redo),
          IconButton(icon: Icon(Icons.clear), onPressed: _clearCanvas),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanStart: (details) {
                RenderBox renderBox = context.findRenderObject() as RenderBox;
                Offset localPosition = renderBox.globalToLocal(details.globalPosition);
                setState(() {
                  currentObject = DrawnObject(
                    path: [localPosition],
                    color: isErasing ? Colors.white : selectedColor,
                    width: strokeWidth,
                    mode: drawingMode,
                  );
                  drawnObjects.add(currentObject!);
                });
              },
              onPanUpdate: (details) {
                RenderBox renderBox = context.findRenderObject() as RenderBox;
                Offset localPosition = renderBox.globalToLocal(details.globalPosition);
                setState(() {
                  currentObject?.path.add(localPosition);
                });
              },
              onPanEnd: (details) {
                setState(() {
                  currentObject = null;
                });
              },
              child: CustomPaint(
                size: Size.infinite,
                painter: DrawingPainter(drawnObjects: drawnObjects),
              ),
            ),
          ),
          _buildToolbar(),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 4, spreadRadius: 1)],
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(  // Wrap the Row in SingleChildScrollView
        scrollDirection: Axis.horizontal, // Allow horizontal scrolling
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align items at the start
          children: [
            _buildColorPicker(Colors.black),
            _buildColorPicker(Colors.red),
            _buildColorPicker(Colors.green),
            _buildColorPicker(Colors.blue),
            _buildColorPicker(Colors.orange),
            DropdownButton<DrawingMode>(
              value: drawingMode,
              onChanged: (DrawingMode? newMode) {
                setState(() {
                  drawingMode = newMode!;
                });
              },
              items: [
                DropdownMenuItem(value: DrawingMode.freeDraw, child: Text("Free Draw")),
                DropdownMenuItem(value: DrawingMode.line, child: Text("Line")),
                DropdownMenuItem(value: DrawingMode.rectangle, child: Text("Rectangle")),
                DropdownMenuItem(value: DrawingMode.circle, child: Text("Circle")),
                DropdownMenuItem(value: DrawingMode.dotted, child: Text("Dotted Line")),
              ],
            ),
            Slider(
              min: 1.0,
              max: 20.0,
              value: strokeWidth,
              activeColor: Colors.deepPurple,
              onChanged: (value) {
                setState(() {
                  strokeWidth = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildColorPicker(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
          isErasing = false;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        width: 20,
        height: 35,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            width: selectedColor == color ? 3.0 : 1.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _undo() {
    if (drawnObjects.isNotEmpty) {
      setState(() {
        undoneObjects.add(drawnObjects.removeLast()); // Add the last object to undoneObjects
      });
    }
  }

  void _redo() {
    if (undoneObjects.isNotEmpty) {
      setState(() {
        drawnObjects.add(undoneObjects.removeLast()); // Add the last undone object back to drawnObjects
      });
    }
  }

  void _clearCanvas() {
    setState(() {
      drawnObjects.clear();
      undoneObjects.clear(); // Clear both lists
    });
  }
}

class DrawnObject {
  List<Offset> path;
  Color color;
  double width;
  DrawingMode mode;
  DrawnObject({required this.path, required this.color, required this.width, required this.mode});
}

enum DrawingMode { freeDraw, line, rectangle, circle, dotted }

class DrawingPainter extends CustomPainter {
  final List<DrawnObject> drawnObjects;
  DrawingPainter({required this.drawnObjects});

  @override
  void paint(Canvas canvas, Size size) {

    for (var obj in drawnObjects) {
      Paint paint = Paint()
        ..color = obj.color
        ..strokeWidth = obj.width
        ..strokeCap = StrokeCap.round;

      if (obj.mode == DrawingMode.freeDraw) {
        for (int i = 0; i < obj.path.length - 1; i++) {
          canvas.drawLine(obj.path[i], obj.path[i + 1], paint);
        }
      } else if (obj.mode == DrawingMode.line && obj.path.length > 1) {
        canvas.drawLine(obj.path.first, obj.path.last, paint);
      } else if (obj.mode == DrawingMode.rectangle && obj.path.length > 1) {
        Offset start = obj.path.first;
        Offset end = obj.path.last;
        Rect rect = Rect.fromPoints(start, end);
        canvas.drawRect(rect, paint);
      } else if (obj.mode == DrawingMode.circle && obj.path.length > 1) {
        Offset start = obj.path.first;
        Offset end = obj.path.last;
        double radius = (end - start).distance / 2;
        Offset center = Offset((start.dx + end.dx) / 2, (start.dy + end.dy) / 2);
        canvas.drawCircle(center, radius, paint);
      } else if (obj.mode == DrawingMode.dotted && obj.path.length > 1) {
        for (int i = 0; i < obj.path.length - 1; i += 5) {
          if (i + 1 < obj.path.length) {
            canvas.drawCircle(obj.path[i], obj.width / 2, paint);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

