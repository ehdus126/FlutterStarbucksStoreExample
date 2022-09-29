import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SirenOrderStoreListReq {
  AppVo app = AppVo();

  SirenOrderStoreListReq({
    required this.app
  });

  SirenOrderStoreListReq.fromJson(Map<String, dynamic> json) {
    app = json[app];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app'] = this.app;
    return data;
  }
}

class AppVo {
  String? gbn;                // 구분
  String? fullInquiryYn;      // 젼체 매장 조회 여부
  String? stockCheckYn;       // 재고 체크 여부
  String? latitude;           // 위도
  String? longitude;          // 경도
  String? keyword;            // 매장명 검색 키워드
  String? shortcut;           // 검색 숏컷
  String? cartNo;             // 주문서 일렬번호
  String? page;               // 조회 페이지 번호
  String? searchLatitude;     // 검색 기준 위치 정보 - 위도
  String? searchLongitude;    // 검색 기준 위치 정보 - 경도
  String? skuNo;              // SKU 코드
  String? beaconStoreCode;    // 비콘으로 저장된 매장 코드
  String? giftType;           // 선물 구분
  String? distanceCheckOnlyYn;// 거리 체크만 제한 처리 여부
  String? orderNo;            // 예약 번호
  String? receiveDate;        // 수령 예정일
}