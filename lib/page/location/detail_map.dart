import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ummaku/controllers/location_controller.dart';
import 'package:ummaku/widget/product_card.dart';

class DetailMapsPage extends StatelessWidget {
  const DetailMapsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(LocationController());
    final theme = Theme.of(context);
    return Scaffold(
      body: GetBuilder<LocationController>(
          init: LocationController(),
          builder: (controller) {
            return Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        GoogleMap(
                          markers: Set<Marker>.of(controller.markers.values),
                          onMapCreated: (controllers) {
                            if (Get.isDarkMode) {
                              controllers.setMapStyle(Utils.darkMode);
                            } else {
                              controllers.setMapStyle(Utils.mapStyles);
                            }

                            // if (productController.controller.isCompleted) {
                            //   print('----------------------');
                            // } else {
                            productController.controller.complete(controllers);
                            // }
                          },
                          initialCameraPosition: CameraPosition(
                            target: LatLng(controller.locationStatus.lat,
                                controller.locationStatus.lng),
                            zoom: controller.zoomMapByRadius(
                              controller.maxRadius,
                            ),
                          ),
                          circles: {
                            Circle(
                                circleId: const CircleId("MyCircle"),
                                center: LatLng(controller.locationStatus.lat,
                                    controller.locationStatus.lng),
                                visible: false,
                                radius: controller.maxRadius * 1000.0)
                          },
                        ),
                        Positioned(
                            top: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width - 40,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: theme.backgroundColor),
                                child: Row(
                                  children: [
                                    Text(
                                      'Cari Lokasi',
                                      style: theme.textTheme.caption,
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.search),
                                  ],
                                ),
                              ),
                            )),
                        // ),
                        Positioned(
                          bottom: 20,
                          child: Container(
                            height: 220,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(16),
                            child: PageView.builder(
                              controller: controller.contr,
                              itemCount: controller.listProd.length,
                              onPageChanged: (e) {
                                double lat = controller.listProd[e].lat!;
                                double lng = controller.listProd[e].lng!;
                                double prevLat = 0.0;
                                double prevLng = 0.0;
                                if (controller.previousMarker! != null) {
                                  prevLat = controller
                                      .listProd[int.parse(
                                          controller.previousMarker!.value)]
                                      .lat!;
                                  prevLng = controller
                                      .listProd[int.parse(
                                          controller.previousMarker!.value)]
                                      .lng!;
                                } else {
                                  prevLat = controller.listProd[0].lat!;
                                  prevLng = controller.listProd[0].lng!;
                                  controller.previousMarker =
                                      const MarkerId('0');
                                }
                                controller.currentMarkerSelected = e;
                                controller.gotolocation(lat, lng);
                                // bloc.setData(index, lat, lng);
                                controller.highlightMaker(MarkerId('$e'), e,
                                    prevLat, prevLng, lat, lng);
                              },
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) => ProductLocationCard(
                                product: controller.listProd[i],
                                i: i,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 8),
                  // _renderListControl(),
                  // isactive
                  //     ? _renderSliderRadius(bloc.param[Params.maxRadius])
                  //     : SizedBox(),

                  // _mapStateForCarCard(state)
                ],
              ),
            );
          }),
    );
  }
}

class Utils {
  static String mapStyles = '''[
  {
    "featureType": "landscape",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f0f0f0"
      }
    ]
  },
  {
    "featureType": "poi.business",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#a8f1ff"
      }
    ]
  }
]''';

  static String darkMode = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#181818"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1b1b1b"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#2c2c2c"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8a8a8a"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#373737"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3c3c3c"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#4e4e4e"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#000000"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3d3d3d"
      }
    ]
  }
]''';
}
