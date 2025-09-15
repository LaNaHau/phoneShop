package ptithcm.service;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

public class EncryptionUtil {

    private static final String ALGORITHM = "AES";
    private static final byte[] KEY = "MySuperSecretKey".getBytes(); // Khóa phải có 16 bytes

    public static String encrypt(String data) {
        try {
            SecretKey secretKey = new SecretKeySpec(KEY, ALGORITHM);
            Cipher cipher = Cipher.getInstance(ALGORITHM);
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
            byte[] encryptedData = cipher.doFinal(data.getBytes());
            return Base64.getEncoder().encodeToString(encryptedData);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi mã hóa", e);
        }
    }

    public static String decrypt(String encryptedData) {
        try {
            SecretKey secretKey = new SecretKeySpec(KEY, ALGORITHM);
            Cipher cipher = Cipher.getInstance(ALGORITHM);
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            byte[] originalData = cipher.doFinal(Base64.getDecoder().decode(encryptedData));
            return new String(originalData);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi giải mã", e);
        }
    }
}
