package com.sim.flutterspring.model;

import com.fasterxml.jackson.core.JacksonException;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;

import java.io.IOException;

public class BooleanYNDeserializer extends JsonDeserializer<Boolean> {
    //--Jackson : 'Y' 및 'N'을 boolean 값에 매핑하기 위한 역직렬 변환기--//

    @Override
    public Boolean deserialize(JsonParser p, DeserializationContext ctxt) throws IOException, JacksonException {
        String value = p.getValueAsString();

        if (value.equalsIgnoreCase("Y")) {
            return true;
        } else if (value.equalsIgnoreCase("N")) {
            return false;
        } else {
            throw new IllegalArgumentException("Invalid boolean value: " + value);
        }

    }


}
