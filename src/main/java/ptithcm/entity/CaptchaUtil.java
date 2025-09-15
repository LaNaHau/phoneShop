package ptithcm.entity;

import org.springframework.web.client.RestTemplate;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

@Component
public class CaptchaUtil {

    private static final String RECAPTCHA_VERIFY_URL = "https://www.google.com/recaptcha/api/siteverify";
    private static final String SECRET_KEY = "6LcgPaUqAAAAAOJkLCS_bCgV7FfxTd1Q59_gfuwV";

    private final RestTemplate restTemplate;

    public CaptchaUtil(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public boolean verifyCaptcha(String captchaResponse) {
        if (captchaResponse == null || captchaResponse.isEmpty()) {
            return false;
        }

        String url = RECAPTCHA_VERIFY_URL + "?secret=" + SECRET_KEY + "&response=" + captchaResponse;
        ResponseEntity<Map> response = restTemplate.postForEntity(url, null, Map.class);

        if (response.getBody() == null || !Boolean.TRUE.equals(response.getBody().get("success"))) {
            return false;
        }
        return true;
    }
}
