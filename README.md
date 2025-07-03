
# DoConnect_Narendra - Backend Service

This is the backend API module for **DoConnect**, a Question & Answer platform similar to Stack Overflow. This Spring Boot-based microservice handles core backend functionalities such as user authentication, posting questions and answers, and moderation support.

---

## 🛠️ Tech Stack

- Java 17
- Spring Boot
- Spring MVC
- Hibernate & JPA
- MySQL
- Maven

---

## 📁 Project Structure

Doconnect_Manideep/

├── src/
│   ├── main/
│   │   ├── java/
│   │   └── resources/
├── pom.xml
└── mvnw, .gitignore, etc.

---

## 🚀 Features

- ✅ User Registration & Login
- ✅ Ask / Answer / Comment on Questions
- ✅ Admin Moderation Panel (for question/answer/comment approval)
- ✅ Role-based access control

---

## 🧪 API Endpoints (Example)

| HTTP Method | Endpoint                    | Description                  |
|-------------|-----------------------------|------------------------------|
| POST        | /portal/auth/login          | Authenticate user            |
| POST        | /portal/register            | Register a new user          |
| GET         | /portal/questions           | Get all approved questions   |
| POST        | /portal/questions/ask       | Ask a new question           |
| POST        | /portal/answers/post        | Post an answer               |
| GET         | /adminsonly/users           | Admin: View all users        |
| GET         | /adminsonly/questions       | Admin: Review questions      |

---


## 🔐 Security

- Role-based access (`USER`, `ADMIN`)
- Session handling with token expiry

---

## 📦 Database Setup

- Use MySQL for production (update in `application.properties`).

---

## 🧰 Dependencies

<dependencies>
  Spring Boot Starter Web
  Spring Boot Starter Security
  Spring Boot Starter Data JPA
  MySQL Driver 
</dependencies>

---

## 📄 License

This project is developed as part of internal learning and submission. All rights reserved by **Bhupathi Manideep**.

---

## 🙋‍♂️ Author

**Narendra Nandagiri**  
Software Developer | Java | Spring Boot | Microservices  
Final Project – DoConnect
