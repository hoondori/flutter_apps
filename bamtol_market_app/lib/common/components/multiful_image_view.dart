
import 'package:bamtol_market_app/common/components/app_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter/foundation.dart';

class MultifulImageView extends StatefulWidget {
  final List<AssetEntity>? initImages;
  const MultifulImageView({
    super.key,
    this.initImages,
  });

  @override
  State<MultifulImageView> createState() => _MultifulImageViewState();
}

class _MultifulImageViewState extends State<MultifulImageView> {

  var albums = <AssetPathEntity>[];

  // 로딩된 이미지들
  int currentPage = 0;
  int lastPage = -1;
  var imageList = <AssetEntity>[];

  // 선택된 이미지들
  var selectedImages = <AssetEntity>[];

  // scroll
  var scrollController = ScrollController();



  @override
  void initState() {
    super.initState();
    loadMyPhotos();
    scrollController.addListener((){
      var maxScroll = scrollController.position.maxScrollExtent;
      var currentScroll = scrollController.offset;
      if (currentScroll > maxScroll - 150 && currentPage != lastPage) {
        // 아래로 당기면서 마지막 페이지가 아니면
        lastPage  = currentPage;
        _pagingPhotos();
      }
    });
    if (widget.initImages != null) {
      // 이전에 선택된 이미지를 추가
      selectedImages.addAll([... widget.initImages!]);
    }
  }

  void loadMyPhotos() async {
    var permissionState = await PhotoManager.requestPermissionExtend();

    if (!permissionState.hasAccess) {
      print("갤러리 접근 권한이 없습니다.");
      return;
    }

    if (permissionState == PermissionState.limited ||
        permissionState == PermissionState.authorized) {
      albums = await PhotoManager.getAssetPathList(
          type: RequestType.image,
          filterOption: FilterOptionGroup(
            imageOption: const FilterOption(
              needTitle: true,
              sizeConstraint: SizeConstraint(
                minWidth: 800,
                minHeight: 800
            )),
            orders: [
              const OrderOption(type: OrderOptionType.createDate, asc: false)
            ]
          ),
      );
      _pagingPhotos(); // render albums in UI
    }
  }


  Future<void> _pagingPhotos() async {
    if (albums.isNotEmpty) {
      var photos =
          await albums.first.getAssetListPaged(
              page: currentPage, size: 60);
      print("number of photo: ${photos.length}");

      if (photos.isEmpty) {
        return;
      }

      if (currentPage == 0) {
        imageList.clear();
      }

      setState(() {
        imageList.addAll(photos);
        currentPage++;
      });
    } else {
      print("album is empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppFont(
          '최근 항목',
          fontWeight:
          FontWeight.bold,
          size: 18,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.back(result: selectedImages);
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 20.0, right: 25),
              child: AppFont(
                '완료',
                color: Color(0xffED7738),
                size: 16,
                fontWeight: FontWeight.bold,
              )
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              controller: scrollController,
              itemCount: imageList.length,
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1
              ),
              itemBuilder: (BuildContext context, int index) {
                return _photoWidget(imageList[index]);
              },
            )
          )
        ],
      ),
    );
  }

  // 선택된 이미지 여부
  bool containValue(AssetEntity value) {
    return selectedImages.where((e) => e.id == value.id).isNotEmpty;
  }


  // 선택된 이미지 내에서의 순번
  String returnIndexValue(AssetEntity value) {
    var find = selectedImages.asMap().entries.where((element) {
      return element.value.id == value.id;
    });

    if (find.isEmpty) return '';
    return (find.first.key + 1).toString();
  }

  void _selectedImage(AssetEntity value) async {
    // 기 선택된 이미지는 해제, 아니라면 최대 10개까지 선택
    setState(() {
      if (containValue(value)) {
        selectedImages.remove(value);
      } else {
        if (10 > selectedImages.length) {
          selectedImages.add(value);
        }
      }
    });
  }

  Widget _photoWidget(AssetEntity asset) {
    return FutureBuilder<Uint8List?>(
      future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
      builder: (_, snapshot) {
        if (snapshot.hasData) {

          return Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.memory(snapshot.data!, fit: BoxFit.cover,)
              ),
              Positioned(left:0, bottom: 0, right: 0, top: 0, // 이미지 전체 위에 선택시 불투명 부여
                child: Stack(
                  children: [
                    Positioned(left:0, bottom: 0, right: 0, top: 0,
                      child: Container(
                        color: Colors.white.withValues(alpha: containValue(asset) ? 0.5 : 0),
                      ),
                    ),
                    Positioned(top: 0, right: 0, // 이미지 우상단
                      child: GestureDetector(
                        onTap: () {
                          // 우상단 클릭시 이미지 선택
                          _selectedImage(asset);
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Container(  // 우상단에 선택 순번 표시
                          margin: const EdgeInsets.all(10),
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: containValue(asset)
                                ? Color(0xffED7738)
                                : Colors.white.withValues(alpha: 0.5),
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: Center(
                            child: Text(
                              returnIndexValue(asset),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ))
                  ],
                ),
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
