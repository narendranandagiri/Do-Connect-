package com.doconnect.moderation;
 
import org.springframework.boot.SpringApplication;
 import org.springframework.boot.autoconfigure.SpringBootApplication;
 import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
 import org.springframework.context.annotation.Bean;
 import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
 import org.springframework.web.client.RestTemplate;
 
import com.fasterxml.jackson.databind.DeserializationFeature;
 import com.fasterxml.jackson.databind.ObjectMapper;
 
@SpringBootApplication
@EnableDiscoveryClient
 public class AdminServiceApplication {
 
    public static void main(String[] args) {
        SpringApplication.run(AdminServiceApplication.class, args);
    }
 
    @Bean
    public RestTemplate restTemplate() {
        // Create and configure Jackson ObjectMapper
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
 
        // Create the MappingJackson2HttpMessageConverter with the custom ObjectMapper
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter(objectMapper);
 
        // Initialize RestTemplate and add the custom message converter
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.getMessageConverters().add(converter);
 
        return restTemplate;
    }
 }