class EvChargerInfo {
  String statNm; // 충전소명
  String statId; // 충전소 ID
  var chgerId; // 충전기 ID
  var chgerType; // 충전기 타입
  String addr; // 주소
  String location; // 상세위치
  String useTime; // 이용가능시간
  var lat; // 위도
  var lng; // 경도
  String busiId; // 기관 아이디
  String bnm; // 기관명
  String busiNm; // 운영기관명
  String busiCall; // 운영기관 연락처
  var chstat; // 충전기 상태
  String statUpdDt; // 상태 갱신일시
  String lastTsdt; // 마지막 충전시작 일시
  String lastTedt; // 마지막 충전종료 일시
  String nowTsdt; // 충전중 시작일시
  String powerType;
  var output; // 충전용량
  String method; // 충전방식
  var zcode; // 지역코드
  var zscode; // 지역구분 상세코드
  String kind; // 충전소 구분 코드
  String kindDetail; // 충전소 구분 상세 코드
  bool parkingFree; // 주차료 무료
  String note; // 충전소 안내
  bool limitYn; // 이용자제한
  String limitDetail; // 이용 제한사유
  bool delYn; // 삭제 여부
  String delDetail; // 삭제 사유
  bool trafficYn; // 편의제공 여부

  EvChargerInfo(
      this.statNm,
      this.statId,
      this.chgerId,
      this.chgerType,
      this.addr,
      this.location,
      this.useTime,
      this.lat,
      this.lng,
      this.busiId,
      this.bnm,
      this.busiNm,
      this.busiCall,
      this.chstat,
      this.statUpdDt,
      this.lastTsdt,
      this.lastTedt,
      this.nowTsdt,
      this.powerType,
      this.output,
      this.method,
      this.zcode,
      this.zscode,
      this.kind,
      this.kindDetail,
      this.parkingFree,
      this.note,
      this.limitYn,
      this.limitDetail,
      this.delYn,
      this.delDetail,
      this.trafficYn
  );

  String get _statNm => statNm;

  String get _statId => statId;

  factory EvChargerInfo.fromJson(Map<String, dynamic> json) {
    return EvChargerInfo(
      json['statNm'],
      json['statId'],
      json['chgerId'],
      json['chgerType'],
      json['addr'],
      json['location'],
      json['useTime'],
      json['lat'],
      json['lng'],
      json['busiId'],
      json['bnm'],
      json['busiNm'],
      json['busiCall'],
      json['chstat'],
      json['statUpDt'],
      json['lastTsdt'],
      json['lastTedt'],
      json['nowTsdt'],
      json['powerType'],
      json['output'],
      json['method'],
      json['zcode'],
      json['zscode'],
      json['kind'],
      json['kindDetail'],
      json['parkingFree'],
      json['note'],
      json['limitYn'],
      json['limitDetail'],
      json['delYn'],
      json['delDetail'],
      json['trafficYn'],
    );
  }

  static List<EvChargerInfo> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => EvChargerInfo.fromJson(e)).toList();
  }

}