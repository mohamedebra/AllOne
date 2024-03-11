import 'dart:async';
import 'dart:typed_data';

import 'package:all_one/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/services.dart' show PlatformException, rootBundle;
import '../../../../core/helper/loction_map.dart';
import '../../data/model/product_offer.dart';

class GoogleMapsProduct extends StatefulWidget {
 final DataProduct dataProduct;
  const GoogleMapsProduct({super.key,required this.dataProduct});

  @override
  State<GoogleMapsProduct> createState() => _GoogleMapsProductState();
}

class _GoogleMapsProductState extends State<GoogleMapsProduct> {
  static Position? position;
  final Set<Marker> markers = Set();
  Map<PolylineId,Polyline> polylines ={};
  List<LatLng> poyLineCoordinates=[];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleApiKey = 'AIzaSyDVQ7GtqOSMNW-72uDJDbqDj3U-gQwwnWE';
  StreamSubscription? subscription ;
  Location liveLocation = Location();

  final ScreenshotController _screenshotController = ScreenshotController();
   GoogleMapController? _controller;
   Completer<GoogleMapController> googleMapController = Completer();
   LocationData? currentLocation;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(position!.latitude, position!.longitude),
    zoom: 8.4746,
  );

  Future<Uint8List> getMarker()async{
    ByteData byteData = await rootBundle.load('asstes/icons/Error.png');
        return byteData.buffer.asUint8List();
  }


  Future<void> getMyCurrentLocation () async {
    // position = await LocationHelper.getCurrentLocation()
    //     .whenComplete(() => setState(() {})) ;
    // print('longitude ${position!.longitude}');
    // print('latitude ${position!.latitude}');
    // // positionStream  = Geolocator.getPositionStream().listen(
    // //         (Position? position) {
    // //           changeMarker(position!.latitude,position.longitude);
    // //         });
    try{
      Uint8List imageData = await getMarker();
      var location = await liveLocation.getLocation().then((value) {
        currentLocation = value;
      });

      if(subscription != null){
        subscription!.cancel();
      }
      subscription = liveLocation!.onLocationChanged.listen((locationData) {
       var nawLatLng = LatLng(locationData.latitude!, locationData.longitude!);
        _controller?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: nawLatLng,
          zoom: 18),
        ));
       updateLocation(imageData,locationData);

      });
      updateLocation(imageData,location);
    }
    on PlatformException catch(e){
      print(e.message);
    }

  }

  void getCurrentLocation() async {
    Location location = Location();
    // Ensure the location service is enabled and permission granted before proceeding.
    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) return; // Exit if service not enabled after request
    }

    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return; // Exit if permission not granted
    }

    try {
      GoogleMapController googleMapController = await _controller!;
      location.getLocation().then((location) {
        if (location.latitude != null && location.longitude != null) {
          // Update your currentLocation state variable before calling setState
          setState(() {
            // Assuming currentLocation is a class variable that you want to update.
            currentLocation = location;
          });
          googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 13.5,
                target: LatLng(location.latitude!, location.longitude!),
              ),
            ),
          );
        }
      });

      location.onLocationChanged.listen((location) {
        if (location.latitude != null && location.longitude != null) {
          setState(() {
            // Update the state with the new location
            currentLocation = location;
          });
        }
      });
    } catch (e) {
      // Handle errors related to Google Map Controller or Location Services
      print(e);
    }
  }
  void getCurrentLocationPosition() async {
    position = await LocationHelper.getCurrentLocation()
        .whenComplete(() => setState(() {})) ;
    GoogleMapController? controller = await googleMapController.future;

    subscription = Geolocator.getPositionStream().listen((newPosition) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 18,
            target: LatLng(newPosition!.latitude!, newPosition!.longitude!),
          ),
        ),
      );
    });
    getPolyline(position,widget.dataProduct);

  }

  updateLocation(Uint8List imageData, LocationData locationData){
    LatLng latLng = LatLng(locationData.latitude!, locationData.longitude!);
    markers.add(Marker(
        markerId: MarkerId('me'),
      position: latLng,
      icon: BitmapDescriptor.fromBytes(imageData),
      flat: true,
      draggable: false,
      rotation: locationData.heading!
    ));
      
  }
  changeMarker(newlat,newlong){
    markers.remove(Marker(markerId: MarkerId('value')));
    markers.add(Marker(markerId: MarkerId('value'),position: LatLng(newlat, newlong)));

    setState(() {

    });
  }



  Future<void> _addMarkers() async {

    String? imageUrl = widget.dataProduct.files
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
    final customMarkerBytes = await _convertWidgetToBytes(imageUrl);
    final customMarkerIcon = BitmapDescriptor.fromBytes(customMarkerBytes!);
    markers.add(Marker(
      markerId: MarkerId(widget.dataProduct.title!),
      position: LatLng(widget.dataProduct.maxCount!, widget.dataProduct.price!),
      infoWindow: InfoWindow(
        title: widget.dataProduct.title!,),
      icon: customMarkerIcon,
    ),);
    markers.add(Marker(
        markerId: MarkerId('me'),
        position: LatLng(
            position!.latitude!,
            position!.longitude!
        )
    ));

    setState(() {});
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
  void initState() {
    getCurrentLocationPosition();
    // getPolyline();
    _addMarkers();
    super.initState();
  }
  LatLng meLocatin = LatLng(30.806514,31.325503 );
  // LatLng goLocatin = LatLng(30.806569, 31.323584);

  getPolyline(position,DataProduct product) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(position!.latitude, position!.longitude),
      PointLatLng(product.maxCount!, product.price!),
      travelMode: TravelMode.driving,

      // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
    );
    if (result.status == 'ZERO_RESULTS') {
      // Handle the case where no route was found
      print('///////////////////////////////////////////////////////////////////////No route available between these two points.');
    } else {
      // Process the route as normal
    }
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        poyLineCoordinates.add(LatLng(point.latitude, point.longitude));
        // poyLineCoordinates.add(LatLng(goLocatin.latitude!, goLocatin.longitude));
      });
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          position == null ? Center(child: CircularProgressIndicator(),) :          GoogleMap(
            polylines: {
              Polyline(polylineId: PolylineId('poly'),
                  points: poyLineCoordinates,
                  color: ColorsManager.mainMauve,
                  width: 4)
            },
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(target: LatLng(position!.latitude!,position!.longitude! ),zoom: 18),
            markers: markers,
            onMapCreated: (controller ){
              googleMapController.complete(controller);
            },
          )

        ],
      ),
    );
  }

  @override
  void dispose() {
    subscription!.cancel();
   super.dispose();
  }
}
