import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, _) {
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: false,
            fontFamily: 'MPLUSRounded1c',
          ),
          debugShowCheckedModeBanner: false,
          home: const PaintDemoApp(),
        );
      },
    );
  }
}

class PaintDemoApp extends StatefulWidget {
  const PaintDemoApp({super.key});

  @override
  State<PaintDemoApp> createState() => _PaintDemoAppState();
}

class _PaintDemoAppState extends State<PaintDemoApp> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedTextBody(),
      ),
    );
  }
}

class AnimatedTextBody extends StatefulWidget {
  const AnimatedTextBody({super.key});

  @override
  State<AnimatedTextBody> createState() => _AnimatedTextBodyState();
}

class _AnimatedTextBodyState extends State<AnimatedTextBody> {
  late String text;
  int? selectedIndex;
  int? right;
  int? left;

  final List<GlobalKey> _textKeys = [];

  @override
  void initState() {
    super.initState();
    text = 'Happy Birthday';
    _textKeys.addAll(List.generate(text.length, (_) => GlobalKey()));
  }

  void _updateSelectedIndexFromPosition(Offset position) {
    for (int i = 0; i < _textKeys.length; i++) {
      final key = _textKeys[i];
      final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) return;
      final boxPosition = renderBox.localToGlobal(Offset.zero);
      final boxSize = renderBox.size;

      // Check if the drag position is within this character's box
      if (position.dx >= boxPosition.dx &&
          position.dx <= boxPosition.dx + boxSize.width) {
        setState(() {
          selectedIndex = i;
          left = i - 1;
          right = i + 1;
        });
        break;
      }
    }
  }

  double _getFontSize(int index) {
    if (selectedIndex == index) {
      return 50;
    } else if (left == index || right == index) {
      return 40;
    } else {
      return 30;
    }
  }

  Color _getTextColor(int index) {
    if (selectedIndex == index) {
      return Colors.orange;
    } else if (left == index || right == index) {
      return Colors.orange.withOpacity(0.8);
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = text.split('');
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        _updateSelectedIndexFromPosition(details.globalPosition);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(data.length, (index) {
          return TweenAnimationBuilder(
            key: _textKeys[index],
            tween: Tween<double>(
              begin: 30,
              end: _getFontSize(index),
            ),
            duration: const Duration(milliseconds: 100),
            builder: (context, size, child) {
              return Text(
                data[index],
                style: TextStyle(
                  color: _getTextColor(index),
                  fontWeight: FontWeight.w800,
                  fontSize: size,
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
