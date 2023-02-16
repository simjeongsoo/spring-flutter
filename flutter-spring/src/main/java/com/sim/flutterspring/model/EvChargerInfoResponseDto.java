package com.sim.flutterspring.model;

import com.sim.flutterspring.entity.EvChargerInfo;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
public class EvChargerInfoResponseDto {
    private String statNm;          // 충전소명
    private String statId;            // 충전소 ID
    private Long chgerId;           // 충전기 ID
    private Long chgerType;         // 충전기 타입
    private String addr;            // 주소
    private String location;        // 상세위치
    private String useTime;         // 이용가능시간
    private Double lat;               // 위도
    private Double lng;               // 경도
    private String busiId;          // 기관 아이디
    private String bnm;             // 기관명
    private String busiNm;          // 운영기관명
    private String busiCall;        // 운영기관 연락처
    private Long chstat;            // 충전기 상태
    private Date statUpdDt;         // 상태 갱신일시
    private Date lastTsdt;          // 마지막 충전시작 일시
    private Date lastTedt;          // 마지막 충전종료 일시
    private Date nowTsdt;           // 충전중 시작일시
    private String powerType;
    private Long output;            // 충전용량
    private String method;         // 충전방식
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

    @Builder
    public EvChargerInfoResponseDto(String statNm, String statId, Long chgerId, Long chgerType, String addr,
                                    String location, String useTime, Double lat, Double lng, String busiId, String bnm,
                                    String busiNm, String busiCall, Long chstat, Date statUpdDt, Date lastTsdt,
                                    Date lastTedt, Date nowTsdt, String powerType, Long output, String method, Long zcode,
                                    Long zscode, String kind, String kindDetail, boolean parkingFree, String note,
                                    boolean limitYn, String limitDetail, boolean delYn, String delDetail, boolean trafficYn) {
        this.statNm = statNm;
        this.statId = statId;
        this.chgerId = chgerId;
        this.chgerType = chgerType;
        this.addr = addr;
        this.location = location;
        this.useTime = useTime;
        this.lat = lat;
        this.lng = lng;
        this.busiId = busiId;
        this.bnm = bnm;
        this.busiNm = busiNm;
        this.busiCall = busiCall;
        this.chstat = chstat;
        this.statUpdDt = statUpdDt;
        this.lastTsdt = lastTsdt;
        this.lastTedt = lastTedt;
        this.nowTsdt = nowTsdt;
        this.powerType = powerType;
        this.output = output;
        this.method = method;
        this.zcode = zcode;
        this.zscode = zscode;
        this.kind = kind;
        this.kindDetail = kindDetail;
        this.parkingFree = parkingFree;
        this.note = note;
        this.limitYn = limitYn;
        this.limitDetail = limitDetail;
        this.delYn = delYn;
        this.delDetail = delDetail;
        this.trafficYn = trafficYn;
    }


    public static EvChargerInfoResponseDto from(EvChargerInfo entity) {
        return EvChargerInfoResponseDto.builder()
                .statNm(entity.getStatNm())
                .statId(entity.getStatId())
                .chgerId(entity.getChgerId())
                .chgerType(entity.getChgerType())
                .addr(entity.getAddr())
                .location(entity.getLocation())
                .useTime(entity.getUseTime())
                .lat(entity.getLat())
                .lng(entity.getLng())
                .busiId(entity.getBusiId())
                .bnm(entity.getBnm())
                .busiNm(entity.getBusiNm())
                .busiCall(entity.getBusiCall())
                .chstat(entity.getChstat())
                .statUpdDt(entity.getStatUpdDt())
                .lastTsdt(entity.getLastTsdt())
                .lastTedt(entity.getLastTedt())
                .nowTsdt(entity.getNowTsdt())
                .powerType(entity.getPowerType())
                .output(entity.getOutput())
                .method(entity.getMethod())
                .zcode(entity.getZcode())
                .zscode(entity.getZscode())
                .kind(entity.getKind())
                .kindDetail(entity.getKindDetail())
                .parkingFree(entity.isParkingFree())
                .note(entity.getNote())
                .limitYn(entity.isLimitYn())
                .limitDetail(entity.getLimitDetail())
                .delYn(entity.isDelYn())
                .delDetail(entity.getDelDetail())
                .trafficYn(entity.isTrafficYn())
                .build();
    }
}
