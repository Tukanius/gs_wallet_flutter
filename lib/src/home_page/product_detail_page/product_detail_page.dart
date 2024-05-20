import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/models/product.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';

class ProductDetailArguments {
  Product data;
  ProductDetailArguments({
    required this.data,
  });
}

class ProductDetail extends StatefulWidget {
  final Product data;
  static const routeName = "ProductDetail";
  const ProductDetail({
    super.key,
    required this.data,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  CarouselController carouselController = CarouselController();
  int _current = 0;
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
                '${widget.data.name}',
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.data.images?.length == 0
                  ? Container(
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: greytext,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                        'Зураг олдсонгүй!',
                        style: TextStyle(
                          color: white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    )
                  : Column(
                      children: [
                        CarouselSlider(
                          carouselController: carouselController,
                          options: CarouselOptions(
                            height: 220.0,
                            autoPlay: widget.data.images != null &&
                                widget.data.images!.length > 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            },
                          ),
                          items: widget.data.images!.map((data) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage('${data.image}'),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                );
                              },
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              widget.data.images!.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () =>
                                  carouselController.animateToPage(entry.key),
                              child: Container(
                                width: 10.0,
                                height: 10.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == entry.key
                                      ? greentext
                                      : greytext,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.data.name}',
                      style: TextStyle(
                        color: white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    widget.data.sale != null
                        ? Container(
                            margin: EdgeInsets.only(bottom: 12),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: buttonbg,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Хямдрах үнэ:',
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        '${widget.data.sale?.saleAmount}₮',
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
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
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: SvgPicture.asset(
                                            'assets/svg/gsc.svg'),
                                      ),
                                      Text(
                                        '${widget.data.sale?.saleTokenAmount} GS',
                                        style: TextStyle(
                                          color: greentext,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SizedBox(),
                    widget.data.sale != null
                        ? Row(
                            children: [
                              Text(
                                'Үнэ: ',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '₮${widget.data.price}',
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
                                '₮${widget.data.price! - (widget.data.sale?.saleAmount ?? 0)}',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                'Үнэ: ',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '₮${widget.data.price}',
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
                      '${widget.data.description}',
                      style: TextStyle(
                        color: colortext,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
