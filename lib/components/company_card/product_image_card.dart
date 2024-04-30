import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/models/product.dart';
import 'package:green_score/widget/ui/color.dart';

class ImageCard extends StatefulWidget {
  final Product data;
  const ImageCard({super.key, required this.data});

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> with AfterLayoutMixin {
  String url = '';
  bool isLoading = true;
  @override
  afterFirstLayout(BuildContext context) {
    url = widget.data.images!.first.image!;
    print('=======URL========');
    print(url);
    print('=======URL========');

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(
              color: greentext,
            ),
          )
        : widget.data.images == null
            ? SvgPicture.asset('assets/svg/avatar.svg')
            : Image(
                image: NetworkImage('$url'),
                fit: BoxFit.cover,
              );
  }
}
