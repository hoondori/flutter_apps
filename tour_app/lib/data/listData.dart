import 'package:flutter/material.dart';

// 사용자가 화면상에서 지역을 선택해서 검색할 수 있도록
class Item {
  String title;
  int value;
  Item(this.title, this.value);
}

class Area {
  List<DropdownMenuItem<Item>> seoulArea = List.empty(growable: true);

  Area() {
    seoulArea.add(DropdownMenuItem(
        child: Text('강남구'),
        value: Item('강남구', 1)
    ));
    seoulArea.add(DropdownMenuItem(
        child: Text('강동구'),
        value: Item('강동구', 2)
    ));
    seoulArea.add(DropdownMenuItem(
        child: Text('광진구'),
        value: Item('광진구', 6)
    ));
  }
}

 class Kind {
   List<DropdownMenuItem<Item>> kinds = List.empty(growable: true);

   // 12:관광지, 14:문화시설, 15:축제공연행사, 25:여행코스, 28:레포츠, 32:숙박, 38:쇼핑, 39:음식점
   Kind() {
     kinds.add(DropdownMenuItem(
         child: Text('관광지'),
         value: Item('관광지', 12)
     ));
     kinds.add(DropdownMenuItem(
         child: Text('문화시설'),
         value: Item('문화시설', 14)
     ));
   }
 }