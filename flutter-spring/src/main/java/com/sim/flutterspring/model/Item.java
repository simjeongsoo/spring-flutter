package com.sim.flutterspring.model;

import com.fasterxml.jackson.annotation.*;
import lombok.Getter;
import lombok.Setter;

import javax.validation.Valid;
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
    private String chgerId;
    @JsonProperty("chgerType")
    private String chgerType;
    @JsonProperty("addr")
    private String addr;
    @JsonProperty("location")
    private String location;
    @JsonProperty("useTime")
    private String useTime;
    @JsonProperty("lat")
    private String lat;
    @JsonProperty("lng")
    private String lng;
    @JsonProperty("busiId")
    private String busiId;
    @JsonProperty("bnm")
    private String bnm;
    @JsonProperty("busiNm")
    private String busiNm;
    @JsonProperty("busiCall")
    private String busiCall;
    @JsonProperty("stat")
    private String stat;
    @JsonProperty("statUpdDt")
    private String statUpdDt;
    @JsonProperty("lastTsdt")
    private String lastTsdt;
    @JsonProperty("lastTedt")
    private String lastTedt;
    @JsonProperty("nowTsdt")
    private String nowTsdt;
    @JsonProperty("powerType")
    private String powerType;
    @JsonProperty("output")
    private String output;
    @JsonProperty("method")
    private String method;
    @JsonProperty("zcode")
    private String zcode;
    @JsonProperty("zscode")
    private String zscode;
    @JsonProperty("kind")
    private String kind;
    @JsonProperty("kindDetail")
    private String kindDetail;
    @JsonProperty("parkingFree")
    private String parkingFree;
    @JsonProperty("note")
    private String note;
    @JsonProperty("limitYn")
    private String limitYn;
    @JsonProperty("limitDetail")
    private String limitDetail;
    @JsonProperty("delYn")
    private String delYn;
    @JsonProperty("delDetail")
    private String delDetail;
    @JsonProperty("trafficYn")
    private String trafficYn;
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
    public String getChgerId() {
        return chgerId;
    }

    @JsonProperty("chgerId")
    public void setChgerId(String chgerId) {
        this.chgerId = chgerId;
    }

    @JsonProperty("chgerType")
    public String getChgerType() {
        return chgerType;
    }

    @JsonProperty("chgerType")
    public void setChgerType(String chgerType) {
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
    public String getLat() {
        return lat;
    }

    @JsonProperty("lat")
    public void setLat(String lat) {
        this.lat = lat;
    }

    @JsonProperty("lng")
    public String getLng() {
        return lng;
    }

    @JsonProperty("lng")
    public void setLng(String lng) {
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
    public String getStat() {
        return stat;
    }

    @JsonProperty("stat")
    public void setStat(String stat) {
        this.stat = stat;
    }

    @JsonProperty("statUpdDt")
    public String getStatUpdDt() {
        return statUpdDt;
    }

    @JsonProperty("statUpdDt")
    public void setStatUpdDt(String statUpdDt) {
        this.statUpdDt = statUpdDt;
    }

    @JsonProperty("lastTsdt")
    public String getLastTsdt() {
        return lastTsdt;
    }

    @JsonProperty("lastTsdt")
    public void setLastTsdt(String lastTsdt) {
        this.lastTsdt = lastTsdt;
    }

    @JsonProperty("lastTedt")
    public String getLastTedt() {
        return lastTedt;
    }

    @JsonProperty("lastTedt")
    public void setLastTedt(String lastTedt) {
        this.lastTedt = lastTedt;
    }

    @JsonProperty("nowTsdt")
    public String getNowTsdt() {
        return nowTsdt;
    }

    @JsonProperty("nowTsdt")
    public void setNowTsdt(String nowTsdt) {
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
    public String getOutput() {
        return output;
    }

    @JsonProperty("output")
    public void setOutput(String output) {
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
    public String getZcode() {
        return zcode;
    }

    @JsonProperty("zcode")
    public void setZcode(String zcode) {
        this.zcode = zcode;
    }

    @JsonProperty("zscode")
    public String getZscode() {
        return zscode;
    }

    @JsonProperty("zscode")
    public void setZscode(String zscode) {
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
    public String getParkingFree() {
        return parkingFree;
    }

    @JsonProperty("parkingFree")
    public void setParkingFree(String parkingFree) {
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
    public String getLimitYn() {
        return limitYn;
    }

    @JsonProperty("limitYn")
    public void setLimitYn(String limitYn) {
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
    public String getDelYn() {
        return delYn;
    }

    @JsonProperty("delYn")
    public void setDelYn(String delYn) {
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
    public String getTrafficYn() {
        return trafficYn;
    }

    @JsonProperty("trafficYn")
    public void setTrafficYn(String trafficYn) {
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
