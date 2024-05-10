import 'package:flutter/material.dart';
import 'package:green_score/models/product.dart';

class ImageCard extends StatefulWidget {
  final Product data;
  const ImageCard({super.key, required this.data});

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    return widget.data.images?.length == 0
        ? SizedBox()
        : Image(
            image: NetworkImage('${widget.data.images?.first.image}'),
            fit: BoxFit.cover,
          );
  }
}
