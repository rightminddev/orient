import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/info/states/view_models/states.viewmodel.dart';
import 'package:orient/modules/shared_more_screen/branches/branch_const.dart';
import 'package:orient/modules/shared_more_screen/branches/logic/branch_controller.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart'; // Required for opening Google Maps

class BranchScreen extends StatefulWidget {
  List branches;
  BranchScreen({required this.branches});

  @override
  _BranchScreenState createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  List viewWidget = [];
  Set<Marker> _markers = {};
  final MapController _mapController = MapController();
  var selectCity;
  double? selectedLatitude;
  double? selectedLongitude;
  LatLng? mapCenter; // Add this state variable to store the map's center

  @override
  void initState() {
    super.initState();
    // Set initial map center based on the first branch or default city
    selectedLatitude = double.parse(widget.branches[0]['lat']);
    selectedLongitude = double.parse(widget.branches[0]['lng']);
    mapCenter = LatLng(selectedLatitude!, selectedLongitude!); // Set initial map center
    _fetchShops(widget.branches);
  }

  Future<void> _fetchShops(bra) async {
    try {
      List<Marker> loadedMarkers = [];
      for (var shop in bra) {
        // Check if the shop belongs to the selected city, if applicable
        loadedMarkers.add(Marker(
          point: LatLng(double.parse(shop['lat']), double.parse(shop['lng'])),
          child: GestureDetector(
            onTap: () {
              _openGoogleMaps(shop['lat'], shop['lng']);
            },
            child: SvgPicture.asset("assets/images/svg/mark.svg", width: 38, height: 48),
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

  @override
  Widget build(BuildContext context) {
    print("branches is --> ${widget.branches}");
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => StatesViewModel()..initializeStates(context, "EG"),),
      ChangeNotifierProvider(create: (context) => BranchControllerProvider()),
    ],
    child: Consumer<BranchControllerProvider>(
      builder: (context, branchValue, child) {
        return Consumer<StatesViewModel>(
          builder: (context, value, child) {
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
                          mapController: _mapController, // Add this line
                          options: MapOptions(
                            initialCenter: mapCenter!, // Use the dynamic mapCenter here
                            initialZoom: 12,
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
                      Column(
                        children: [
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
                                  style: const TextStyle(color: Color(0xff224982), fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.arrow_back, color: Colors.transparent),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.45,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 0.32,
                                  child: defaultDropdownField(
                                    borderColor: const Color(0xffE3E5E5),
                                    items: value.states.map((value) {
                                      return DropdownMenuItem(
                                        value: value.id.toString(),
                                        child: Text(
                                          value.title.toString(),
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff000000).withOpacity(0.74)),
                                        ),
                                      );
                                    }).toList(),
                                    title: AppStrings.city.tr(),
                                    isExpanded: true,
                                    value: selectCity,
                                    onChanged: (String? newValue)async {
                                      setState(()async {
                                        selectCity = newValue;
                                        await branchValue.getBranches(context: context, stateId: selectCity.toString());
                                        final selectedState = branchValue.branches.firstWhere(
                                              (state) {
                                                print("state['state_id'] is ${state['state_id']}");
                                                selectedLatitude = double.parse(state['lat']);
                                                selectedLongitude = double.parse(state['lng']);
                                                print("newValue is ${newValue}");
                                                return state['state_id'] == newValue;
                                              },
                                          orElse: () => {"latitude": null, "longitude": null},
                                        );

                                        // Update the map center
                                        mapCenter = LatLng(selectedLatitude!, selectedLongitude!);

                                        // Move the map to the new center
                                        _mapController.move(mapCenter!, 14); // Adjust zoom level if needed

                                        // Clear existing markers
                                        _markers.clear();

                                        // Fetch shops again after moving the map
                                        widget.branches[0]['lat'] =  selectedLatitude.toString();
                                        widget.branches[0]['lng'] =  selectedLongitude.toString();
                                        widget.branches =  branchValue.branches;
                                        _fetchShops(branchValue.branches);

                                        print('Selected City: $selectCity');
                                        print('Latitude: $selectedLatitude');
                                        print('Longitude: $selectedLongitude');
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  // Branches list widget
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    height: MediaQuery.sizeOf(context).height * 0.35,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: (branchValue.branches.isEmpty)? ListView.separated(
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          _openGoogleMaps("${widget.branches[index]['lat']}", "${widget.branches[index]['lng']}");
                        },
                        child: Container(
                          color: const Color(0xffFFFFFF),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset("assets/images/svg/ic_place.svg"),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width * 0.7,
                                    child: Text(
                                      LocalizationService.isArabic(context: context)
                                          ? "${widget.branches[index]['title']['ar']}"
                                          : "${widget.branches[index]['title']['en']}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Color(0xff1B1B1B)),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width * 0.7,
                                    child: Text(
                                      LocalizationService.isArabic(context: context)
                                          ? "${widget.branches[index]['co_info_address']['ar']}"
                                          : "${widget.branches[index]['co_info_address']['en']}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color(0xffC9CFD2)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        child: Divider(color: Color(0xffD5DDE0)),
                      ),
                      itemCount: widget.branches.length,
                    ):ListView.separated(
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          _openGoogleMaps("${branchValue.branches[index]['lat']}", "${branchValue.branches[index]['lng']}");
                        },
                        child: Container(
                          color: const Color(0xffFFFFFF),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset("assets/images/svg/ic_place.svg"),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width * 0.7,
                                    child: Text("${branchValue.branches[index]['name']}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Color(0xff1B1B1B)),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width * 0.7,
                                    child: Text( "${branchValue.branches[index]['locations_address']}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color(0xffC9CFD2)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        child: Divider(color: Color(0xffD5DDE0)),
                      ),
                      itemCount: branchValue.branches.length,
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    )
    );
  }
}
