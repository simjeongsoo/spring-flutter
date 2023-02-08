package com.sim.flutterspring.controller;

import com.sim.flutterspring.entity.EvChargerInfo;
import com.sim.flutterspring.model.EvInfoDataDto;
import com.sim.flutterspring.repository.EvChargerInfoRepository;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.Disposable;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/flutter")
@RequiredArgsConstructor
public class EvInfoApiController {
    //--flutter request를 받을 api--//
    Logger logger = LoggerFactory.getLogger(EvInfoApiController.class);

    private final EvChargerInfoRepository evChargerInfoRepository;

    /**
     * 전기차 충전소 info api
     * */
    @GetMapping("/get/evInfo")
    public List<EvChargerInfo> getEvInfoData() {
    //        EvChargerInfo evChargerInfo = evChargerInfoRepository.findById(1L).orElse(null);
        return evChargerInfoRepository.findAll();
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
