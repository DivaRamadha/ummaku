import 'dart:async';
import 'dart:typed_data';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ummaku/model/current_location.dart';
import 'package:ummaku/model/product_model.dart';
import 'dart:ui' as ui;

import 'package:ummaku/style/color.dart';

class LocationController extends GetxController {
  Position? _currentPosition;
  bool test = false;
  String? _address;
  // Location location = Location();
  MarkerId? previousMarker;
  double maxRadius = 10;
  CurrentLocationStatus locationStatus = CurrentLocationStatus();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  PageController contr = PageController();
  int currentMarkerSelected = 0;

  Completer<GoogleMapController> controller = Completer();
  List<Product> listProd = [];

  Position get posisi => _currentPosition!;
  String get alamat => _address!;
  Map<MarkerId, Marker> get mark => markers;

  @override
  void onInit() {
    super.onInit();
    getDataproduk(listProduct, 0);
  }

  getDataproduk(List<Product> data, int from) {
    listProd = data;
    for (var i = 0; i < data.length; i++) {
      Product p = data[i];
      double lat = p.lat!;
      double lng = p.lng!;
      int size = i == 0 ? 90 : 50;
      Color color = i == 0 ? primaryColor : secondaryColor;
      if (p.lat != null) {
        if (i == 0) {
          if (from == 1) {
            locationStatus.lat = p.lat!;
            locationStatus.lng = p.lng!;
          }
        }
      }
      setnewmark(i, lat, lng, size, color, i == 0 ? 99.0 : 0.0, false);
    }
    update();
  }

  // getLoc() async {
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;

  //   _serviceEnabled = await location.serviceEnabled();
  //   if (_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (_serviceEnabled) {
  //       return;
  //     }
  //   }

  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted = PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   _currentPosition = await location.getLocation();

  //   location.onLocationChanged.listen((LocationData currentLocation) {
  //     _currentPosition = currentLocation;
  //     locationStatus.lat = _currentPosition.latitude;
  //     locationStatus.lng = _currentPosition.longitude;

  //     // DateTime now = DateTime.now();
  //     // _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
  //     // _getAddress(_currentPosition.latitude, _currentPosition.longitude)
  //     //     .then((value) {
  //     //   _address = "${value.first.addressLine}";
  //     // });
  //   });
  // }

  void getLocationFromloc() async {
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (_currentPosition != null) {
      locationStatus.lat = _currentPosition!.latitude;
      locationStatus.lng = _currentPosition!.longitude;
    }
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  setnewmark(int i, double lat, double lng, int size, Color color, double ind,
      bool from) async {
    String id = '$i';
    final MarkerId markerId = MarkerId(id);
    BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;

    // final Uint8List markerIcon = await getBytesFromCanvas(size, size, i, color);
    Uint8List markerIcon;
    ByteData imageData = ByteData(0);
    getBytesFromAsset(
            i == 0
                ? 'assets/image/pin-light-active.png'
                : 'assets/image/pin-light-inactive.png',
            i == 0 ? 60 : 40)
        .then((value) {
      sourceIcon = BitmapDescriptor.fromBytes(value);
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(lat, lng),
        zIndex: ind,
        icon: sourceIcon,
        onTap: () {
          // stateSink.add(SuccessGetCarInRangeLocationState(listCarData,
          contr.jumpToPage(i);
          update();
        },
      );
      markers[markerId] = marker;
    });
    markerIcon = imageData.buffer.asUint8List();

    // });

    // loadPage = false;
    // if (from == true) {
    //   stateSink.add(SuccessGetCarInRangeLocationState(listCarData));
    // } else {
    //   stateSink.add(SuccessGetCarInRangeLocationState(listCarData));
    // }
    update();
  }

  Future<void> gotolocation(double lat, double long) async {
    final GoogleMapController controllers = await controller.future;
    controllers.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }

  void highlightMaker(
    MarkerId markerId,
    int i,
    double prevlat,
    double prevlng,
    double lat,
    double lng,
  ) async {
    // select marker by id
    final Marker? marker = markers[markerId];

    BitmapDescriptor sourceIcon;
    BitmapDescriptor destinationIcon;
    // ignore: unnecessary_null_comparison
    if (marker != null) {
      if (previousMarker != null) {
        getBytesFromAsset('assets/image/pin-light-inactive.png', 40)
            .then((value) {
          destinationIcon = BitmapDescriptor.fromBytes(value);
          final Marker reset = Marker(
              onTap: () {
                contr.jumpToPage(int.parse(previousMarker!.value));
                update();
                // stateSink.add(SuccessGetCarInRangeLocationState(listCarData,
                //     isMarkerHasTapped: true,
                //     position: int.parse(previousMarker.value)));
              },
              anchor: const Offset(0.5, 0.5),
              //  visible: false,
              zIndex: 0.0,
              markerId: MarkerId(previousMarker!.value),
              position: LatLng(prevlat, prevlng),
              icon: destinationIcon);
          markers[previousMarker!] = reset;
          update();
        });
      }
      getBytesFromAsset('assets/image/pin-light-active.png', 60).then((value) {
        sourceIcon = BitmapDescriptor.fromBytes(value);

        final Marker newMarker = Marker(
            onTap: () {
              contr.jumpToPage(int.parse(previousMarker!.value));
              update();
              // stateSink.add(SuccessGetCarInRangeLocationState(listCarData,
              //     isMarkerHasTapped: true,
              //     position: int.parse(previousMarker.value)));
            },
            anchor: const Offset(0.5, 0.5),
            //  visible: false,
            // infoWindow: InfoWindow(
            //   title: '${listCarData[i].}'
            // ),
            zIndex: 99.0,
            markerId: markerId,
            position: LatLng(lat, lng),
            icon: sourceIcon);
        markers[markerId] = newMarker;
        previousMarker = newMarker.markerId;
        update();
      });

      // zoom in to the selected camera position
      update();
    }
    // stateSink.add(SuccessGetCarInRangeLocationState(listCarData));
  }

  Future<Uint8List> getBytesFromCanvas(
      int width, int height, int i, Color colors) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = colors;
    final Radius radius = Radius.circular(width / 2);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, width.toDouble(), height.toDouble()),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        paint);
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: "${i + 1}",
      style: const TextStyle(fontSize: 25.0, color: Colors.white),
    );
    painter.layout();
    painter.paint(
        canvas,
        Offset((width * 0.5) - painter.width * 0.5,
            (height * .5) - painter.height * 0.5));
    final img = await pictureRecorder.endRecording().toImage(width, height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  double zoomMapByRadius(double radius) {
    double rad = radius == 0.0 ? 10.0 : radius;
    double scale = (rad * 1000.0) / 500.0;
    double zoomLevel = (16 - math.log(scale) / math.log(2));

    return zoomLevel;
  }
}
