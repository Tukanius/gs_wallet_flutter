import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:green_score/models/product.dart';
import 'package:green_score/widget/ui/color.dart';

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
        : BlurHash(
            color: greytext,
            hash: '${widget.data.images?.first.blurhash}',
            image: '${widget.data.images?.first.url}',
            imageFit: BoxFit.cover,
          );
  }
}
