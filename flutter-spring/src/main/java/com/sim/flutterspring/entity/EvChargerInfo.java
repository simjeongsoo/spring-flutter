package com.sim.flutterspring.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.util.Date;

@Getter
@Entity
@NoArgsConstructor
public class EvChargerInfo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String statNm;          // 충전소명
    private Long statId;            // 충전소 ID
    private Long chgerId;           // 충전기 ID
    private Long chgerType;         // 충전기 타입
    private String addr;            // 주소
    private String location;        // 상세위치
    private Long lat;               // 위도
    private Long lng;               // 경도
    private String useTime;         // 이용가능시간
    private String busiId;          // 기관 아이디
    private String bnm;             // 기관명
    private String busiNm;          // 운영기관명
    private String busiCall;        // 운영기관 연락처
    private Long chstat;            // 충전기 상태
    private Date statUpdDt;         // 상태 갱신일시
    private Date lastTsdt;          // 마지막 충전시작 일시
    private Date lastTedt;          // 마지막 충전종료 일시
    private Long output;            // 충전용량
    private boolean method;         // 충전방식
    private Long zcode;             // 지역코드
    private Long zscode;            // 지역구분 상세코드
    private String kind;            // 충전소 구분 코드
    private String kindDetail;      // 충전소 구분 상세 코드
    private boolean parkingFree;    // 주차료 무료
    private String note;            // 충전소 안내
    private boolean limitYn;        // 이용자제한
    private String limitDetail;     // 이용 제한사유
    private boolean delYn;          // 삭제 여부
    private String delDetail;       // 삭제 사유
    private boolean trafficYn;      // 편의제공 여부
}
