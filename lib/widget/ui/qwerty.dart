import 'package:flutter/material.dart';
import 'package:green_score/widget/ui/color.dart';

class BackgroundShapes extends StatefulWidget {
  final AppBar? appBar;
  final Widget? floatingActionButton;
  final bool? extendBody;
  final Widget body;
  final Widget? bottomNavigationBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  const BackgroundShapes({
    super.key,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.appBar,
    this.extendBody,
    this.floatingActionButton,
    required this.body,
  });

  @override
  State<BackgroundShapes> createState() => _BackgroundShapesState();
}

class _BackgroundShapesState extends State<BackgroundShapes>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
    _controller.repeat(reverse: true);
    super.initState();
  }

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void dispose() {
    _controller.removeStatusListener((status) {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: widget.extendBody ?? false,
      appBar: widget.appBar,
      floatingActionButton: widget.floatingActionButton,
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButtonLocation: widget.floatingActionButtonLocation ??
          FloatingActionButtonLocation.endFloat,
      backgroundColor: bg,
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: BackgroundPainter(_animation),
            child: Container(
              child: widget.body,
            ),
          );
        },
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final Animation<double> animation;
  const BackgroundPainter(this.animation);

  Offset getOffset(Path path) {
    final pms = path.computeMetrics(forceClosed: false).elementAt(0);
    final length = pms.length;
    final offset = pms.getTangentForOffset(length * animation.value)!.position;
    return offset;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.maskFilter = const MaskFilter.blur(
      BlurStyle.normal,
      100,
    );
    drawShape1(canvas, size, paint, bggreen);
    drawShape2(canvas, size, paint, bgred);
    drawShape3(canvas, size, paint, bgyellow);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  void drawShape1(
    Canvas canvas,
    Size size,
    Paint paint,
    Color color,
  ) {
    paint.color = color;
    Path path = Path();

    path.moveTo(size.width, 0);
    path.quadraticBezierTo(
      size.width / 2,
      size.height / 2,
      -100,
      size.height / 4,
    );

    final offset = getOffset(path);
    canvas.drawCircle(offset, 120, paint);
  }

  void drawShape2(
    Canvas canvas,
    Size size,
    Paint paint,
    Color color,
  ) {
    paint.color = color;
    Path path = Path();

    path.moveTo(size.width, size.height);
    path.quadraticBezierTo(
      size.width / 2,
      size.height / 2,
      size.width * 0.9,
      size.height * 0.9,
    );

    final offset = getOffset(path);
    canvas.drawCircle(offset, 150, paint);
  }

  void drawShape3(
    Canvas canvas,
    Size size,
    Paint paint,
    Color color,
  ) {
    paint.color = color;
    Path path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(
      0,
      size.height,
      size.width / 3,
      size.height / 3,
    );

    final offset = getOffset(path);
    canvas.drawCircle(offset, 100, paint);
  }
}
