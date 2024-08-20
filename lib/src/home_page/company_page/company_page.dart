import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/api/product_api.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/product_card/product_card.dart';
import 'package:green_score/components/refresher/refresher.dart';
import 'package:green_score/models/merchant.dart';
import 'package:green_score/models/result.dart';
import 'package:green_score/src/home_page/company_page/map_page.dart';
import 'package:green_score/src/home_page/product_detail_page/product_detail_page.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_score/widget/ui/form_textfield.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool isMapLoading = false;
  Set<Marker> markers = {};
  late CameraPosition cameraPosition = CameraPosition(
    target: LatLng(47.920517, 106.917141),
    zoom: 13,
  );
  final Completer<GoogleMapController> _controller = Completer();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  int page = 1;
  int limit = 10;
  Result productList = Result(rows: [], count: 0);
  TextEditingController controller = TextEditingController();
  Timer? timer;
  bool isSubmit = false;

  @override
  afterFirstLayout(BuildContext context) async {
    await list(page, limit, '');
    try {
      setState(() {
        isMapLoading = true;
      });
      if (widget.data.latitude != null && widget.data.longitude != null) {
        setState(() {
          cameraPosition = CameraPosition(
            target: LatLng(
              widget.data.latitude!,
              widget.data.longitude!,
            ),
            zoom: 13,
          );
          markers.add(
            Marker(
              markerId: const MarkerId('Location'),
              position:
                  widget.data.latitude != null && widget.data.longitude != null
                      ? LatLng(widget.data.latitude!, widget.data.longitude!)
                      : LatLng(47.920517, 106.917141),
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: const InfoWindow(title: 'Location'),
              onTap: () {},
            ),
          );
        });
      }
      setState(() {
        isMapLoading = false;
      });
    } catch (e) {
      setState(() {
        isMapLoading = false;
      });
      print(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  list(page, limit, String value) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: value, merchant: widget.data.id);
    productList = await ProductApi()
        .getProduct(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      limit = 10;
      controller.clear();
    });
    await list(page, limit, '');
    refreshController.refreshCompleted();
  }

  onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit, '');
    refreshController.loadComplete();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onChange(String query) {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        isSubmit = true;
      });
      list(page, limit, query);
      setState(() {
        isSubmit = false;
      });
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
              leading: CustomBackButton(
                onClick: () {
                  Navigator.of(context).pop();
                },
              ),
              centerTitle: true,
              titleSpacing: 100,
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
        body: Refresher(
          color: greentext,
          refreshController: refreshController,
          onLoading:
              productList.rows!.length == productList.count ? null : onLoading,
          onRefresh: onRefresh,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: widget.data.image != null
                            ? CircleAvatar(
                                radius: 20,
                                backgroundColor: greytext,
                                child: BlurHash(
                                  color: greytext,
                                  hash: '${widget.data.image?.blurhash}',
                                  image: '${widget.data.image?.url}',
                                  imageFit: BoxFit.cover,
                                ),
                              )
                            : SvgPicture.asset(
                                'assets/svg/avatar.svg',
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          '${widget.data.name}',
                          style: TextStyle(
                            color: white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
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
                        'Утас 2:',
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
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Social хаяг:',
                        style: TextStyle(
                          color: colortext,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        children: widget.data.links!
                            .map(
                              (data) => Row(
                                children: [
                                  data.type != "XOT"
                                      ? GestureDetector(
                                          onTap: () => _launchURL(data.uri!),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.asset(
                                              data.type == "FACEBOOK"
                                                  ? 'assets/images/fb.png'
                                                  : data.type == "INSTAGRAM"
                                                      ? 'assets/images/ig.png'
                                                      : data.type == "TWITTER"
                                                          ? 'assets/images/x.png'
                                                          : 'assets/images/fb.png',
                                              height: 40,
                                              width: 40,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
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
                          child: isMapLoading == true
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: greentext,
                                  ),
                                )
                              : GoogleMap(
                                  zoomControlsEnabled: false,
                                  mapType: MapType.normal,
                                  compassEnabled: false,
                                  myLocationButtonEnabled: false,
                                  markers: Set<Marker>.of(markers),
                                  initialCameraPosition: cameraPosition,
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
                    height: 15,
                  ),
                  Text(
                    "Бүх бараа",
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
                    controller: controller,
                    onChanged: (query) {
                      onChange(query);
                    },
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
                    name: "query",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: greentext,
                          ),
                        )
                      : productList.rows!.isNotEmpty
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
                                  height: 80,
                                ),
                                SvgPicture.asset(
                                  'assets/svg/notfound.svg',
                                ),
                                SizedBox(
                                  height: 15,
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
                                SizedBox(
                                  height: 80,
                                ),
                              ],
                            ),
                  SizedBox(
                    // height: MediaQuery.of(context).size.height * 0.1,
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
