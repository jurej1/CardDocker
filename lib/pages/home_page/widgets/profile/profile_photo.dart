import 'package:flutter/material.dart';

class ProfilePhoto extends StatefulWidget {
  final String? imageUrl;

  const ProfilePhoto({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _ProfilePhotoState createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      reverseDuration: const Duration(seconds: 2),
      vsync: this,
    );

    _glowAnimation = Tween<double>(begin: 6.0, end: 30.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.slowMiddle,
      ),
    );
    // _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height * 0.35;
    final photoHeight = totalHeight * 0.6;
    return Container(
      height: totalHeight,
      child: Center(
        child: AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, child) {
            return Container(
              height: photoHeight,
              width: photoHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: _glowAnimation.value,
                    color: Colors.blue,
                    spreadRadius: 1,
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: Transform.scale(
                scale: 0.8,
                child: Icon(
                  Icons.person,
                  size: photoHeight,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
