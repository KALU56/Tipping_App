

# 💸 Tipping App

[![Watch Overall Demo](assets/tipping_app_demo.png)](https://youtu.be/your_overall_demo_video)

This repository contains a **two-sided tipping platform** built in Flutter:

* **tip_give** — for customers to send tips
* **tip_employ** — for employees to receive & manage tips

---

## 📂 Project Structure

```
Tipping_App/
│
├── tip_give/       # Customer app (send tips)
├── tip_employ/     # Employee app (receive tips)
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

* Flutter / Dart
* Firebase Authentication
* Cloud Firestore
* Payment SDK (Stripe / PayPal etc.)
* Push Notifications
* State Management (Bloc / Provider)

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

### 4️⃣ Configure environment variables

Create a `.env` or config file. Example:

```env
API_BASE_URL=https://your-backend.com
PAYMENT_KEY=your_payment_key   # only needed in tip_give
```

---

## 🎮 How It Works

### Customer Flow (tip_give)

1. Log in / sign up
2. Browse list of employees
3. Select an employee → enter tip amount → confirm
4. View receipt & tip history

### Employee Flow (tip_employ)

1. Log in / register
2. See incoming tips in real time
3. Get notifications when tipped
4. Check history
5. Withdraw funds

---

## 🖼️ Screenshots

| tip_give Home              | tip_give Send Tip          | tip_employ Dashboard              | tip_employ History              |
| -------------------------- | -------------------------- | --------------------------------- | ------------------------------- |
| `assets/tip_give_home.png` | `assets/tip_give_send.png` | `assets/tip_employ_dashboard.png` | `assets/tip_employ_history.png` |

*(Replace these with your real screenshots paths)*

---

## 📊 Data Flow (APIs / Endpoints)

* **Customers (tip_give):**

  * `GET /employees` → list employees
  * `POST /tip` → send tip
  * `GET /tip-history` → view past tips

* **Employees (tip_employ):**

  * `GET /my-tips` → fetch received tips
  * `POST /withdraw` → withdraw funds
  * `GET /profile` → employee info

---

## 🤝 Contributing

1. Fork the repository
2. Create a branch: `git checkout -b feature/your-feature`
3. Make changes & commit: `git commit -m "Add feature"`
4. Push branch: `git push origin feature/your-feature`
5. Open a Pull Request

---

## 📜 License

This project is licensed under the **MIT License**.
See the [LICENSE](LICENSE) file for details.

---

If you like, I can also generate a **beautiful architecture diagram** (image or ASCII) showing how both apps connect to a backend — that will help others understand the flow quickly in the README. Do you want me to make that too?
