package com.example.nalogaDva;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**") // Omogočite CORS za vse poti
                .allowedOrigins("http://localhost:3000") // Dovolite dostop iz frontend naslova
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS");
    }
}
