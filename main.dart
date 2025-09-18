import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Отслеживание жестов',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const GestureTrackerPage(),
    );
  }
}

class GestureTrackerPage extends StatefulWidget {
  const GestureTrackerPage({Key? key}) : super(key: key);

  @override
  State<GestureTrackerPage> createState() => _GestureTrackerPageState();
}

class _GestureTrackerPageState extends State<GestureTrackerPage> {
  String _lastGesture = "Начните делать жесты!";
  int _gestureCount = 0;
  final List<String> _gestureHistory = [];
  Color _backgroundColor = Colors.blueGrey[900]!;

  void _updateGesture(String gesture) {
    setState(() {
      _lastGesture = gesture;
      _gestureCount++;
      if (_gestureHistory.length >= 5) {
        _gestureHistory.removeAt(0);
      }
      _gestureHistory.add(gesture);
    });
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    // Обработка масштабирования
    if (details.scale != 1.0) {
      if (details.scale > 1.05) {
        _updateGesture("Увеличение");
      } else if (details.scale < 0.95) {
        _updateGesture("Уменьшение");
      }
      return; // Прекращаем выполнение, так как это жест масштабирования
    }

    // Обработка свайпов (панорамирование)
    const double sensitivity = 5.0;
    if (details.focalPointDelta.dx.abs() > details.focalPointDelta.dy.abs()) {
      if (details.focalPointDelta.dx > sensitivity) {
        _updateGesture("Свайп вправо");
        setState(() => _backgroundColor = Colors.red[800]!);
      } else if (details.focalPointDelta.dx < -sensitivity) {
        _updateGesture("Свайп влево");
        setState(() => _backgroundColor = Colors.green[800]!);
      }
    } else {
      if (details.focalPointDelta.dy > sensitivity) {
        _updateGesture("Свайп вниз");
        setState(() => _backgroundColor = Colors.orange[800]!);
      } else if (details.focalPointDelta.dy < -sensitivity) {
        _updateGesture("Свайп вверх");
        setState(() => _backgroundColor = Colors.purple[800]!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Отслеживание жестов',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          // Счётчик жестов
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Счётчик жестов: $_gestureCount',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          
          // Основная зона для жестов
          Expanded(
            child: GestureDetector(
              onTap: () => _updateGesture("Обнаружен тап"),
              onDoubleTap: () => _updateGesture("Обнаружен двойной тап"),
              onLongPress: () => _updateGesture("Долгое нажатие обнаружено"),
              onScaleUpdate: _onScaleUpdate,
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Text(
                    _lastGesture,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          
          // История жестов
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'История жестов:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                ..._gestureHistory.reversed.map((gesture) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    '• $gesture',
                    style: const TextStyle(color: Colors.white70),
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}