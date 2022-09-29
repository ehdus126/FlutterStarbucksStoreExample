import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SirenOrderStoreListRes {
  App? app;

  SirenOrderStoreListRes({this.app});

  SirenOrderStoreListRes.fromJson(Map<String, dynamic> json) {
    app = json['app'] != null ? new App.fromJson(json['app']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.app != null) {
      data['app'] = this.app!.toJson();
    }
    return data;
  }
}

class App {
  String? totalCount;
  String? page;
  String? totalPageCount;
  List<StoreList>? storeList;
  List<MessageList>? messageList;

  App(
      {this.totalCount,
        this.page,
        this.totalPageCount,
        this.storeList,
        this.messageList});

  App.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    page = json['page'];
    totalPageCount = json['totalPageCount'];
    if (json['storeList'] != null) {
      storeList = <StoreList>[];
      json['storeList'].forEach((v) {
        storeList!.add(new StoreList.fromJson(v));
      });
    }
    if (json['messageList'] != null) {
      messageList = <MessageList>[];
      json['messageList'].forEach((v) {
        messageList!.add(new MessageList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['page'] = this.page;
    data['totalPageCount'] = this.totalPageCount;
    if (this.storeList != null) {
      data['storeList'] = this.storeList!.map((v) => v.toJson()).toList();
    }
    if (this.messageList != null) {
      data['messageList'] = this.messageList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoreList {
  String? storeCd;
  String? storeName;
  String? storeIntro;
  String? storeAddr;
  String? latitude;
  String? longitude;
  String? distance;
  String? orderFlag;
  String? openTime;
  String? closeTime;
  String? closedDayYn;
  String? outsideStoreDesc;
  String? insideStoreDesc;
  String? storeImgUrl;
  String? storeTypeIcon;
  List<ReceiveTypeList>? receiveTypeList;
  String? storeAttr;
  String? reusableCupAllowYn;
  String? storeDscpDepositYn;

  StoreList(
      {this.storeCd,
        this.storeName,
        this.storeIntro,
        this.storeAddr,
        this.latitude,
        this.longitude,
        this.distance,
        this.orderFlag,
        this.openTime,
        this.closeTime,
        this.closedDayYn,
        this.outsideStoreDesc,
        this.insideStoreDesc,
        this.storeImgUrl,
        this.storeTypeIcon,
        this.receiveTypeList,
        this.storeAttr,
        this.reusableCupAllowYn,
        this.storeDscpDepositYn});

  StoreList.fromJson(Map<String, dynamic> json) {
    storeCd = json['storeCd'];
    storeName = json['storeName'];
    storeIntro = json['storeIntro'];
    storeAddr = json['storeAddr'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distance = json['distance'];
    orderFlag = json['orderFlag'];
    openTime = json['openTime'];
    closeTime = json['closeTime'];
    closedDayYn = json['closedDayYn'];
    outsideStoreDesc = json['outsideStoreDesc'];
    insideStoreDesc = json['insideStoreDesc'];
    storeImgUrl = json['storeImgUrl'];
    storeTypeIcon = json['storeTypeIcon'];
    if (json['receiveTypeList'] != null) {
      receiveTypeList = <ReceiveTypeList>[];
      json['receiveTypeList'].forEach((v) {
        receiveTypeList!.add(new ReceiveTypeList.fromJson(v));
      });
    }
    storeAttr = json['storeAttr'];
    reusableCupAllowYn = json['reusableCupAllowYn'];
    storeDscpDepositYn = json['storeDscpDepositYn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeCd'] = this.storeCd;
    data['storeName'] = this.storeName;
    data['storeIntro'] = this.storeIntro;
    data['storeAddr'] = this.storeAddr;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['distance'] = this.distance;
    data['orderFlag'] = this.orderFlag;
    data['openTime'] = this.openTime;
    data['closeTime'] = this.closeTime;
    data['closedDayYn'] = this.closedDayYn;
    data['outsideStoreDesc'] = this.outsideStoreDesc;
    data['insideStoreDesc'] = this.insideStoreDesc;
    data['storeImgUrl'] = this.storeImgUrl;
    data['storeTypeIcon'] = this.storeTypeIcon;
    if (this.receiveTypeList != null) {
      data['receiveTypeList'] =
          this.receiveTypeList!.map((v) => v.toJson()).toList();
    }
    data['storeAttr'] = this.storeAttr;
    data['reusableCupAllowYn'] = this.reusableCupAllowYn;
    data['storeDscpDepositYn'] = this.storeDscpDepositYn;
    return data;
  }
}

class ReceiveTypeList {
  String? receiveType;
  String? receiveTypeName;
  String? enableReceiveYn;
  String? storeCupAllowFlag;
  String? receiveZoneTimeName;
  String? receiveZoneOpenTime;
  String? receiveZoneCloseTime;
  List<CupTypeList>? cupTypeList;

  ReceiveTypeList(
      {this.receiveType,
        this.receiveTypeName,
        this.enableReceiveYn,
        this.storeCupAllowFlag,
        this.receiveZoneTimeName,
        this.receiveZoneOpenTime,
        this.receiveZoneCloseTime,
        this.cupTypeList});

  ReceiveTypeList.fromJson(Map<String, dynamic> json) {
    receiveType = json['receiveType'];
    receiveTypeName = json['receiveTypeName'];
    enableReceiveYn = json['enableReceiveYn'];
    storeCupAllowFlag = json['storeCupAllowFlag'];
    receiveZoneTimeName = json['receiveZoneTimeName'];
    receiveZoneOpenTime = json['receiveZoneOpenTime'];
    receiveZoneCloseTime = json['receiveZoneCloseTime'];
    if (json['cupTypeList'] != null) {
      cupTypeList = <CupTypeList>[];
      json['cupTypeList'].forEach((v) {
        cupTypeList!.add(new CupTypeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receiveType'] = this.receiveType;
    data['receiveTypeName'] = this.receiveTypeName;
    data['enableReceiveYn'] = this.enableReceiveYn;
    data['storeCupAllowFlag'] = this.storeCupAllowFlag;
    data['receiveZoneTimeName'] = this.receiveZoneTimeName;
    data['receiveZoneOpenTime'] = this.receiveZoneOpenTime;
    data['receiveZoneCloseTime'] = this.receiveZoneCloseTime;
    if (this.cupTypeList != null) {
      data['cupTypeList'] = this.cupTypeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CupTypeList {
  String? cupType;
  String? cupTypeName;

  CupTypeList({this.cupType, this.cupTypeName});

  CupTypeList.fromJson(Map<String, dynamic> json) {
    cupType = json['cupType'];
    cupTypeName = json['cupTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cupType'] = this.cupType;
    data['cupTypeName'] = this.cupTypeName;
    return data;
  }
}

class MessageList {
  String? messageId;
  String? message;
  String? subMessage;

  MessageList({this.messageId, this.message, this.subMessage});

  MessageList.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
    message = json['message'];
    subMessage = json['subMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageId'] = this.messageId;
    data['message'] = this.message;
    data['subMessage'] = this.subMessage;
    return data;
  }
}