package com.sim.flutterspring.model;

import com.fasterxml.jackson.annotation.*;
import lombok.Getter;
import lombok.Setter;

import javax.validation.Valid;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

    @Getter @Setter
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @JsonPropertyOrder({
            "item"
    })
    public class Items {
        //--Json to POJO 역직렬화--//

        @JsonProperty("item")
        @Valid
        public List<Item> item;

        @JsonIgnore
        @Valid
        private Map<String, Object> additionalProperties = new LinkedHashMap<String, Object>();

        @JsonAnyGetter
        public Map<String, Object> getAdditionalProperties() {
            return this.additionalProperties;
        }

        @JsonAnySetter
        public void setAdditionalProperty(String name, Object value) {
            this.additionalProperties.put(name, value);
        }
}
