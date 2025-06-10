import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Анимации',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AnimationDemoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AnimationDemoScreen extends StatefulWidget {
  const AnimationDemoScreen({super.key});

  @override
  State<AnimationDemoScreen> createState() => _AnimationDemoScreenState();
}

class _AnimationDemoScreenState extends State<AnimationDemoScreen>
    with SingleTickerProviderStateMixin {
  // Для имплицитных анимаций
  bool _isVisible = false;
  bool _isExpanded = false;
  double _position = 0;

  // Для явной анимации
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  // Для параллакс-эффекта
  final ScrollController _scrollController = ScrollController();
  double _parallaxOffset = 0;

  @override
  void initState() {
    super.initState();

    // Настройка AnimationController и анимаций
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _rotationAnimation = Tween(begin: 0.0, end: 2 * 3.14).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween(begin: 0.5, end: 1.5).animate(_controller);

    // Параллакс-эффект при скролле
    _scrollController.addListener(() {
      setState(() {
        _parallaxOffset = _scrollController.offset / 2;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Анимации (Оценка 5)')),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // === 1. Имплицитные анимации ===
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Имплицитные анимации',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // AnimatedOpacity
            ElevatedButton(
              onPressed: () => setState(() => _isVisible = !_isVisible),
              child: Text(_isVisible ? "Скрыть текст" : "Показать текст"),
            ),
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: const Text("Этот текст плавно появляется/исчезает"),
            ),

            const SizedBox(height: 20),

            // AnimatedContainer
            ElevatedButton(
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
              child: Text(_isExpanded ? "Уменьшить" : "Увеличить"),
            ),
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: _isExpanded ? 200 : 100,
              height: _isExpanded ? 200 : 100,
              color: _isExpanded ? Colors.green : Colors.blue,
              alignment: Alignment.center,
              child: const Text("Анимированный контейнер", 
                  style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 20),

            // AnimatedPositioned (в Stack)
            SizedBox(
              height: 100,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    left: _position,
                    top: 20,
                    duration: const Duration(seconds: 1),
                    child: GestureDetector(
                      onTap: () => setState(() => _position = _position == 0 ? 100 : 0),
                      child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.red,
                        child: const Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text("Нажмите на красный квадрат, чтобы сдвинуть его"),

            const Divider(),

            // === 2. Явные анимации ===
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Явные анимации',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // Анимация вращения + масштабирования
            GestureDetector(
              onTap: () {
                if (_controller.isAnimating) {
                  _controller.stop();
                } else {
                  _controller.repeat(reverse: true);
                }
              },
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..rotateZ(_rotationAnimation.value)
                      ..scale(_scaleAnimation.value),
                    alignment: Alignment.center,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.star, color: Colors.white, size: 40),
                    ),
                  );
                },
              ),
            ),
            const Text("Нажмите, чтобы остановить/запустить анимацию"),

            const Divider(),

            // === 3. Параллакс-эффект ===
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Параллакс-эффект',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  // Фоновый слой (движется медленнее)
                  Positioned(
                    top: 100 - _parallaxOffset * 0.3,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 200,
                      color: Colors.blue.withOpacity(0.5),
                      child: const Center(child: Text("Фоновый слой")),
                    ),
                  ),

                  // Передний слой (движется быстрее)
                  Positioned(
                    top: 150 - _parallaxOffset * 0.7,
                    left: 50,
                    right: 50,
                    child: Container(
                      height: 100,
                      color: Colors.red.withOpacity(0.5),
                      child: const Center(child: Text("Передний слой")),
                    ),
                  ),
                ],
              ),
            ),
            const Text("Прокрутите вниз/вверх, чтобы увидеть эффект параллакса"),
          ],
        ),
      ),
    );
  }
}