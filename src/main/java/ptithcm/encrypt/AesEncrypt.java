package ptithcm.encrypt;

import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class AesEncrypt {
	
	public static String aesKey128 = "nhom421atatwcsdl"; // AES-128 key (16 bytes)
	public static String aesKey256 = "21atnhom4anwdwvcsdlyhbsn34jjab85"; // AES-256 key (32 bytes)
	 // AES Encryption
    public static String aesEncrypt(String plaintext, String key) throws Exception {
        if (key.length() != 16 && key.length() != 32) {
            throw new IllegalArgumentException("AES key must be 16 (AES-128) or 32 (AES-256) characters long.");
        }
        Cipher cipher = Cipher.getInstance("AES");
        SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(), "AES");
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        byte[] encrypted = cipher.doFinal(plaintext.getBytes());
        return Base64.getEncoder().encodeToString(encrypted);
    }

    // AES Decryption
    public static String aesDecrypt(String ciphertext, String key) throws Exception {
        if (key.length() != 16 && key.length() != 32) {
            throw new IllegalArgumentException("AES key must be 16 (AES-128) or 32 (AES-256) characters long.");
        }
        Cipher cipher = Cipher.getInstance("AES");
        SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(), "AES");
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        byte[] decrypted = cipher.doFinal(Base64.getDecoder().decode(ciphertext));
        return new String(decrypted);
    }
    
    public static void main(String[] args) throws Exception {
        String plaintext = "haha";
        String plaintext2 = "trongthai456@gmail.com";
        String ciphertext = aesEncrypt(plaintext, aesKey128);
        System.out.println("Ciphertext AES 128: " + ciphertext);
        
        String decryptedText = aesDecrypt(ciphertext, aesKey128);
        System.out.println("Decrypted text AES 128: " + decryptedText);
        System.out.println("---------------------------------------------");
        
        String ciphertext2 = aesEncrypt(plaintext2, aesKey256);
        System.out.println("Ciphertext AES 256: " + ciphertext2);
        
        String decryptedText2 = aesDecrypt(ciphertext2, aesKey256);
        System.out.println("Decrypted text AES 256: " + decryptedText2);
    }
}
