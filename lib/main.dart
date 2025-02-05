import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

void main() {
  runApp(
    const MaterialApp(
      home: PixelImage(),
    ),
  );
}

class PixelImage extends StatefulWidget {
  const PixelImage({super.key});

  @override
  State<PixelImage> createState() => _PixelImageState();
}

class _PixelImageState extends State<PixelImage>
    with SingleTickerProviderStateMixin {
  ui.Image? _image;
  ByteData? byteData;
  late AnimationController _controller;
  late Animation<double> _animation;
  List<Offset> startPositions = [];
  String imagePath = 'assets/images/apple.png';

  @override
  void initState() {
    super.initState();
    _loadImage();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
      reverseDuration: const Duration(seconds: 5),
    )..forward();

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  void _loadImage() async {
    final image = await _loadImageFromAsset(imagePath);
    byteData = await image.toByteData();
    setState(() {
      _image = image;
      _generateStartPositions(image);
    });
  }

  Future<ui.Image> _loadImageFromAsset(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  void _generateStartPositions(ui.Image image) {
    final Random random = Random();
    final imageWidth = image.width + random.nextDouble();
    final imageHeight = image.height + random.nextDouble();

    for (double y = 0; y < imageHeight; y++) {
      for (double x = 0; x < imageWidth; x++) {
        final startX = random.nextDouble() * imageWidth;
        final startY = -random.nextDouble() * imageHeight;
        startPositions.add(Offset(startX, startY));
      }
    }
  }

  void _reloadAnimation() {
    switch (imagePath) {
      case 'assets/images/apple.png':
        imagePath = 'assets/images/facebook.png';
        break;
      case 'assets/images/facebook.png':
        imagePath = 'assets/images/apple.png';
        break;
    }
    _loadImage();
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: _reloadAnimation,
        child: const Icon(Icons.shuffle),
      ),
      body: Center(
        child: Builder(builder: (context) {
          if (_image == null) return const SizedBox.shrink();
          return CustomPaint(
            size: Size(_image!.width.toDouble(), _image!.height.toDouble()),
            painter: PixelRainPainter(
                image: _image!,
                progress: _animation.value,
                byteData: byteData!,
                startPositions: startPositions),
          );
        }),
      ),
    );
  }
}

class PixelRainPainter extends CustomPainter {
  final ui.Image image;
  final ByteData byteData;
  final double progress;
  final List<Offset> startPositions;

  PixelRainPainter({
    required this.image,
    required this.progress,
    required this.startPositions,
    required this.byteData,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final int imageWidth = image.width;
    final int imageHeight = image.height;

    final Uint8List pixels = byteData.buffer.asUint8List();

    for (int y = 0; y < imageHeight; y++) {
      for (int x = 0; x < imageWidth; x++) {
        final int offset = (y * imageWidth + x) * 4;
        final int r = pixels[offset];
        final int g = pixels[offset + 1];
        final int b = pixels[offset + 2];
        final int a = pixels[offset + 3];
        final Color color = Color.fromARGB(a, r, g, b);

        final int index = y * imageWidth + x;
        final Offset start = startPositions[index];
        final Offset end = Offset(x.toDouble(), y.toDouble());
        final Offset current = Offset.lerp(start, end, progress)!;

        final Paint paint = Paint()..color = color;
        canvas.drawRect(Rect.fromLTWH(current.dx, current.dy, 1, 1), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
