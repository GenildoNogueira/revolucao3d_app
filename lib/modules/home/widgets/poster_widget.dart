import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/shimmer_widget.dart';

class Poster extends StatelessWidget {
  final String url;

  const Poster({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        child: CachedNetworkImage(
          key: UniqueKey(),
          imageUrl: url,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              const ShimmerWidget.rectangular(height: double.infinity),
          errorWidget: (context, url, error) => Container(
            color: Colors.black12,
            child: const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
          ),
        ),
      ),
    );
  }
}
