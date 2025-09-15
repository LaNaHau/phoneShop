package ptithcm.encrypt;

import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class DesEncrypt {
	public static String desKey = "n4awcsdl"; // DES key (8 bytes)

	// DES Encryption
    public static String desEncrypt(String plaintext, String key) throws Exception {
        if (key.length() != 8) {
            throw new IllegalArgumentException("DES key must be 8 characters long.");
        }
        Cipher cipher = Cipher.getInstance("DES");
        SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(), "DES");
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        byte[] encrypted = cipher.doFinal(plaintext.getBytes());
        return Base64.getEncoder().encodeToString(encrypted);
    }

    // DES Decryption
    public static String desDecrypt(String ciphertext, String key) throws Exception {
        if (key.length() != 8) {
            throw new IllegalArgumentException("DES key must be 8 characters long.");
        }
        Cipher cipher = Cipher.getInstance("DES");
        SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(), "DES");
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        byte[] decrypted = cipher.doFinal(Base64.getDecoder().decode(ciphertext));
        return new String(decrypted);
    }
    
    public static void main(String[] args) throws Exception {
        String plaintext = "0783549543";
        String ciphertext = desEncrypt(plaintext, desKey);
        System.out.println("Ciphertext: " + ciphertext);
        
        String decryptedText = desDecrypt(ciphertext, desKey);
        System.out.println("Decrypted text: " + decryptedText);
    }
}
