package com.sim.flutterspring.service;

import com.sim.flutterspring.controller.EvInfoDataController;
import com.sim.flutterspring.model.EvInfoDataDto;
import com.sim.flutterspring.repository.EvChargerInfoRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
        logger.info("충전소 이름 : {} ", data.items.item.get(0).getStatNm());
    }


}
