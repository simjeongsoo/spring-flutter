package com.sim.flutterspring.controller;

import com.sim.flutterspring.model.EvChargerInfoResponseDto;
import com.sim.flutterspring.repository.EvChargerInfoRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/flutter")
public class EvInfoApiController {
    //--flutter request를 받을 api--//
    Logger logger = LoggerFactory.getLogger(EvInfoApiController.class);

    private final EvChargerInfoRepository evChargerInfoRepository;

    @Autowired
    public EvInfoApiController(EvChargerInfoRepository evChargerInfoRepository) {
        this.evChargerInfoRepository = evChargerInfoRepository;
    }

    /**
     * 전기차 충전소 info api
     * */
    //    @PreAuthorize("hasAnyRole('ADMIN')")
    @GetMapping("/get/evInfo")
    public List<EvChargerInfoResponseDto> getEvInfoData() {

        return evChargerInfoRepository.findAll().stream()
                .map(EvChargerInfoResponseDto::from)
                .collect(Collectors.toList());

    }

    /*@GetMapping("/get/one")
    public Mono<EvChargerInfo> getOneWithWebClient() {

        Mono<EvChargerInfo> evChargerInfoMono = evChargerInfoRepository.findById(1L)
                .map(evChargerInfo -> Mono.just(evChargerInfo))
                .orElseGet(() -> WebClient
                        .create("http://localhost:8081/flutter/get/one")
                        .get()
                        .retrieve()
                        .bodyToMono(EvChargerInfo.class));

        return evChargerInfoMono;
    }*/

}
