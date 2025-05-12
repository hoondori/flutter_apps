import 'package:bamtol_market_app/common/components/app_font.dart';
import 'package:bamtol_market_app/common/components/btn.dart';
import 'package:bamtol_market_app/common/components/place_name_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class TradeLocationMap extends StatefulWidget {
  final String? label;
  final LatLng? location;
  const TradeLocationMap({
    super.key,
    this.label,
    this.location
  });

  @override
  State<TradeLocationMap> createState() => _TradeLocationMapState();
}

class _TradeLocationMapState extends State<TradeLocationMap> {

  final _mapController = MapController();
  String label = '';
  LatLng? location;

  @override
  void initState() {
    super.initState();
    label = widget.label ?? '';
    location = widget.location;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // emulator에서는 permission 체크시 hang이 발생해서 가짜 위치 전송
    Position fakePosition = Position(
      latitude: 37.5665, // 예: 서울
      longitude: 126.9780,
      timestamp: DateTime.now(),
      accuracy: 5.0,
      altitude: 35.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
      headingAccuracy: 1.0,
      altitudeAccuracy: 1.0,
    );
    return fakePosition;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled) {
      return Future.error('위치 서비스 비활성화');
    }
    try {
      permission = await Geolocator.checkPermission()
          .timeout(Duration(seconds: 5));  // 5초 안에 응답 없으면 예외 발생
      print('Permission: $permission');
    } catch (e) {
      return Future.error('위치 권한 확인 불가능');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('위치 권한이 거부되었습니다');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('위치 권한이 영구적으로 거부되었습니다');
    }

    return await Geolocator.getCurrentPosition();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212123),
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset("assets/svg/icons/back.svg"),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppFont(
                  '이웃과 만나서\n직거래하고 싶은 장소를 선택해주세요',
                  fontWeight: FontWeight.bold,
                  size: 16,
                ),
                SizedBox(height: 15,),
                AppFont(
                  '만나서 거래할 때는 누구나 찾기 쉬운 공공장소가 좋아요.',
                  fontWeight: FontWeight.bold,
                  size: 13,
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<Position>(
              future: _determinePosition(),
              builder: (context, snapshot){
                if (snapshot.hasData) {
                  var myLocation = LatLng(snapshot.data!.latitude, snapshot.data!.longitude);

                  // 초기 위치값이 있으면 현재 위치를 여기로 변경
                  if (location != null) {
                    myLocation = location!;
                  }

                  return FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      center: myLocation,
                      interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                      onPositionChanged: (position, hasGesture) {
                        setState(() {
                          label = '';   // 위치 변경시 기존 label 무효화
                        });
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      ),
                    ],
                    nonRotatedChildren: [
                    if (label != '')
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Color.fromARGB(255, 208, 208, 208),
                              ),
                              child: AppFont(
                                label,
                                color: Colors.black,
                                size: 12,
                              ),
                            ),
                            const SizedBox(height: 100)
                          ],
                        ),
                      ),
                      Center(
                        child: SvgPicture.asset(
                          'assets/svg/icons/want_location_marker.svg',
                          width: 45,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: Get.mediaQuery.padding.bottom
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Btn(
                                onTap: () async {
                                  var result = await Get.dialog<String>(
                                    useSafeArea: false,
                                    PlaceNamePopup(),
                                  );
                                  Get.back(result: {
                                    'label': result,
                                    'location': _mapController.center,
                                  });
                                },
                                child: const AppFont('선택 완료', align: TextAlign.center,),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 1,),
                );
              },
            )
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: Get.mediaQuery.padding.bottom +30),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xff212123),
          child: Icon(Icons.location_searching),
        ),
      ),
    );
  }
}

class SimpleTradeLocationMap extends StatelessWidget {
  final String? label;
  final LatLng myLocation;
  final int interactiveFlags;

  const SimpleTradeLocationMap({
    super.key,
    required this.myLocation,
    this.label,
    this.interactiveFlags = InteractiveFlag.pinchZoom | InteractiveFlag.drag,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: myLocation,
        interactiveFlags: interactiveFlags,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
      ],
      nonRotatedChildren: [
        if(label != '')
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: const Color.fromARGB(255, 208, 208, 208),
                  ),
                  child: AppFont(
                    label!,
                    color: Colors.black,
                    size: 12,
                  )
                ),
                const SizedBox(height: 100,)
              ],
            ),
          ),
        Center(
          child: SvgPicture.asset(
            'assets/svg/icons/want_location_marker.svg',
            width: 45,
          ),
        )
      ],
    );
  }
}
