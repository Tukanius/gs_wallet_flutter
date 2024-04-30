import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/api/product_api.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/product_card/product_card.dart';
import 'package:green_score/models/merchant.dart';
import 'package:green_score/models/result.dart';
import 'package:green_score/src/home_page/company_page/map_page.dart';
import 'package:green_score/src/home_page/product_detail_page/product_detail_page.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CompanyPageArguments {
  Merchant data;
  CompanyPageArguments({
    required this.data,
  });
}

class CompanyPage extends StatefulWidget {
  final Merchant data;

  static const routeName = "CompanyPage";
  const CompanyPage({super.key, required this.data});

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> with AfterLayoutMixin {
  bool isLoading = true;
  int page = 1;
  int limit = 10;
  Result productList = Result(rows: [], count: 0);
  Set<Marker> markers = {};
  double lan = 0;
  double lon = 0;
  late final CameraPosition _kGooglePlex;
  final Completer<GoogleMapController> _controller = Completer();

  afterFirstLayout(BuildContext context) async {
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.data.latitude!, widget.data.longitude!),
      zoom: 13,
    );
    markers.add(
      Marker(
        markerId: const MarkerId('Location'),
        position: LatLng(widget.data.latitude!, widget.data.longitude!),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(title: 'Location'),
        onTap: () {},
      ),
    );
    await list(page, limit);
    setState(() {
      isLoading = false;
    });
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(merchant: widget.data.id);
    productList = await ProductApi()
        .getProduct(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

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
              ),
            ),
          ];
        },
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: greentext,
                ),
              )
            : Container(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            child: SvgPicture.asset('assets/svg/avatar.svg'),
                            // backgroundImage: AssetImage('assets/images/avatar.jpg'),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            '${widget.data.name}',
                            style: TextStyle(
                              color: white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // Text(
                      //   'Манай дэлгүүр 2014 оноос хойш тасралтгүй Америкаас бараа бүтээгдэхүүн оруулж ирж байгаа. Only originals! 🇺🇸💯',
                      //   style: TextStyle(
                      //     color: colortext,
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'И-мэйл:',
                            style: TextStyle(
                              color: colortext,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${widget.data.email}',
                            style: TextStyle(
                              color: colortext,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Утас:',
                            style: TextStyle(
                              color: colortext,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${widget.data.phone}',
                            style: TextStyle(
                              color: colortext,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Утас:',
                            style: TextStyle(
                              color: colortext,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            widget.data.phoneSecond != null
                                ? '${widget.data.phoneSecond}'
                                : '-',
                            style: TextStyle(
                              color: colortext,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Social хаяг',
                            style: TextStyle(
                              color: colortext,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Column(
                            children: widget.data.links!
                                .map(
                                  (data) => Text(
                                    "${data.uri}",
                                    style: TextStyle(
                                      color: colortext,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 140,
                              child: GoogleMap(
                                zoomControlsEnabled: false,
                                mapType: MapType.hybrid,
                                compassEnabled: false,
                                myLocationButtonEnabled: false,
                                markers: Set<Marker>.of(markers),
                                initialCameraPosition: _kGooglePlex,
                                gestureRecognizers:
                                    <Factory<OneSequenceGestureRecognizer>>[
                                  Factory<OneSequenceGestureRecognizer>(
                                    () => EagerGestureRecognizer(),
                                  ),
                                ].toSet(),
                                onMapCreated: (mapcontroller) {
                                  _controller.complete(mapcontroller);
                                },
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(MapPage.routeName,
                                  arguments: MapPageArguments(
                                    lang: widget.data.latitude!,
                                    long: widget.data.longitude!,
                                  ));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 140,
                              color: transparent,
                            ),
                          )
                        ],
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.of(context).pushNamed(MapPage.routeName,
                      //         arguments: MapPageArguments(
                      //           lang: widget.data.latitude!,
                      //           long: widget.data.longitude!,
                      //         ));
                      //   },
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(15),
                      //     child: Container(
                      //       width: MediaQuery.of(context).size.width,
                      //       height: 140,
                      //       child: GoogleMap(
                      //         zoomControlsEnabled: false,
                      //         mapType: MapType.hybrid,
                      //         compassEnabled: false,
                      //         myLocationButtonEnabled: false,
                      //         markers: Set<Marker>.of(markers),
                      //         initialCameraPosition: _kGooglePlex,
                      //         gestureRecognizers:
                      //             <Factory<OneSequenceGestureRecognizer>>[
                      //           Factory<OneSequenceGestureRecognizer>(
                      //             () => EagerGestureRecognizer(),
                      //           ),
                      //         ].toSet(),
                      //         onMapCreated: (mapcontroller) {
                      //           _controller.complete(mapcontroller);
                      //         },
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.data.address != null
                            ? 'Хаяг: ${widget.data.address}'
                            : 'Хаяг: -',
                        style: TextStyle(
                          color: colortext,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Хямдралтай бараа",
                        style: TextStyle(
                          color: white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      FormTextField(
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/svg/search.svg'),
                          ],
                        ),
                        hintText: "Хайх",
                        colortext: white,
                        color: buttonbg,
                        name: "search",
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      productList.rows != null
                          ? GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 15,
                              childAspectRatio: 3 / 4,
                              padding: EdgeInsets.all(0),
                              physics: NeverScrollableScrollPhysics(),
                              children: productList.rows!
                                  .map(
                                    (data) => ProductCard(
                                      data: data,
                                      onClick: () {
                                        Navigator.of(context).pushNamed(
                                          ProductDetail.routeName,
                                          arguments: ProductDetailArguments(
                                            data: data,
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                  .toList(),
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Center(
                                  child: Text(
                                    'Бүртгэлтэй бараа олдсонгүй',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
