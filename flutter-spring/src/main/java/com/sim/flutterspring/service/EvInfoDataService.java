package com.sim.flutterspring.service;

import com.sim.flutterspring.entity.EvChargerInfo;
import com.sim.flutterspring.model.EvInfoDataDto;
import com.sim.flutterspring.model.Item;
import com.sim.flutterspring.repository.EvChargerInfoRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class EvInfoDataService {
    //--api response 데이터를 DB에 저장할 EvInfoDataService 클래스--//
    Logger logger = LoggerFactory.getLogger(EvInfoDataService.class);

    private final EvChargerInfoRepository evChargerInfoRepository;

    @Autowired
    public EvInfoDataService(EvChargerInfoRepository evChargerInfoRepository) {
        this.evChargerInfoRepository = evChargerInfoRepository;
    }

    public void saveEvInfoData(EvInfoDataDto data) {
        List<Item> item = data.items.item;

        for (Item value : item) {
            EvChargerInfo evChargerInfo = EvChargerInfo.builder()
                    .statNm(value.getStatNm())
                    .statId(value.getStatId())
                    .chgerId(value.getChgerId())
                    .chgerType(value.getChgerType())
                    .addr(value.getAddr())
                    .location(value.getLocation())
                    .useTime(value.getUseTime())
                    .lat(value.getLat())
                    .lng(value.getLng())
                    .busiId(value.getBusiId())
                    .bnm(value.getBnm())
                    .busiNm(value.getBusiNm())
                    .busiCall(value.getBusiCall())
                    .chstat(value.getStat())
                    .statUpdDt(value.getStatUpdDt())
                    .lastTsdt(value.getLastTsdt())
                    .lastTedt(value.getLastTsdt())
                    .nowTsdt(value.getNowTsdt())
                    .powerType(value.getPowerType())
                    .output(value.getOutput())
                    .method(value.getMethod())
                    .zcode(value.getZcode())
                    .zscode(value.getZscode())
                    .kind(value.getKind())
                    .kindDetail(value.getKindDetail())
                    .parkingFree(value.getParkingFree())
                    .note(value.getNote())
                    .limitYn(value.getLimitYn())
                    .limitDetail(value.getLimitDetail())
                    .delYn(value.getDelYn())
                    .delDetail(value.getDelDetail())
                    .trafficYn(value.getTrafficYn())
                    .build();

            evChargerInfoRepository.save(evChargerInfo);
        }
    }
}
