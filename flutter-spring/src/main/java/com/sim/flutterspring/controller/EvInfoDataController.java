package com.sim.flutterspring.controller;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

@RestController
@RequestMapping("/api")
public class EvInfoDataController {

    Logger logger = LoggerFactory.getLogger(EvInfoDataController.class);

    @Value("${api.key}")
    String key;

    private final int allChStationNum = 36217;

    /**
     * Ev 충전소 정보 조회 api
     * */
    @GetMapping("/getChargerInfo/{page}")
    public String getChargerInfo(@PathVariable String page) throws ParseException {
        StringBuffer result = new StringBuffer();

        try {
            //--java SSL 인증서 유효성 검사 우회--//
            TrustManager trm = new X509TrustManager() {
                @Override
                public void checkClientTrusted(X509Certificate[] chain, String authType) throws CertificateException {}
                @Override
                public void checkServerTrusted(X509Certificate[] chain, String authType) throws CertificateException {}
                @Override
                public X509Certificate[] getAcceptedIssuers() {
//                    return new X509Certificate[0];
                    return null;
                }
            };
            SSLContext sc = SSLContext.getInstance("SSL");
            sc.init(null, new TrustManager[]{trm}, null);
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
            HttpsURLConnection.setDefaultHostnameVerifier(((hostname, session) -> true));
            //--java SSL 인증서 유효성 검사 우회--//

            String apiurl = "http://apis.data.go.kr/B552584/EvCharger/getChargerInfo" +
                    "?" + "serviceKey=" + key +
                    "&" + "numOfRows=" + "10" +
                    "&" + "pageNo=" + page +
                    "&" + "zcode=" + 11 +           // 서울 지역 코드
                    "&" + "dataType=" + "JSON";


            URL url = new URL(apiurl);

            // Java 표준 HTTP request API
            HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
            urlConnection.setRequestMethod("GET");

            BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream(), StandardCharsets.UTF_8));

            String returnLine;
//            result.append("<xmp>");
            while ((returnLine = br.readLine()) != null) {
                result.append(returnLine).append("\n");
            }
            urlConnection.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }

        String resultStr = String.valueOf(result);
        JSONParser parser = new JSONParser();
        JSONObject object = (JSONObject) parser.parse(resultStr); // 전체 데이터
        JSONObject items = (JSONObject) object.get("items");    // items
        JSONArray itemArr = (JSONArray) items.get("item");


        for (int i = 0; i < itemArr.size(); i++) {
            object = (JSONObject) itemArr.get(i);
            logger.info("{} . 충전소 이름 : {}", i + 1, object.get("statNm"));
            logger.info("{} . 충전기 상태 : {}", i + 1, object.get("stat"));
        }

        return String.valueOf(result);
    }
}
