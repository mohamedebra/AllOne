

























///
///// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
// import 'package:uuid/uuid.dart';
//
// import '../../../core/helper/loction_map.dart';
// import '../data/model/place.dart';
//
// class MapScreen extends StatefulWidget {
//   const MapScreen({Key? key}) : super(key: key);
//
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   List<PlaceSuggestion> places = [];
//   FloatingSearchBarController controller = FloatingSearchBarController();
//   static Position? position;
//   Completer<GoogleMapController> _mapController = Completer();
//
//   static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
//     bearing: 0.0,
//     target: LatLng(position!.latitude, position!.longitude),
//     tilt: 0.0,
//     zoom: 17,
//   );
//
//   // these variables for getPlaceLocation
//   Set<Marker> markers = Set();
//   late PlaceSuggestion placeSuggestion;
//   late Place selectedPlace;
//   late Marker searchedPlaceMarker;
//   late Marker currentLocationMarker;
//   late CameraPosition goToSearchedForPlace;
//
//   void buildCameraNewPosition() {
//     goToSearchedForPlace = CameraPosition(
//       bearing: 0.0,
//       tilt: 0.0,
//       target: LatLng(
//         selectedPlace.result.geometry.location.lat!,
//         selectedPlace.result.geometry.location.lng!,
//       ),
//       zoom: 13,
//     );
//   }
//
//   // these variables for getDirections
//   PlaceDirections? placeDirections;
//   var progressIndicator = false;
//   late List<LatLng> polylinePoints;
//   var isSearchedPlaceMarkerClicked = false;
//   var isTimeAndDistanceVisible = false;
//   late String time;
//   late String distance;
//
//   @override
//   initState() {
//     super.initState();
//     getMyCurrentLocation();
//   }
//
//   Future<void> getMyCurrentLocation() async {
//     position = await LocationHelper.getCurrentLocation().whenComplete(() {
//       setState(() {});
//     });
//   }
//
//   Widget buildMap() {
//     return GoogleMap(
//       mapType: MapType.normal,
//       myLocationEnabled: true,
//       zoomControlsEnabled: false,
//       myLocationButtonEnabled: false,
//       markers: markers,
//       initialCameraPosition: _myCurrentLocationCameraPosition,
//       onMapCreated: (GoogleMapController controller) {
//         _mapController.complete(controller);
//       },
//       polylines: placeDirections != null
//           ? {
//         Polyline(
//           polylineId: const PolylineId('my_polyline'),
//           color: Colors.black,
//           width: 2,
//           points: polylinePoints,
//         ),
//       }
//           : {},
//     );
//   }
//
//   Future<void> _goToMyCurrentLocation() async {
//     final GoogleMapController controller = await _mapController.future;
//     controller.animateCamera(
//         CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
//   }
//
//   Widget buildFloatingSearchBar() {
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//
//     return FloatingSearchBar(
//       controller: controller,
//       elevation: 6,
//       hintStyle: TextStyle(fontSize: 18),
//       queryStyle: TextStyle(fontSize: 18),
//       hint: 'Find a place..',
//       border: BorderSide(style: BorderStyle.none),
//       margins: EdgeInsets.fromLTRB(20, 70, 20, 0),
//       padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
//       height: 52,
//       scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
//       transitionDuration: const Duration(milliseconds: 600),
//       transitionCurve: Curves.easeInOut,
//       physics: const BouncingScrollPhysics(),
//       axisAlignment: isPortrait ? 0.0 : -1.0,
//       openAxisAlignment: 0.0,
//       width: isPortrait ? 600 : 500,
//       debounceDelay: const Duration(milliseconds: 500),
//       progress: progressIndicator,
//       onQueryChanged: (query) {
//         getPlacesSuggestions(query);
//       },
//       onFocusChanged: (_) {
//         // hide distance and time row
//         setState(() {
//           isTimeAndDistanceVisible = false;
//         });
//       },
//       transition: CircularFloatingSearchBarTransition(),
//       actions: [
//         FloatingSearchBarAction(
//           showIfOpened: false,
//           child: CircularButton(
//               icon: Icon(Icons.place, color: Colors.black.withOpacity(0.6)),
//               onPressed: () {}),
//         ),
//       ],
//       builder: (context, transition) {
//         return ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               buildSuggestionsBloc(),
//               buildSelectedPlaceLocationBloc(),
//               buildDiretionsBloc(),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget buildDiretionsBloc() {
//     return BlocListener<MapsCubit, MapsState>(
//       listener: (context, state) {
//         if (state is DirectionsLoaded) {
//           placeDirections = (state).placeDirections;
//
//           getPolylinePoints();
//         }
//       },
//       child: Container(),
//     );
//   }
//
//   void getPolylinePoints() {
//     polylinePoints = placeDirections!.polylinePoints
//         .map((e) => LatLng(e.latitude, e.longitude))
//         .toList();
//   }
//
//   Widget buildSelectedPlaceLocationBloc() {
//     return BlocListener<MapsCubit, MapsState>(
//       listener: (context, state) {
//         if (state is PlaceLocationLoaded) {
//           selectedPlace = (state).place;
//
//           goToMySearchedForLocation();
//           getDirections();
//         }
//       },
//       child: Container(),
//     );
//   }
//
//   void getDirections() {
//     BlocProvider.of<MapsCubit>(context).emitPlaceDirections(
//       LatLng(position!.latitude, position!.longitude),
//       LatLng(selectedPlace.result.geometry.location.lat!,
//           selectedPlace.result.geometry.location.lng!),
//     );
//   }
//
//   Future<void> goToMySearchedForLocation() async {
//     buildCameraNewPosition();
//     final GoogleMapController controller = await _mapController.future;
//     controller
//         .animateCamera(CameraUpdate.newCameraPosition(goToSearchedForPlace));
//     buildSearchedPlaceMarker();
//   }
//
//   void buildSearchedPlaceMarker() {
//     searchedPlaceMarker = Marker(
//       position: goToSearchedForPlace.target,
//       markerId: MarkerId('1'),
//       onTap: () {
//         buildCurrentLocationMarker();
//         // show time and distance
//         setState(() {
//           isSearchedPlaceMarkerClicked = true;
//           isTimeAndDistanceVisible = true;
//         });
//       },
//       infoWindow: InfoWindow(title: "${placeSuggestion.description}"),
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//     );
//
//     addMarkerToMarkersAndUpdateUI(searchedPlaceMarker);
//   }
//
//   void buildCurrentLocationMarker() {
//     currentLocationMarker = Marker(
//       position: LatLng(position!.latitude, position!.longitude),
//       markerId: MarkerId('2'),
//       onTap: () {},
//       infoWindow: InfoWindow(title: "Your current Location"),
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//     );
//     addMarkerToMarkersAndUpdateUI(currentLocationMarker);
//   }
//
//   void addMarkerToMarkersAndUpdateUI(Marker marker) {
//     setState(() {
//       markers.add(marker);
//     });
//   }
//
//   void getPlacesSuggestions(String query) {
//     final sessionToken = Uuid().v4();
//     BlocProvider.of<MapsCubit>(context)
//         .emitPlaceSuggestions(query, sessionToken);
//   }
//
//   Widget buildSuggestionsBloc() {
//     return BlocBuilder<MapsCubit, MapsState>(
//       builder: (context, state) {
//         if (state is PlacesLoaded) {
//           places = (state).places;
//           if (places.length != 0) {
//             return buildPlacesList();
//           } else {
//             return Container();
//           }
//         } else {
//           return Container();
//         }
//       },
//     );
//   }
//
//   Widget buildPlacesList() {
//     return ListView.builder(
//         itemBuilder: (ctx, index) {
//           return InkWell(
//             onTap: () async {
//               placeSuggestion = places[index];
//               controller.close();
//               getSelectedPlaceLocation();
//               polylinePoints.clear();
//               removeAllMarkersAndUpdateUI();
//             },
//             child: PlaceItem(
//               suggestion: places[index],
//             ),
//           );
//         },
//         itemCount: places.length,
//         shrinkWrap: true,
//         physics: const ClampingScrollPhysics());
//   }
//
//   void removeAllMarkersAndUpdateUI() {
//     setState(() {
//       markers.clear();
//     });
//   }
//
//   void getSelectedPlaceLocation() {
//     final sessionToken = Uuid().v4();
//     BlocProvider.of<MapsCubit>(context)
//         .emitPlaceLocation(placeSuggestion.placeId, sessionToken);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           position != null
//               ? buildMap()
//               : Center(
//             child: Container(
//               child: CircularProgressIndicator(
//               ),
//             ),
//           ),
//           buildFloatingSearchBar(),
//           isSearchedPlaceMarkerClicked
//               ? DistanceAndTime(
//             isTimeAndDistanceVisible: isTimeAndDistanceVisible,
//             placeDirections: placeDirections,
//           )
//               : Container(),
//         ],
//       ),
//       floatingActionButton: Container(
//         margin: EdgeInsets.fromLTRB(0, 0, 8, 30),
//         child: FloatingActionButton(
//           onPressed: _goToMyCurrentLocation,
//           child: Icon(Icons.place, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

///
//import 'dart:async';
// import 'dart:typed_data';
// import 'dart:ui';
//
// import 'package:all_one/features/home/logic/home_cubit.dart';
// import 'package:all_one/features/home/logic/home_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../../../../core/helper/loction_map.dart';
// import '../../data/model/model.dart';
// import 'dart:ui' as ui;
// import 'package:flutter/services.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:screenshot/screenshot.dart';
//
// class GoogleMapScreen extends StatefulWidget {
//   const GoogleMapScreen({super.key});
//
//   @override
//   State<GoogleMapScreen> createState() => GoogleMapScreenState();
// }
//
// class GoogleMapScreenState extends State<GoogleMapScreen> {
//   Markers marker = Markers();
//
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();
//   Completer<GoogleMapController> _mapController = Completer();
//
//   final Set<Marker> markers = Set();
//   late Marker searchedPlaceMarker;
//   late Marker currentLocationMarker;
//   late List<LatLng> polylinePoints;
//   static Position? position;
//   late CameraPosition goToSearchedForPlace;
//   ScreenshotController _screenshotController = ScreenshotController();
//
//   List<int> list = [];
//   Future<Uint8List> getBytesFromAsset(String path, int width) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//         targetWidth: width);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
//   }
//
//   getBytesFromNetworkImage(String url, int width) async {
//     final cacheManager = DefaultCacheManager();
//     try {
//       final file = await cacheManager.getSingleFile(url);
//
//       if (file == null || !file.existsSync()) {
//         print('Image file does not exist.');
//         return null;
//       }
//
//       final ByteData data = await file.readAsBytes().then((byteList) =>
//           ByteData.sublistView(
//               Uint8List.fromList(byteList).buffer.asByteData()));
//       final ui.Codec codec = await ui
//           .instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
//       final ui.FrameInfo fi = await codec.getNextFrame();
//       return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//           .buffer
//           .asUint8List();
//     } catch (e) {
//       print('Error loading network image: $e');
//       return null;
//     }
//   }
//
//   Future<Marker> createCustomMarker(String markerId, LatLng position) async {
//     final Uint8List markerIcon =
//         await getBytesFromAsset('asstes/images/2.jpg', 100);
//     final Uint8List markerIcons = await getBytesFromNetworkImage(
//         'https://img.freepik.com/premium-photo/hamburger-with-lettuce-tomato-cheese-it_667286-3180.jpg?w=740',
//         100);
//
//     return Marker(
//       markerId: MarkerId(markerId),
//       position: position,
//       icon: BitmapDescriptor.fromBytes(markerIcon!),
//     );
//   }
//
//   FloatingSearchBarController controller = FloatingSearchBarController();
//   var progressIndicator = false;
//   var isSearchedPlaceMarkerClicked = false;
//   var isTimeAndDistanceVisible = false;
//   late String time;
//   late String distance;
//   static CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(position!.latitude, position!.longitude),
//     zoom: 8.4746,
//   );
// //    target: LatLng(25.16371532, 55.17464960),
//   Future<void> getMyCurrentLocation() async {
//     position = await LocationHelper.getCurrentLocation()
//         .whenComplete(() => setState(() {}));
//   }
//
//   Future<void> checkAndRequestLocationPermission() async {
//     var status = await Permission.location.status;
//     if (!status.isGranted) {
//       // Permission is not granted, request it
//       status = await Permission.location.request();
//       if (status.isGranted) {
//         // Permission granted, proceed to access location
//       } else if (status.isDenied) {
//         // The user denied the permission
//         // Handle the denial gracefully, maybe show a dialog explaining why you need the permission
//       } else if (status.isPermanentlyDenied) {
//         // The user has denied the permission permanently
//         // Open app settings to let them enable the permission
//         openAppSettings();
//       }
//     }
//   }
//
//   void buildCurrentLocationMarker() {
//     currentLocationMarker = Marker(
//       position: const LatLng(25.16371532, 55.17464960),
//       markerId: MarkerId('2'),
//       onTap: () {},
//       infoWindow: InfoWindow(title: "Your current Location"),
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//     );
//     addMarkerToMarkersAndUpdateUI(currentLocationMarker);
//   }
//
//   void addMarkerToMarkersAndUpdateUI(Marker marker) {
//     setState(() {
//       markers.add(marker);
//     });
//   }
//
//   void removeAllMarkersAndUpdateUI() {
//     setState(() {
//       markers.clear();
//     });
//   }
//
//   Widget buildFloatingSearchBar() {
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//
//     return FloatingSearchBar(
//       controller: controller,
//       elevation: 6,
//       hintStyle: TextStyle(fontSize: 18),
//       queryStyle: TextStyle(fontSize: 18),
//       hint: 'Find a place..',
//       border: BorderSide(style: BorderStyle.none),
//       margins: EdgeInsets.fromLTRB(20, 70, 20, 0),
//       padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
//       height: 52,
//       iconColor: Colors.blue,
//       scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
//       transitionDuration: const Duration(milliseconds: 600),
//       transitionCurve: Curves.easeInOut,
//       physics: const BouncingScrollPhysics(),
//       axisAlignment: isPortrait ? 0.0 : -1.0,
//       openAxisAlignment: 0.0,
//       width: isPortrait ? 600 : 500,
//       debounceDelay: const Duration(milliseconds: 500),
//       progress: progressIndicator,
//       onQueryChanged: (query) {
//         // getPlacesSuggestions(query);
//       },
//       onFocusChanged: (_) {
//         // hide distance and time row
//         setState(() {
//           isTimeAndDistanceVisible = false;
//         });
//       },
//       transition: CircularFloatingSearchBarTransition(),
//       actions: [
//         FloatingSearchBarAction(
//           showIfOpened: false,
//           child: CircularButton(
//               icon: Icon(Icons.place, color: Colors.black.withOpacity(0.6)),
//               onPressed: () {}),
//         ),
//       ],
//       builder: (context, transition) {
//         return ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // buildSuggestionsBloc(),
//               // buildSelectedPlaceLocationBloc(),
//               // buildDiretionsBloc(),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void buildCameraNewPosition() {
//     goToSearchedForPlace = CameraPosition(
//       bearing: 0.0,
//       tilt: 0.0,
//       target: LatLng(
//         31.02377,
//         23.0500,
//       ),
//       zoom: 13,
//     );
//   }
//
//   // Future<void> goToMySearchedForLocation() async {
//   //   buildCameraNewPosition();
//   //   final GoogleMapController controller = await _mapController.future;
//   //   controller
//   //       .animateCamera(CameraUpdate.newCameraPosition(goToSearchedForPlace));
//   //   buildSearchedPlaceMarker();
//   // }
//
//   Future<void> _goToMyCurrentLocation() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
//   }
//
//   @override
//   void initState() {
//     getMyCurrentLocation();
//     _addMarkers();
//     super.initState();
//   }
//
//   Future<void> _loadMarker() async {
//     Marker customMarker = await createCustomMarker(
//         'markerId1', LatLng(markerTest[0].lati!, markerTest[0].lang!));
//     setState(() {
//       markers.add(customMarker);
//     });
//   }
//   // Future<void> _loadMarkers() async {
//   //   final BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
//   //     ImageConfiguration(size: Size(10, 10)), // Size of the custom icon
//   //     'asstes/images/2.jpg', // Asset path to the custom icon
//   //   );
//   //
//   //   // Create a marker with a custom icon
//   //   Marker customMarker = Marker(
//   //     markerId: MarkerId('customMarker'),
//   //     position: LatLng(37.42796133580664, -122.085749655962),
//   //     icon: customIcon,
//   //   );
//   //
//   //   setState(() {
//   //     markers.add(customMarker);
//   //   });
//   // }
//
//   Future<BitmapDescriptor> getCustomMarkerIcon() async {
//     return BitmapDescriptor.fromAssetImage(
//       ImageConfiguration(devicePixelRatio: 2.5),
//       'asstes/images/2.jpg',
//     );
//   }
//
//   Widget customMarkerWidget() {
//     return Container(
//       width: 50,
//       height: 50,
//       decoration: BoxDecoration(
//         color: Colors.blue,
//         shape: BoxShape.circle,
//       ),
//       child: Icon(
//         Icons.location_on,
//         color: Colors.white,
//         size: 30,
//       ),
//     );
//   }
//
//   Future<void> _addMarkers() async {
//     // Add custom markers with different icons
//     // final icon1 = await _getMarkerIcon(Colors.blue);
//     // final icon2 = await _getMarkerIcon(Colors.red);
//
//     // markers.add(
//     //   Marker(
//     //     markerId: MarkerId("marker1"),
//     //     position: LatLng(37.7749, -122.4194),
//     //     icon: icon1,
//     //   ),
//     // );
//     //
//     // markers.add(
//     //   Marker(
//     //     markerId: MarkerId("marker2"),
//     //     position: LatLng(55.1746406, 25.16371532),
//     //     icon: icon2,
//     //   ),
//     // );
//
//     // Add a custom widget as a marker
//     final customMarkerBytes = await _convertWidgetToBytes();
//     final customMarkerIcon = BitmapDescriptor.fromBytes(customMarkerBytes!);
//
//     markers.add(
//       Marker(
//         markerId: MarkerId("customMarker"),
//         position: LatLng(25.16371532, 55.17464960),
//         infoWindow: InfoWindow(
//             title: "Dierbergs markets",),
//         icon: customMarkerIcon,
//       ),
//     );
//
//     setState(() {});
//   }
//
//   Future<BitmapDescriptor> _getMarkerIcon(Color color) async {
//     final Uint8List markerIconData = await _downloadMarkerIcon(color);
//     return BitmapDescriptor.fromBytes(markerIconData);
//   }
//
//   Future<Uint8List> _downloadMarkerIcon(Color color) async {
//     // Replace with your logic to download marker icon as bytes
//     // Simulate downloading by creating a colored circle
//     final recorder = PictureRecorder();
//     final canvas =
//         Canvas(recorder, Rect.fromPoints(Offset(0, 0), Offset(40, 40)));
//     final paint = Paint()..color = color;
//     canvas.drawCircle(Offset(20, 20), 20, paint);
//     final img = await recorder.endRecording().toImage(40, 40);
//     final byteData = await img.toByteData(format: ImageByteFormat.png);
//     return byteData!.buffer.asUint8List();
//   }
//   // ScreenshotController _screenshotController = ScreenshotController();
//
//   Widget _customMarkerWidget() {
//     return Container(
//       width: 50,
//       height: 50,
//       decoration: BoxDecoration(
//         color: Colors.green,
//         shape: BoxShape.circle,
//       ),
//       child: Image(image: NetworkImage('https://img.freepik.com/premium-photo/hamburger-with-lettuce-tomato-cheese-it_667286-3180.jpg'),height: 100,),
//     );
//   }
//
//   Future _convertWidgetToBytes() async {
//
//     final imageBytes = await _screenshotController.captureFromLongWidget(
//       _customMarkerWidget(),
//     );
//     return imageBytes;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           position != null
//               ? GoogleMap(
//                   mapType: MapType.normal,
//                   myLocationEnabled: true,
//                   zoomControlsEnabled: false,
//                   myLocationButtonEnabled: false,
//                   initialCameraPosition: _kGooglePlex,
//                   markers: markers,
//                 )
//               : Center(
//                   child: Container(
//                     child: CircularProgressIndicator(
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ),
//           buildFloatingSearchBar(),
//         ],
//       ),
//     );
//   }
// }
///
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _items = List.generate(20, (i) => "Item $i");

  Future<void> _refresh() async {
    // Simulate network fetch or any async operation
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      // Update your data
      _items.clear();
      _items.addAll(List.generate(20, (i) => "Refreshed item $i"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pull to Refresh"),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_items[index]),
            );
          },
        ),
      ),
    );
  }
}

///
//class Offers extends StatefulWidget {
//   const Offers({super.key});
//
//   @override
//   State<Offers> createState() => _OffersState();
// }
//
// class _OffersState extends State<Offers> {
//   // final OfferController controllerData = Get.put(OfferController());
//   OffersScreenController controller = Get.put(OffersScreenController(OfferRepo(ApiService(Dio()))));
//   final lang = CacheHelper.getData(key: 'lang');
//   bool on = false;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return BlocProvider(
//       create: (BuildContext context) => OffersCubit(OfferRepo(ApiService(Dio())))..fetchProduct()..fetchCategory()..fetchCountry(),
//       child: BlocBuilder<OffersCubit, OfferState>(
//         builder: (context,state){
//           if (state is OfferLoadingState) {
//             return const LoadingCoustomAllView();
//           } else if (state is OfferLoadedState) {
//
//             // Render your list here
//             return Scaffold(
//                 appBar: AppBar(
//                   title: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'OFFERS'.tr,
//                         style: TextStyles.font20BlueBold,
//                       ),
//                       GetBuilder<OfferController>(
//                           init: OfferController(ProductRepo(ApiService(Dio())),TypesRepo(ApiService(Dio()))),
//                           builder: (controller) {
//                             return Column(
//                               children: [
//                                 TextButton(
//                                   onPressed: () => context.read<OffersCubit>().chooseName(context),
//                                   child: Text('ChooseaCity'.tr,
//                                       style: TextStyles.font14BlueSemiBold),
//                                 ),
//                               ],
//                             );
//                           })
//                     ],
//                   ),
//                 ),
//                 body: Column(
//                   children: [
//                     // Search field
//                     Padding(
//                       padding:
//                       const EdgeInsets.only(top: 25, left: 20, right: 20),
//                       child: TextFormField(
//                         controller: controller.searchController,
//                         decoration: InputDecoration(
//                           isDense: true,
//                           contentPadding:
//                           EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
//                           focusedBorder:
//                           OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: ColorsManager.mainMauve,
//                               width: 1.3,
//                             ),
//                             borderRadius: BorderRadius.circular(16.0),
//                           ),
//                           enabledBorder:
//                           OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: ColorsManager.lighterGray,
//                               width: 1.3,
//                             ),
//                             borderRadius: BorderRadius.circular(16.0),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.red,
//                               width: 1.3,
//                             ),
//                             borderRadius: BorderRadius.circular(16.0),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.red,
//                               width: 1.3,
//                             ),
//                             borderRadius: BorderRadius.circular(16.0),
//                           ),
//                           hintStyle:  TextStyles.font14LightGrayRegular,
//                           hintText: 'Search'.tr,
//                           suffixIcon: const Icon(
//                             Icons.search_sharp,
//                             color: ColorsManager.lightGray,
//                             size: 25,
//                           ),
//                           fillColor:  ColorsManager.moreLightGray,
//                           filled: true,
//                         ),
//                         obscureText:  false,
//                         style: TextStyles.font14DarkBlueMedium,
//                         validator: (value) {
//                         },
//                         onChanged: (searchText) {
//                           controller.setSearchText(searchText);
//                           // controllerData.addSearchProduct(searchText);
//                         },                            ),
//                     ),                  // Filter chips
//                     Wrap(
//                       spacing: 8.0,
//                       children: List<Widget>.generate(
//                         controller.categories.length,
//                             (int index) {
//                           return FilterChip(
//                             label: Text(controller.categories[index]),
//                             selected: controller.selectedCategories.contains(controller.categories[index]),
//                             onSelected: (bool selected) {
//                               controller.addRemoveCategory(controller.categories[index], selected);
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                     // BodyOffersScreen(items: state.displayedProducts,),
//                     Expanded(
//                       child: ListView.builder(
//                         itemBuilder: (context, index) {
//                           String? changeLang = context.read<OffersCubit>().displayedProducts[index].translations!.firstWhere(
//                                 (title) => title.locale!.endsWith(lang),
//                           ).title;
//                           DataProduct productItems = state.displayedProducts.data![index];
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             child: Column(
//                               children: [
//                                 InkWell(
//                                   onTap: () {},
//                                   child: SizedBox(
//                                     height: 110,
//                                     child: Row(
//                                       children: [
//                                         Stack(
//                                           alignment:
//                                           AlignmentDirectional.topStart,
//                                           children: [
//                                             ClipRRect(
//                                               borderRadius:
//                                               BorderRadius.circular(16),
//                                               child: AspectRatio(
//                                                 aspectRatio: 2.6 / 3,
//                                                 child: Container(
//                                                   color: Colors.grey[100],
//                                                   child: buildProductImage(
//                                                       state.displayedProducts.data![index]),
//                                                 ),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding:
//                                               EdgeInsets.only(right: 15.w),
//                                               child: const Image(
//                                                 image: AssetImage(
//                                                     'asstes/icons/special-png.png'),
//                                                 width: 80,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(
//                                           width: 15,
//                                         ),
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                             children: [
//                                               SizedBox(
//                                                 width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                     .5,
//                                                 child: Text( changeLang ??
//                                                     'No title',
//                                                     maxLines: 2,
//                                                     overflow:
//                                                     TextOverflow.ellipsis,
//                                                     style: TextStyles
//                                                         .font18BlackMedium),
//                                               ),
//                                               const SizedBox(
//                                                 height: 3,
//                                               ),
//                                               Text(
//                                                 'productItems.details!',
//                                                 style:
//                                                 TextStyles.font13GrayRegular,
//                                               ),
//                                               const SizedBox(
//                                                 height: 3,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 12.h,
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                         itemCount: context.read<OffersCubit>().displayedProducts.length,
//
//                       ),
//                     )
//                   ],
//                 )
//
//             );
//           } else if (state is OfferErrorState) {
//             // Handle error state
//             //
//             return state.error == 'defaultError'
//                 ? const LoadingCoustomAllView()
//                 : CustomErrorWidget(
//               errMessage: state.error,
//             );
//           }
//           return Container(
//             height: 40,
//           ); // Fallback
//         },
//       ),
//     );
//   }
//   Widget buildProductImage(DataProduct product) {
//     // Find the first image file that is an actual image (ignoring non-image files).
//
//     // String? imageUrl = product.files?.firstWhere(
//     //       (file) => file.image!.endsWith('.jpg') || file.image!.endsWith('.jpeg') || file.image!.endsWith('.png'),
//     //   orElse: () => null, // Use orElse to handle the case when no valid image is found.
//     //
//     // ).image;
//     String? imageUrl = product.files
//         ?.firstWhere(
//             (file) =>
//         file.image!.endsWith('.jpg') ||
//             file.image!.endsWith('.jpeg') ||
//             file.image!.endsWith('.png'),
//         orElse: () => Files(
//             fileType:
//             'asstes/images/2.jpg') // Use orElse to handle the case when no valid image is found.
//     )
//         .image;
//
//     // Check if an image URL was found and is not null.
//     if (imageUrl != null) {
//       // Complete the URL if necessary (if the stored URL is relative).
//       String fullImageUrl = 'http://app.misrgidda.com$imageUrl';
//
//       // Return an Image widget to display the image.
//       // return Image(image: NetworkImage(fullImageUrl),fit: BoxFit.cover,);
//       return CachedNetworkImage(
//         fit: BoxFit.fill,
//         imageUrl: fullImageUrl,
//         errorWidget: (context, url, error) => Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error, color: Colors.red),
//             Text('Failed to load image'),
//           ],
//         ),
//       );
//     }
//     return Image.asset('asstes/icons/Error.png');
//   }
//   void chooseName(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return SizedBox(
//           height: MediaQuery.sizeOf(context).height / 2,
//           child: Wrap(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: 30.h, right: 30, left: 30),
//                 child: Text(
//                   'Select country',
//                   style: TextStyles.font18BlackMedium,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 15),
//                 child: InkWell(
//                   onTap: () {
//                     showDialogCountry(context);
//                     on = true;
//                   },
//                   child: ListTile(
//                     leading: Icon(Icons.menu),
//                     title: Text('Select country'),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 30.h, right: 30, left: 30),
//                 child: Text(
//                   'Select City',
//                   style: TextStyles.font18BlackMedium,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 15),
//                 child: InkWell(
//                   onTap: () {
//                     on ? showDialogCity(context) : Center();
//                   },
//                   child: ListTile(
//                     leading: Icon(Icons.menu),
//                     title: Text('Select City'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   showDialogCountry(BuildContext context) {
//     showPlatformDialog(
//       context: context,
//       builder: (BuildContext context) => BasicDialogAlert(
//         title: const Text("Select Country"),
//         content: SizedBox(
//           height: 200,
//           width: MediaQuery.of(context).size.width,
//           child: ListView.builder(
//             itemCount: context.read<OffersCubit>().countryListCity.length,
//             itemBuilder: (BuildContext context, int index) {
//               CityListApi? country = context.read<OffersCubit>().countryListCity[index].cityListApi![index];
//
//               return CheckboxListTile(
//                 title: Text(
//                   controller.countryList[index].countryListApi![index].translations!.firstWhere(
//                         (title) => title.locale!.endsWith('ar'),
//                   ).title ?? 'ed',
//                   style: GoogleFonts.cairo(
//                     textStyle: TextStyles.font13DarkBlueRegular,
//                   ),
//                 ),
//                 value: controller.selectedCountry == country?.translations?[0]?.title,
//                 activeColor: ColorsManager.mainMauve,
//                 onChanged: (bool? value) {
//                   if (value == true) {
//                     controller.selectedCountry = country?.translations?[0]?.title ?? 'ellfm';
//                   } else {
//                     controller.selectedCountry = null; // Reset country selection
//                   }
//                   controller.selectedCity = null; // Reset city selection as well
//                   controller.updateDisplayedProducts(); // Update displayed products based on new filter
//                   Navigator.pop(context);
//
//                 },
//               );
//             },
//           ),
//         ),
//         actions: <Widget>[
//           BasicDialogAction(
//             title: Text("Cancel"),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   showDialogCity(BuildContext context) {
//     if (controller.selectedCountry != null) {
//       showPlatformDialog(
//         context: context,
//         builder: (BuildContext context) => BasicDialogAlert(
//           title: const Text("Select City"),
//           content: SizedBox(
//             height: 300,
//             width: MediaQuery.of(context).size.width,
//             child: ListView.builder(
//               itemCount: controller.selectedCountryCities.length,
//               itemBuilder: (BuildContext context, int index) {
//
//                 CountryListApi city = controller.countryList.firstWhere((country) => country.countryListApi![index].translations![index].title! == controller.selectedCountry).countryListApi![index]!;
//                 CityListApi cityData = city.cityListApi![index];
//
//                 return CheckboxListTile(
//                   title: Text(
//                     city.translations![index].title!,
//                     style: GoogleFonts.cairo(
//                       textStyle: TextStyles.font13DarkBlueRegular,
//                     ),
//                   ),
//                   value:  controller.selectedCity == city.translations![index].title!,
//                   activeColor: ColorsManager.mainMauve,
//                   onChanged: (bool? value) {
//                     controller.selectedCity = value! ? city.translations![index].title! : null;
//
//                     Navigator.of(context).pop();
//                     if (value == true) {
//                       controller.selectedCityProducts.add(cityData.items![index]!);
//                       Navigator.pop(context);
//                     } else {
//                       controller.selectedCityProducts.remove(cityData);
//                       Navigator.pop(context);
//                       // controllerData.selectedOptionValue(value);
//                     }
//                     controller.setSelectedCity(city.translations![index].title!);
//
//                   },
//                 );
//               },
//             ),
//           ),
//           actions: <Widget>[
//             BasicDialogAction(
//               title: Text("Cancel"),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
// }