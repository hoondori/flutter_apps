import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tour_app/data/tour.dart';


class TourDetailPage extends StatefulWidget {
  TourDetailPage({super.key, this.tourData});

  final TourData? tourData;

  @override
  State<TourDetailPage> createState() => _TourDetailPageState();
}

class _TourDetailPageState extends State<TourDetailPage> {
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  CameraPosition? _googleMapCamera;
  Marker? _marker;

  @override
  void initState() {
    super.initState();

    // 보여주는 지도 위치
    _googleMapCamera = CameraPosition(
      target: LatLng(
          double.parse(widget.tourData!.mapy.toString()),
          double.parse(widget.tourData!.mapx.toString())
      ),
      zoom: 18,
    );
    // 마커 위치
    MarkerId markerId = MarkerId(widget.tourData.hashCode.toString());
    _marker = Marker(
      position: LatLng(
        double.parse(widget.tourData!.mapy.toString()),
        double.parse(widget.tourData!.mapx.toString())
      ),
      flat: true,
      markerId: markerId
    );
    _markers[markerId] = _marker!;
  }

  ImageProvider _getImage(String? imagePath) {
    if (imagePath != null && imagePath != '') {
      return NetworkImage(imagePath);
    } else {
      // 기본 이미지
      return AssetImage('assets/images/map_location.jpg');
    }
  }

  Widget _getGoogleMap() {
    return SizedBox(
      height: 400,
      width: MediaQuery.of(context).size.width - 50,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _googleMapCamera!,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(_markers.values),
      )
    );
  }

  Widget _showDetailInfo() {
    return Container(
      child: Center(
        child: Column(
            children: [
              Hero(
                tag: 'tag',
                child: Container(
                  width: 300.0,
                  height: 300.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: _getImage(widget.tourData!.imagePath))
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:20, bottom: 20,),
                child: Text(
                  widget.tourData!.address!,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              _getGoogleMap()
            ]
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('${widget.tourData!.title}', style: TextStyle(color: Colors.white, fontSize: 40),),
              centerTitle: true,
              titlePadding: EdgeInsets.only(top:10)
            ),
            pinned: true,
            backgroundColor: Colors.deepOrangeAccent,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 20,),
              _showDetailInfo(),
            ]),
          )
        ],
      ),
    );
  }
}
