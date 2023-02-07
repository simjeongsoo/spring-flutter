package com.sim.flutterspring.model;

import com.fasterxml.jackson.annotation.*;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import lombok.Getter;
import lombok.Setter;

import javax.validation.Valid;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

@Getter @Setter
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "statNm",
        "statId",
        "chgerId",
        "chgerType",
        "addr",
        "location",
        "useTime",
        "lat",
        "lng",
        "busiId",
        "bnm",
        "busiNm",
        "busiCall",
        "stat",
        "statUpdDt",
        "lastTsdt",
        "lastTedt",
        "nowTsdt",
        "powerType",
        "output",
        "method",
        "zcode",
        "zscode",
        "kind",
        "kindDetail",
        "parkingFree",
        "note",
        "limitYn",
        "limitDetail",
        "delYn",
        "delDetail",
        "trafficYn"
})
public class Item {
    //--Json to POJO 역직렬화--//

    @JsonProperty("statNm")
    private String statNm;
    @JsonProperty("statId")
    private String statId;
    @JsonProperty("chgerId")
    private Long chgerId;
    @JsonProperty("chgerType")
    private Long chgerType;
    @JsonProperty("addr")
    private String addr;
    @JsonProperty("location")
    private String location;
    @JsonProperty("useTime")
    private String useTime;
    @JsonProperty("lat")
    private Double lat;
    @JsonProperty("lng")
    private Double lng;
    @JsonProperty("busiId")
    private String busiId;
    @JsonProperty("bnm")
    private String bnm;
    @JsonProperty("busiNm")
    private String busiNm;
    @JsonProperty("busiCall")
    private String busiCall;
    @JsonProperty("stat")
    private Long stat;
    @JsonProperty("statUpdDt")
    private Date statUpdDt;
    @JsonProperty("lastTsdt")
    private Date lastTsdt;
    @JsonProperty("lastTedt")
    private Date lastTedt;
    @JsonProperty("nowTsdt")
    private Date nowTsdt;
    @JsonProperty("powerType")
    private String powerType;
    @JsonProperty("output")
    private Long output;
    @JsonProperty("method")
    private String method;
    @JsonProperty("zcode")
    private Long zcode;
    @JsonProperty("zscode")
    private Long zscode;
    @JsonProperty("kind")
    private String kind;
    @JsonProperty("kindDetail")
    private String kindDetail;
    @JsonProperty("parkingFree")
    @JsonDeserialize(using = BooleanYNDeserializer.class)
    private boolean parkingFree;
    @JsonProperty("note")
    private String note;
    @JsonProperty("limitYn")
    @JsonDeserialize(using = BooleanYNDeserializer.class)
    private boolean limitYn;
    @JsonProperty("limitDetail")
    private String limitDetail;
    @JsonProperty("delYn")
    @JsonDeserialize(using = BooleanYNDeserializer.class)
    private boolean delYn;
    @JsonProperty("delDetail")
    private String delDetail;
    @JsonProperty("trafficYn")
    @JsonDeserialize(using = BooleanYNDeserializer.class)
    private boolean trafficYn;
    @JsonIgnore
    @Valid
    private Map<String, Object> additionalProperties = new LinkedHashMap<String, Object>();

    @JsonProperty("statNm")
    public String getStatNm() {
        return statNm;
    }

    @JsonProperty("statNm")
    public void setStatNm(String statNm) {
        this.statNm = statNm;
    }

    @JsonProperty("statId")
    public String getStatId() {
        return statId;
    }

    @JsonProperty("statId")
    public void setStatId(String statId) {
        this.statId = statId;
    }

    @JsonProperty("chgerId")
    public Long getChgerId() {
        return chgerId;
    }

    @JsonProperty("chgerId")
    public void setChgerId(Long chgerId) {
        this.chgerId = chgerId;
    }

    @JsonProperty("chgerType")
    public Long getChgerType() {
        return chgerType;
    }

    @JsonProperty("chgerType")
    public void setChgerType(Long chgerType) {
        this.chgerType = chgerType;
    }

    @JsonProperty("addr")
    public String getAddr() {
        return addr;
    }

    @JsonProperty("addr")
    public void setAddr(String addr) {
        this.addr = addr;
    }

    @JsonProperty("location")
    public String getLocation() {
        return location;
    }

    @JsonProperty("location")
    public void setLocation(String location) {
        this.location = location;
    }

    @JsonProperty("useTime")
    public String getUseTime() {
        return useTime;
    }

    @JsonProperty("useTime")
    public void setUseTime(String useTime) {
        this.useTime = useTime;
    }

    @JsonProperty("lat")
    public Double getLat() {
        return lat;
    }

    @JsonProperty("lat")
    public void setLat(Double lat) {
        this.lat = lat;
    }

    @JsonProperty("lng")
    public Double getLng() {
        return lng;
    }

    @JsonProperty("lng")
    public void setLng(Double lng) {
        this.lng = lng;
    }

    @JsonProperty("busiId")
    public String getBusiId() {
        return busiId;
    }

    @JsonProperty("busiId")
    public void setBusiId(String busiId) {
        this.busiId = busiId;
    }

    @JsonProperty("bnm")
    public String getBnm() {
        return bnm;
    }

    @JsonProperty("bnm")
    public void setBnm(String bnm) {
        this.bnm = bnm;
    }

    @JsonProperty("busiNm")
    public String getBusiNm() {
        return busiNm;
    }

    @JsonProperty("busiNm")
    public void setBusiNm(String busiNm) {
        this.busiNm = busiNm;
    }

    @JsonProperty("busiCall")
    public String getBusiCall() {
        return busiCall;
    }

    @JsonProperty("busiCall")
    public void setBusiCall(String busiCall) {
        this.busiCall = busiCall;
    }

    @JsonProperty("stat")
    public Long getStat() {
        return stat;
    }

    @JsonProperty("stat")
    public void setStat(Long stat) {
        this.stat = stat;
    }

    @JsonProperty("statUpdDt")
    public Date getStatUpdDt() {
        return statUpdDt;
    }

    @JsonProperty("statUpdDt")
    public void setStatUpdDt(Date statUpdDt) {
        this.statUpdDt = statUpdDt;
    }

    @JsonProperty("lastTsdt")
    public Date getLastTsdt() {
        return lastTsdt;
    }

    @JsonProperty("lastTsdt")
    public void setLastTsdt(Date lastTsdt) {
        this.lastTsdt = lastTsdt;
    }

    @JsonProperty("lastTedt")
    public Date getLastTedt() {
        return lastTedt;
    }

    @JsonProperty("lastTedt")
    public void setLastTedt(Date lastTedt) {
        this.lastTedt = lastTedt;
    }

    @JsonProperty("nowTsdt")
    public Date getNowTsdt() {
        return nowTsdt;
    }

    @JsonProperty("nowTsdt")
    public void setNowTsdt(Date nowTsdt) {
        this.nowTsdt = nowTsdt;
    }

    @JsonProperty("powerType")
    public String getPowerType() {
        return powerType;
    }

    @JsonProperty("powerType")
    public void setPowerType(String powerType) {
        this.powerType = powerType;
    }

    @JsonProperty("output")
    public Long getOutput() {
        return output;
    }

    @JsonProperty("output")
    public void setOutput(Long output) {
        this.output = output;
    }

    @JsonProperty("method")
    public String getMethod() {
        return method;
    }

    @JsonProperty("method")
    public void setMethod(String method) {
        this.method = method;
    }

    @JsonProperty("zcode")
    public Long getZcode() {
        return zcode;
    }

    @JsonProperty("zcode")
    public void setZcode(Long zcode) {
        this.zcode = zcode;
    }

    @JsonProperty("zscode")
    public Long getZscode() {
        return zscode;
    }

    @JsonProperty("zscode")
    public void setZscode(Long zscode) {
        this.zscode = zscode;
    }

    @JsonProperty("kind")
    public String getKind() {
        return kind;
    }

    @JsonProperty("kind")
    public void setKind(String kind) {
        this.kind = kind;
    }

    @JsonProperty("kindDetail")
    public String getKindDetail() {
        return kindDetail;
    }

    @JsonProperty("kindDetail")
    public void setKindDetail(String kindDetail) {
        this.kindDetail = kindDetail;
    }

    @JsonProperty("parkingFree")
    public boolean getParkingFree() {
        return parkingFree;
    }

    @JsonProperty("parkingFree")
    public void setParkingFree(boolean parkingFree) {
        this.parkingFree = parkingFree;
    }

    @JsonProperty("note")
    public String getNote() {
        return note;
    }

    @JsonProperty("note")
    public void setNote(String note) {
        this.note = note;
    }

    @JsonProperty("limitYn")
    public boolean getLimitYn() {
        return limitYn;
    }

    @JsonProperty("limitYn")
    public void setLimitYn(boolean limitYn) {
        this.limitYn = limitYn;
    }

    @JsonProperty("limitDetail")
    public String getLimitDetail() {
        return limitDetail;
    }

    @JsonProperty("limitDetail")
    public void setLimitDetail(String limitDetail) {
        this.limitDetail = limitDetail;
    }

    @JsonProperty("delYn")
    public boolean getDelYn() {
        return delYn;
    }

    @JsonProperty("delYn")
    public void setDelYn(boolean delYn) {
        this.delYn = delYn;
    }

    @JsonProperty("delDetail")
    public String getDelDetail() {
        return delDetail;
    }

    @JsonProperty("delDetail")
    public void setDelDetail(String delDetail) {
        this.delDetail = delDetail;
    }

    @JsonProperty("trafficYn")
    public boolean getTrafficYn() {
        return trafficYn;
    }

    @JsonProperty("trafficYn")
    public void setTrafficYn(boolean trafficYn) {
        this.trafficYn = trafficYn;
    }

    @JsonAnyGetter
    public Map<String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    @JsonAnySetter
    public void setAdditionalProperty(String name, Object value) {
        this.additionalProperties.put(name, value);
    }

}
