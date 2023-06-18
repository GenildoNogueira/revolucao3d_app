import 'package:flutter/material.dart';

class CircularPerfilIcon extends StatelessWidget {
  const CircularPerfilIcon({
    super.key,
    this.imageUrl,
    this.onTap,
  });

  final String? imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    /*return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10),
      child: Container(
        height: 60,
        width: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.white,
          ),
          shape: BoxShape.circle,
        ),
        child: const Text(
          'GN',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );*/

    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
      ),
      child: CircleAvatar(
        maxRadius: 60,
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: imageUrl == null
                ? const FractionallySizedBox(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: Center(
                      child: Text(
                        'GN',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
