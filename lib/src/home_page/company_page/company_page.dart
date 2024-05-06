import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/models/merchant.dart';
import 'package:green_score/models/result.dart';
import 'package:green_score/src/home_page/company_page/map_page.dart';
import 'package:green_score/src/home_page/company_page/all_product.dart';
import 'package:green_score/src/home_page/company_page/sale_product.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

class _CompanyPageState extends State<CompanyPage>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  int page = 1;
  int limit = 10;
  Result productList = Result(rows: [], count: 0);
  Set<Marker> markers = {};
  double lan = 0;
  double lon = 0;
  late final CameraPosition _kGooglePlex;
  final Completer<GoogleMapController> _controller = Completer();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.index = currentIndex;

    _kGooglePlex = CameraPosition(
      target: widget.data.latitude != null && widget.data.longitude != null
          ? LatLng(widget.data.latitude!, widget.data.longitude!)
          : LatLng(47.920517, 106.917141),
      zoom: 13,
    );
    widget.data.latitude != null && widget.data.longitude != null
        ? markers.add(
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
          )
        : SizedBox();
    super.initState();
  }

  int currentIndex = 0;

  late TabController tabController;
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  changePage(index) {
    setState(() {
      tabController.index = index;
      currentIndex = index;
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
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: SingleChildScrollView(
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
                                          backgroundImage: NetworkImage(
                                              '${widget.data.image}'),
                                          backgroundColor: greytext,
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
                                      gestureRecognizers: <Factory<
                                          OneSequenceGestureRecognizer>>[
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
                                    Navigator.of(context)
                                        .pushNamed(MapPage.routeName,
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
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: buttonbg,
                              ),
                              height: 45,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 45,
                                    child: GestureDetector(
                                      onTap: () {
                                        changePage(0);
                                      },
                                      child: Center(
                                        child: Text(
                                          'Бүх бараа',
                                          style: TextStyle(
                                            color: tabController.index == 0
                                                ? white
                                                : white.withOpacity(0.5),
                                            fontSize: tabController.index == 0
                                                ? 18
                                                : 17,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 45,
                                    child: GestureDetector(
                                      onTap: () {
                                        changePage(1);
                                      },
                                      child: Center(
                                        child: Text(
                                          'Хямдралтай',
                                          style: TextStyle(
                                            color: tabController.index == 1
                                                ? white
                                                : white.withOpacity(0.5),
                                            fontSize: tabController.index == 1
                                                ? 18
                                                : 17,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              MerchantProduct(
                id: widget.data.id!,
              ),
              SaleProductPage(
                id: widget.data.id!,
              ),
            ],
          )),
    );
  }
}
