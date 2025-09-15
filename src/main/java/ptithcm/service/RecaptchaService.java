package ptithcm.service;

import org.springframework.web.client.RestTemplate;

public class RecaptchaService {
    private String secretKey;
    private String verifyUrl;
    private RestTemplate restTemplate;

    // Constructor mặc định
    public RecaptchaService() {
    }

    // Constructor có tham số
    public RecaptchaService(String secretKey, String verifyUrl, RestTemplate restTemplate) {
        this.secretKey = secretKey;
        this.verifyUrl = verifyUrl;
        this.restTemplate = restTemplate;
    }

    // Getters và Setters
    public void setSecretKey(String secretKey) {
        this.secretKey = secretKey;
    }

    public void setVerifyUrl(String verifyUrl) {
        this.verifyUrl = verifyUrl;
    }

    public void setRestTemplate(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public boolean verify(String recaptchaResponse) {
        String url = verifyUrl + "?secret=" + secretKey + "&response=" + recaptchaResponse;
        try {
            String response = restTemplate.postForObject(url, null, String.class);
            return response != null && response.contains("\"success\": true");
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
