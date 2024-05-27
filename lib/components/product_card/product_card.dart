import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/models/product.dart';
import 'package:green_score/widget/ui/color.dart';

class ProductCard extends StatefulWidget {
  final Product data;
  final Function() onClick;
  const ProductCard({super.key, required this.onClick, required this.data});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: buttonbg,
        border: widget.data.sale != null
            ? Border.all(
                color: greentext,
                width: 1,
              )
            : Border(),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                color: greytext,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(19),
                child: widget.data.images?.length == 0
                    ? SizedBox()
                    : Image(
                        image:
                            NetworkImage('${widget.data.images!.first.image}'),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '${widget.data.name}',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 1,
              ),
              widget.data.sale != null
                  ? Text(
                      // '${widget.data.sale?.saleTokenAmount}%',
                      '1%',
                      style: TextStyle(
                        color: greentext,
                      ),
                    )
                  : SizedBox(),
              GestureDetector(
                onTap: widget.onClick,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: buttonbg,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Үзэх',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset('assets/svg/arrow_forward.svg'),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
