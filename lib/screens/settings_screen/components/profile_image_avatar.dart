import 'package:flutter/material.dart';
import 'package:remotewa/config/colors.dart';

/// ProfileImageAvatar
class ProfileImageAvatar extends StatelessWidget {
  ///
  const ProfileImageAvatar({
    Key? key,
    required this.photoUrl,
  }) : super(key: key);

  ///
  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Image.network(
        photoUrl,
        fit: BoxFit.cover,
        width: 90.0,
        height: 90.0,
        errorBuilder: (context, object, stackTrace) {
          return Icon(
            Icons.account_circle,
            size: 90.0,
            color: greyColor,
          );
        },
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: 90.0,
            height: 90.0,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null &&
                        loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      ),
      borderRadius: const BorderRadius.all(Radius.circular(45.0)),
      clipBehavior: Clip.hardEdge,
    );
  }
}
