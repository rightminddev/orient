import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:url_launcher/url_launcher.dart'; // Required for opening Google Maps

class BranchScreen extends StatefulWidget {
  final List branches;
  BranchScreen({required this.branches});

  @override
  _BranchScreenState createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  List viewWidget = [];
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _fetchShops();
  }
  // Future<BitmapDescriptor> getCustomMarker() async {
  //   return await BitmapDescriptor.fromAssetImage(
  //     const ImageConfiguration(size: Size(48, 48)), // Adjust size as needed
  //     'assets/images/custom_marker.png', // Replace with your asset path
  //   );
  // }
  Future<void> _fetchShops() async {
    print("BRANCHES IS ---> ${widget.branches}");
    try {
      List<Marker> loadedMarkers = [];

      for (var shop in widget.branches) {
        Color innerCircleColor = _getInnerCircleColor(shop['title']['ar']);
        Color backCircleColor = _getBackCircleColor(shop['title']['ar']);
        String label = _getText(shop['title']['ar']);

        loadedMarkers.add(Marker(
          point: LatLng(double.parse(shop['lat']), double.parse(shop['lng'])),
          child: GestureDetector(
            onTap: () {
              _openGoogleMaps(shop['lat'], shop['lng']);
            },
            child: SvgPicture.asset("assets/images/svg/mark.svg",width: 38, height: 48,)
          ),
        ));
      }

      setState(() {
        _markers = loadedMarkers.toSet();
      });
    } catch (e) {
      print('Error fetching shops: $e');
    }
  }

  void _openGoogleMaps(String lat, String lng) async {
    final uri = Uri.parse("https://www.google.com/maps?q=$lat,$lng");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open Google Maps';
    }
  }

  Color _getInnerCircleColor(String shopType) {
    // Your existing logic for setting inner circle color
    return Colors.white; // Example: white color for inner circle
  }

  String _getText(String shopType) {
    // Your existing logic for setting text (e.g., role abbreviation or initial)
    return shopType.substring(0, 1).toUpperCase(); // Example: first letter of shopType
  }

  Color _getBackCircleColor(String shopType) {
    // Your existing logic for setting background circle color
    return Colors.blue; // Example: blue color for outer circle
  }

  @override
  Widget build(BuildContext context) {
    print("LIST IS ---> ${viewWidget}");
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 1,
                width: double.infinity,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(
                      double.parse(widget.branches[0]['lat']),
                      double.parse(widget.branches[0]['lng']),
                    ),
                    initialZoom: 14,
                    onTap: (_, __) {
                      setState(() {
                        viewWidget = [];
                      });
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: _markers.toList(),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 90,
                width: double.infinity,
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xff224982)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      AppStrings.branchesAndDistributors.tr().toUpperCase(),
                      style:const TextStyle(color: Color(0xff224982), fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.transparent),
                        onPressed: (){}
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            height: MediaQuery.sizeOf(context).height * 0.35,
            decoration: BoxDecoration(
              color: const Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(32),
            ),
            child: ListView.separated(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: (){
                    _openGoogleMaps("${widget.branches[index]['lat']}", "${widget.branches[index]['lng']}");
                  },
                  child: Container(
                    color: const Color(0xffFFFFFF),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset("assets/images/svg/ic_place.svg"),
                        const SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.7,
                              child: Text(LocalizationService.isArabic(context: context)?"${widget.branches[index]['title']['ar']}" : "${widget.branches[index]['title']['en']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Color(0xff1B1B1B)
                                ),
                              ),
                            ),
                            const SizedBox(height: 3,),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.7,
                              child: Text(LocalizationService.isArabic(context: context)?"${widget.branches[index]['co_info_address']['ar']}" : "${widget.branches[index]['co_info_address']['en']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xffC9CFD2)
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Divider(color:  Color(0xffD5DDE0),),
                ),
                itemCount: widget.branches.length
            ),
          )
        ],
      ),
    );
  }
}
