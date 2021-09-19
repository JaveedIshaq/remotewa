import 'package:flutter/material.dart';

/// Sticker Widget
class StickerWidget extends StatelessWidget {
  ///
  const StickerWidget({Key? key, required this.onPressed, required this.img})
      : super(key: key);

  /// Callback Function on Sticker Press
  final VoidCallback onPressed;

  /// Name of the Sticker Image
  final String img;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Image.asset(
        'assets/stickers/$img.gif',
        width: 50.0,
        height: 50.0,
        fit: BoxFit.cover,
      ),
    );
  }
}
