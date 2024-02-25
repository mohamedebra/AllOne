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
import '../../../../core/helper/loction_map.dart';
import '../../data/model/model.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:screenshot/screenshot.dart';


class GoogleMapScreen extends StatefulWidget {

   GoogleMapScreen({super.key,required this.dataProduct});

   List<DataProduct>? dataProduct;

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

  // Future<void> _loadMarker() async {
  //   Marker customMarker = await createCustomMarker(
  //       'markerId1', LatLng(markerTest[0].lati!, markerTest[0].lang!));
  //   setState(() {
  //     markers.add(customMarker);
  //   });
  // }
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
    for(DataProduct obj in widget.dataProduct!!)

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
