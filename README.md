# 💸 Tipping App

This repository contains a **two-sided tipping platform** built in Flutter with a Laravel backend:

* **tip_give** — for customers to send tips
* **tip_employ** — for employees to receive & manage tips

---

## 📂 Project Structure

```
Tipping_App/
│
├── tip_give/       # Customer app (send tips)
├── tip_employ/     # Employee app (receive tips)
├── backend/        # Laravel backend (API)
└── README.md       # This file
```

---

## ✨ Features

### 🧑‍💼 tip_give (Customer Side)

* Sign up / Login
* Browse employees
* Send tips (with payments)
* View tip history & receipts
* Notifications for tipping status

### 👔 tip_employ (Employee Side)

* Employee login / registration
* Profile management
* View incoming tips
* Tip history & details
* Notifications for new tips
* Withdraw funds

---

## 🎥 Demo Videos

* **tip_employ Demo** — click below
  [![tip\_employ Demo](https://img.youtube.com/vi/dALlBdwtitY/0.jpg)](https://youtube.com/shorts/dALlBdwtitY)

* **tip_give Demo** — click below
  [![tip\_give Demo](https://img.youtube.com/vi/GKrOXeTtU4A/0.jpg)](https://youtube.com/shorts/GKrOXeTtU4A)

---

## 🛠️ Tech Stack

* **Frontend:** Flutter / Dart
* **Backend:** Laravel / PHP
* **Database:** MySQL / Firestore hybrid
* **Authentication:** Firebase Auth + Laravel Sanctum
* **Payments:**  chapa
* **State Management:** Bloc / Provider

---

## 🚀 Getting Started

### 1️⃣ Clone the repo

```bash
git clone https://github.com/KALU56/Tipping_App.git
```

### 2️⃣ Choose which app to run

```bash
cd Tipping_App/tip_give   # for the customer app  
# or  
cd Tipping_App/tip_employ # for the employee app
```

### 3️⃣ Install dependencies & run

```bash
flutter pub get
flutter run
```



## 📡 API Reference


### 💳 Payment / Tipping

| Method | Endpoint          | Description                      |
| ------ | ----------------- | -------------------------------- |
| `POST` | `/verify-payment` | Verify a tip payment transaction |
| `GET`  | `/tip/{id}`       | Process a tip by ID              |

---

### 🏢 Service Providers

| Method  | Endpoint                                       | Description         
| ------- | ---------------------------------------------- | --------------------- 
| `POST`  | `/service-providers/register`                  | Register new provider 
| `POST`  | `/service-providers/login`                     | Login provider    
| `POST`  | `/service-providers/verify-email`              | Verify email     
| `GET`   | `/service-providers/profile`                   | Get provider profile
| `POST`  | `/service-providers/logout`                    | Logout               
| `GET`   | `/service-providers/employees`                 | Get employees data   
| `POST`  | `/service-providers/employees/register`        | Register employees    


---

### 👔 Employees

| Method | Endpoint                   | Description         
| ------ | -------------------------- | --------------------- 
| `POST` | `/employees/register`      | Complete registration 
| `POST` | `/employees/login`         | Login employee     
| `POST` | `/employees/verify-email`  | Verify email         
| `POST` | `/employees/logout`        | Logout               
| `POST` | `/employees/set-bank-info` | Set bank info         
| `GET`  | `/employees/transactions`  | View transactions     

---

### 👤 Employee Profile (current user)

| Method   | Endpoint                 | Description          
| -------- | ------------------------ | -------------------- 
| `GET`    | `/employee/profile`      | Get employee profile 
| `PUT`    | `/employee/profile`      | Update profile       
| `PUT`    | `/employee/password`     | Update password      
| `DELETE` | `/employee/account`      | Deactivate account   
| `GET`    | `/employee/bank-account` | Get bank account     
| `PUT`    | `/employee/bank-account` | Update bank account  


