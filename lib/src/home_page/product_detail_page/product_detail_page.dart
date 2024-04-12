import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';

class ProductDetailArguments {
  String? name;
  int? price;
  String? description;
  ProductDetailArguments({
    this.name,
    this.price,
    this.description,
  });
}

class ProductDetail extends StatefulWidget {
  final String? name;
  final int? price;
  final String? description;
  static const routeName = "ProductDetail";
  const ProductDetail({
    super.key,
    this.name,
    this.price,
    this.description,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return BackgroundShapes(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxisScrolled) {
          return <Widget>[
            SliverAppBar(
              toolbarHeight: 60,
              automaticallyImplyLeading: false,
              pinned: false,
              snap: true,
              floating: true,
              elevation: 0,
              titleSpacing: 60,
              backgroundColor: transparent,
              leading: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  CustomBackButton(
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              centerTitle: true,
              title: Text(
                '${widget.name}',
                style: TextStyle(
                  color: white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ];
        },
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/avatar.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Asus ROG RTX 4080 32GB RAM 2TB SSD',
                  style: TextStyle(
                    color: white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text(
                      'Ашиглагдах GS:',
                      style: TextStyle(
                        color: white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      child: SvgPicture.asset('assets/svg/gsc.svg'),
                    ),
                    Text(
                      '20,000 GS',
                      style: TextStyle(
                        color: greentext,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text(
                      '₮${widget.price! + 10000}',
                      style: TextStyle(
                        color: greytext,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: greytext,
                        decorationThickness: 2,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '₮${widget.price}',
                      style: TextStyle(
                        color: white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  // 'Processor: 13th Gen Intel Core i7-13650HXGraphics: NVIDIA GeForce RTX 4060 with 8GB GDDR6 VRAMDisplay: 16-inch QHD+ (2560 x 1600) IPS-level display with 165 Hz refresh rateRAM: 16GB DDR5-4800Storage: 512Gb PCIe® 4.0 NVMe™ M.2 SSDOperating System: Windows 11 Home',
                  '${widget.description}',
                  style: TextStyle(
                    color: colortext,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
