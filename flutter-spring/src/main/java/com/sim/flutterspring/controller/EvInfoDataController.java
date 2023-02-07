package com.sim.flutterspring.controller;

import com.sim.flutterspring.model.EvInfoDataDto;
import com.sim.flutterspring.service.EvInfoDataService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

@RestController
@RequestMapping("/api")
public class EvInfoDataController {

    Logger logger = LoggerFactory.getLogger(EvInfoDataController.class);

    @Value("${api.key}")
    String key;

    int totalCount = 36352;
    int numOfRows = 100;
    int totalPages = totalCount / numOfRows + (totalCount % numOfRows == 0 ? 0 : 1);

    private final EvInfoDataService evInfoDataService;

    @Autowired
    public EvInfoDataController(EvInfoDataService evInfoDataService) {
        this.evInfoDataService = evInfoDataService;
    }
    
    /**
     * Ev 충전소 정보 조회 api
     * */
    @GetMapping("/getChargerInfo/{page}")
    public Mono<EvInfoDataDto> getChargerInfo(@PathVariable String page) {
        //--using WebFlux's WebClient--//

//        String apiurl = "http://apis.data.go.kr/B552584/EvCharger/getChargerInfo" +
//                "?" + "serviceKey=" + key +
//                "&" + "numOfRows=" + "10" +
//                "&" + "pageNo=" + page +
//                "&" + "zcode=" + 11 +
//                "&" + "dataType=" + "JSON";

        String apiurl = "http://apis.data.go.kr/B552584/EvCharger/getChargerInfo";

        // WebClient build
        WebClient wc = WebClient.builder()
                .baseUrl(apiurl)
                .defaultHeader(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE)
                .codecs(clientCodecConfigurer -> clientCodecConfigurer.defaultCodecs().maxInMemorySize(-1)) // to unlimited memory size
                .build();



        /*for (int pageNo = 1; pageNo <= totalPages; pageNo++) {
            // WebClient 를 이용한 get request
            Mono<EvInfoDataDto> result = wc.get()
                    .uri("?serviceKey={serviceKey}&numOfRows={numOfRows}&pageNo={pageNo}&zcode={zcode}&dataType={dataType}",
                            key, pageSize, pageNo, "11", "JSON")
                    .retrieve()  // get body
                    .bodyToMono(EvInfoDataDto.class); // JSON 데이터 역직렬화 하여 dto 매핑


            // response data 처리로직
            // Use the EvChargerInfoDto
            // dto -> service 전달
            result.subscribe(evInfoDataService::saveEvInfoData);

        }
*/

        // data 100개 제한
        Mono<EvInfoDataDto> result2 = wc.get()
                .uri("?serviceKey={serviceKey}&numOfRows={numOfRows}&pageNo={pageNo}&zcode={zcode}&dataType={dataType}",
                        key, numOfRows, page, "11", "JSON")
                .retrieve()  // get body
                .bodyToMono(EvInfoDataDto.class); // JSON 데이터 역직렬화 하여 dto 매핑

        // response data 처리로직
        // Use the EvChargerInfoDto
        // dto -> service 전달
        result2.subscribe(evInfoDataService::saveEvInfoData);

        return result2;
    }

    /**
     * Ev 충전소 상태 조회 api
     * */
    @GetMapping("/getChargerStatus/{page}")
    public String getChargerStatus(@PathVariable String page) {
        StringBuffer result = new StringBuffer();

        try {
            String apiurl = "http://apis.data.go.kr/B552584/EvCharger/getChargerStatus" +
                    "?" + "serviceKey=" + key +
                    "&" + "numOfRows=" + "10" +
                    "&" + "pageNo=" + page +
                    "&" + "zcode=" + 11 +           // 서울
                    "&" + "dataType=" + "JSON";

            URL url = new URL(apiurl);
            HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
            urlConnection.setRequestMethod("GET");

            BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream(), StandardCharsets.UTF_8));

            String returnLine;
            while ((returnLine = br.readLine()) != null) {
                result.append(returnLine).append("\n");
            }
            urlConnection.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return String.valueOf(result);
    }

}
