import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:all_one/features/home/data/model/product_offer.dart';
import 'package:all_one/features/home/logic/home_cubit.dart';
import 'package:all_one/features/home/logic/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/helper/loction_map.dart';
import '../../data/model/model.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:screenshot/screenshot.dart';

import '../../data/model/model_products.dart';

class GoogleMapScreen extends StatefulWidget {

   GoogleMapScreen({super.key,required this.dataProduct});

   ProductOffers? dataProduct;

  @override
  State<GoogleMapScreen> createState() => GoogleMapScreenState();
}

class GoogleMapScreenState extends State<GoogleMapScreen> {

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final Set<Marker> markers = Set();
  static Position? position;
  final ScreenshotController _screenshotController = ScreenshotController();

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  getBytesFromNetworkImage(String url, int width) async {
    final cacheManager = DefaultCacheManager();
    try {
      final file = await cacheManager.getSingleFile(url);

      if (file == null || !file.existsSync()) {
        print('Image file does not exist.');
        return null;
      }

      final ByteData data = await file.readAsBytes().then((byteList) =>
          ByteData.sublistView(
              Uint8List.fromList(byteList).buffer.asByteData()));
      final ui.Codec codec = await ui
          .instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
      final ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
          .buffer
          .asUint8List();
    } catch (e) {
      print('Error loading network image: $e');
      return null;
    }
  }

  Future<Marker> createCustomMarker(String markerId, LatLng position) async {
    final Uint8List markerIcon =
        await getBytesFromAsset('asstes/images/2.jpg', 100);
    final Uint8List markerIcons = await getBytesFromNetworkImage(
        'https://img.freepik.com/premium-photo/hamburger-with-lettuce-tomato-cheese-it_667286-3180.jpg?w=740',
        100);

    return Marker(
      markerId: MarkerId(markerId),
      position: position,
      icon: BitmapDescriptor.fromBytes(markerIcon!),
    );
  }

  FloatingSearchBarController controller = FloatingSearchBarController();
  var progressIndicator = false;
  var isTimeAndDistanceVisible = false;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(position!.latitude, position!.longitude),
    zoom: 8.4746,
  );
//    target: LatLng(25.16371532, 55.17464960),
  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation()
        .whenComplete(() => setState(() {})) ;
  }



  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      controller: controller,
      elevation: 6,
      hintStyle: TextStyle(fontSize: 18),
      queryStyle: TextStyle(fontSize: 18),
      hint: 'Find a place..',
      border: BorderSide(style: BorderStyle.none),
      margins: EdgeInsets.fromLTRB(20, 70, 20, 0),
      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
      height: 52,
      iconColor: Colors.blue,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 600),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      progress: progressIndicator,
      onQueryChanged: (query) {
        // getPlacesSuggestions(query);
      },
      onFocusChanged: (_) {
        // hide distance and time row
        setState(() {
          isTimeAndDistanceVisible = false;
        });
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
              icon: Icon(Icons.place, color: Colors.black.withOpacity(0.6)),
              onPressed: () {}),
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // buildSuggestionsBloc(),
              // buildSelectedPlaceLocationBloc(),
              // buildDiretionsBloc(),
            ],
          ),
        );
      },
    );
  }

  // Future<void> goToMySearchedForLocation() async {
  //   buildCameraNewPosition();
  //   final GoogleMapController controller = await _mapController.future;
  //   controller
  //       .animateCamera(CameraUpdate.newCameraPosition(goToSearchedForPlace));
  //   buildSearchedPlaceMarker();
  // }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  @override
  void initState() {
    getMyCurrentLocation();
    _addMarkers();
    super.initState();
  }

  Future<void> _loadMarker() async {
    Marker customMarker = await createCustomMarker(
        'markerId1', LatLng(markerTest[0].lati!, markerTest[0].lang!));
    setState(() {
      markers.add(customMarker);
    });
  }
  Future<void> _loadMarkers() async {
    final BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(10, 10)), // Size of the custom icon
      'asstes/images/2.jpg', // Asset path to the custom icon
    );

    // Create a marker with a custom icon
    Marker customMarker = Marker(
      markerId: MarkerId('customMarker'),
      position: LatLng(37.42796133580664, -122.085749655962),
      icon: customIcon,
    );

    setState(() {
      markers.add(customMarker);
    });
  }

  Future<void> _addMarkers() async {
    for(DataProduct obj in widget.dataProduct!.data!)

      {
        String? imageUrl = obj.files
            ?.firstWhere(
                (file) =>
            file.image!.endsWith('.jpg') ||
                file.image!.endsWith('.jpeg') ||
                file.image!.endsWith('.png'),
            orElse: () => Files(
                fileType:
                'asstes/images/2.jpg') // Use orElse to handle the case when no valid image is found.
        )
            .image;
        for(Files files in obj.files!)
          {
            for(TranslationsProduct tran in obj.translations!)
            {
              final customMarkerBytes = await _convertWidgetToBytes(imageUrl);
              final customMarkerIcon = BitmapDescriptor.fromBytes(customMarkerBytes!);
              markers.add(Marker(
                markerId: MarkerId(tran.title!),
                position: LatLng(obj.maxCount!, obj.price!),
                infoWindow: InfoWindow(
                  title: tran.title!,),
                icon: customMarkerIcon,
              ),);

              setState(() {});
            }

          }
      }

    getMyCurrentLocation();
  }


  Widget _customMarkerWidget(url) {
    return SizedBox(
      width: 50,
      height: 50,
      child: ClipRRect(
        borderRadius:
        BorderRadius.circular(20),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            color: Colors.grey[100],
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage(url)
            ),
          ),
        ),
      ),
    );
  }

  Future _convertWidgetToBytes(url) async {

    String fullImageUrl = 'http://app.misrgidda.com$url';

    final imageBytes = await _screenshotController.captureFromLongWidget(
      _customMarkerWidget(fullImageUrl),
    );
    return imageBytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          position != null
              ? GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: _kGooglePlex,
                  markers: markers,
                )
              : Center(
                  child: Container(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
