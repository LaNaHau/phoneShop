# 📱 PhoneShop

**PhoneShop** là dự án Website **quản lý và bán điện thoại trực tuyến**, được xây dựng bằng **Java Web (Servlet/JSP, Hibernate)** theo mô hình MVC.  
Hệ thống cung cấp các chức năng chính:
- 👤 Quản lý người dùng (đăng ký, đăng nhập, phân quyền: Admin / Staff / Customer).  
- 📦 Quản lý sản phẩm (điện thoại, thông tin chi tiết, giá, số lượng).  
- 🛒 Giỏ hàng và đặt hàng trực tuyến.  
- 📊 Quản lý đơn hàng, theo dõi trạng thái.  
- 🔒 Tích hợp các biện pháp bảo mật dựa trên **OWASP Top 10** (ngăn SQL Injection, XSS, quản lý session, mã hóa mật khẩu, phân quyền…).  

---

## ⚡ Công nghệ sử dụng
- **Ngôn ngữ lập trình**: Java (JDK 8+)  
- **Framework / Thư viện**: 
  - **Servlet/JSP** – xử lý logic và giao diện phía server.  
  - **Hibernate ORM** – ánh xạ đối tượng với cơ sở dữ liệu.  
  - **JSTL (JSP Standard Tag Library)** – xử lý logic trong JSP.  
  - **Bootstrap, CSS, JavaScript** – xây dựng giao diện web thân thiện.  
- **Máy chủ ứng dụng**: Apache Tomcat 9+  
- **Cơ sở dữ liệu**: MySQL 5.7/8.0  
- **Quản lý dự án & phụ thuộc**: Maven 3.6+  
- **Quản lý phiên bản**: Git & GitHub  

---

## ☕ Đặc trưng Java trong dự án
Dự án PhoneShop tận dụng các đặc điểm nổi bật của Java:
- **Hướng đối tượng (OOP)**  
  - Đóng gói (`Encapsulation`) dữ liệu người dùng, sản phẩm, đơn hàng thành các class riêng.  
  - Kế thừa (`Inheritance`) giữa các lớp entity và base class.  
  - Đa hình (`Polymorphism`) khi xử lý nhiều loại sản phẩm hoặc hành vi người dùng.  
- **Độc lập nền tảng (Write Once, Run Anywhere)**  
  - Chạy được trên nhiều môi trường chỉ cần có JVM.  
- **Quản lý bộ nhớ tự động (Garbage Collection)**  
  - Giảm thiểu lỗi rò rỉ bộ nhớ khi xử lý session và dữ liệu lớn.  
- **Thư viện phong phú**  
  - Sử dụng API chuẩn Java (JDBC, Servlet API, Collections).  
- **Bảo mật mạnh mẽ**  
  - Hỗ trợ các cơ chế mã hóa, quản lý session và bảo vệ an toàn.  
- **Hỗ trợ đa luồng (Multithreading)**  
  - Server có thể xử lý nhiều request người dùng đồng thời.  

---

## 🚀 Yêu cầu môi trường
- **Java JDK**: Phiên bản 8 trở lên  
- **Eclipse IDE for Enterprise Java Developers**  
- **Apache Tomcat**: Phiên bản 9 trở lên  
- **MySQL**: 5.7 hoặc 8.0  
- **Maven**: 3.6 trở lên  
- **Trình duyệt web**: Chrome / Firefox / Edge  

---

## 📥 Clone dự án
```bash
git clone https://github.com/LaNaHau/phoneShop.git
