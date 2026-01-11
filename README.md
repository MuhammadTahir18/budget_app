# Budget App 📊💰

**(Urdu)**: Yeh README file Budget App ke liye hai jo **Flutter** me banayi gayi hai aur **Provider**, **Riverpod**, **Firebase Authentication**, aur **Cloud Firestore** use karti hai. App user ki **income ke mutabiq budget calculate** karta hai aur expenses track karta hai.

---

## 🚀 Features

* 🔐 **Firebase Authentication** (Email/Password)
* ☁️ **Cloud Firestore** for real-time data storage
* 🧠 **State Management**

  * Provider (basic app state)
  * Riverpod (scalable & testable logic)
* 💵 **Income-based Budget Calculation**
* 🧾 Add / Edit / Delete Expenses
* 📈 Remaining budget auto-update
* 🔄 Real-time sync across devices

---

## 🛠 Tech Stack

* **Flutter** (Dart)
* **Firebase Authentication**
* **Cloud Firestore**
* **Provider**
* **Riverpod**

---

## 📱 App Flow

1. User **Sign Up / Login** karta hai
2. User apni **Monthly Income** enter karta hai
3. User **Expenses add** karta hai (Food, Rent, Transport, etc.)
4. App automatically:

   * Total Expenses calculate karta hai
   * Remaining Budget show karta hai
5. Saara data **Firestore** me save hota hai

---

## 🧮 Budget Calculation Logic

```text
Remaining Budget = Monthly Income − Total Expenses
```

Example:

* Income: 50,000
* Expenses: 32,000
* Remaining Budget: **18,000**

---

## 🔐 Firebase Authentication

* Email & Password based login
* Firebase handles:

  * User creation
  * Login session
  * Logout

Each user ka data **securely** Firestore me store hota hai.

---

## ☁️ Firestore Database Structure

```text
users (collection)
 └── userId (document)
     ├── name: string
     ├── email: string
     ├── income: number
     └── expenses (sub-collection)
         └── expenseId (document)
             ├── title: string
             ├── amount: number
             ├── category: string
             └── date: timestamp
```

---

## 🧠 State Management

### Provider

* UI-related simple states
* Form loading / button states

### Riverpod

* Business logic
* Firestore streams
* Budget calculation providers

Riverpod app ko **clean**, **scalable**, aur **testable** banata hai.

---

## ▶️ How to Run the Project

1. Flutter install karein
2. Project clone karein
3. Firebase project create karein
4. `google-services.json` add karein
5. Commands run karein:

```bash
flutter pub get
flutter run
```

---

## 📦 Dependencies Used

```yaml
firebase_core
firebase_auth
cloud_firestore
provider
hooks_riverpod
```

---

## 🔮 Future Improvements

* 📊 Monthly charts & analytics
* 🏦 Multiple income sources
* 📤 Export data (PDF / Excel)
* 🌙 Dark Mode
* 🔔 Budget limit notifications

---

## 👨‍💻 Author

**Muhammad Tahir**
Flutter & Android Developer

---


