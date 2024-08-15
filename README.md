# money_send_app

A flutter app project created for a certain companiy software engineering test.

<img src="https://github.com/user-attachments/assets/f5272f8e-edda-4f3f-9490-06d035d73513" height=500> 


## Getting Started

- Flutter version: `3.24.0`
- Flutter manager used: puro

## How to Run

First we need to run setup the fake API server. To do this, follow these steps:

1. Install the required dependencies:

   ```bash
   npm install json-server
   ```

2. Start the fake API server:

   ```bash
    npx json-server db.json
   ```

3. The fake API server will start running on `http://localhost:3000`.

To run the **Money Send App** project, follow these steps:

1. Install the required dependencies:

   ```bash
   flutter pub get
   ```

2. Start the app:

   ```bash
   flutter run --dart-define=API_URL=http://localhost:3000
   ```

   This will launch the app on the connected device or emulator. The `API_URL` environment variable is used to specify the URL of the fake API server. Change the value of `API_URL` if the fake API server is running on a different URL.

> If you are using android emulator, you may want to use `10.0.2.2:3000` as the `API_URL` instead of `localhost:3000`.

## Features

- **Wallet Balance**

  - [x] View the current balance in the wallet.
  - [x] Show 500.00php as user's current balance.
  - [x] Ability to show and hide the balance

- **Send Money**

  - [x] Input field that accepts numbers.
  - [x] Bottom sheet on success/error indicator on transaction response
  - [x] Send money to another user by entering the amount

- **Transaction History**
  - [x] View the transaction history of the wallet
  - [x] Show details like the amount send and timestamp

## Technical

- [x] Unit Test
- [x] Uses fake API <https://jsonplaceholder.typicode.com/>
- [x] Clean architecture with flutter_bloc
- [x] Uses flutter

## Tests

To run the tests, use the following command:

```bash
flutter test
```
