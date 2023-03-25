# Wallet API Project - Pennywise

## Table of Contents

- [About](#about)
- [Usage](#usage)
- [Getting Started](#getting_started)
- [Test the API (Locally)](#test_the_API)
- [API Specificiations Docs](./docs/api_specifications.md)

## About <a name = "about"></a>

This is a basic wallet API that allows for secure financial transactions including funding your wallet with a debit card and sending money to other banks. I built this project as part of my course requirements for the Software Engineering program at Altschool Africa.

## Usage <a name = "usage"></a>

- [API Specificiations Docs](./docs/api_specifications.md)
- [API Swagger Documentation](https://pennywise.onrender.com/docs)

## Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

```
ruby
rails
postgres
```

### Setting up a development environment

#### Step 1: Clone the repository

```
git clone https://github.com/benessilfie/pennywise.git
```

or with Github CLI

```
gh repo clone benessilfie/pennywise
```

#### Step 2: Run Bundle install

```
bundle install
```

#### Step 3: Create a .env file in the root directory and add your paystack secret key

```
PAYSTACK_SECRET_KEY=add_your_secret_key
```

> You can [create a free account](https://dashboard.paystack.com/#/signup?_id=null) on paystack to get a secret key

#### Step 4: start the server

```
rails start
```

## Test the API (Locally) <a name = "test_the_API"></a>

- You can either go to the interactive swagger documentation at `http://localhost:3000/docs` or use the api testing tool of your choice.

- You'll find the API documentation with the base URL and various endpoints [here](./docs/api_specifications.md)

### Example

#### Creating a user account

- curl

```bash
curl --location --request POST 'http://localhost:3000/api/user' \
--header 'Content-Type: application/json' \
--data-raw '{
    "first_name": "Sir",
    "last_name": "Testsalot",
    "email": "test@example.com",
    "password": "password",
    "dob": "01-01-1999",
    "address": "22 Mars Lane"
}'
```

- httpie

```
http -v :3000/api/user first_name=Sir last_name=Testsalot \
email=test@example.com password=password \
dob=01-01-1999 address="22 Mars Lane"
```

- postman

```bash
{
    "first_name": "Sir",
    "last_name": "Testsalot",
    "email": "test@hexample.com",
    "password": "password",
    "dob": "01-01-1999",
    "address": "22 Mars Lane"
}
```

#### Response

```bash
{
    "message": "User created successfully",
    "data": {
        "id": 3,
        "first_name": "Sir",
        "last_name": "Testsalot",
        "email": "test@example.com",
        "password_digest": "$2a$12$Tp9YY1b8JNIITq25k.DDP.vkPb3cuIcNBwH4QK5XeD3ntoUdpMmlS",
        "dob": "01-01-1999",
        "address": "22 Mars Lane",
        "auth_token": null,
        "created_at": "2023-03-17T13:56:59.412Z",
        "updated_at": "2023-03-17T13:56:59.412Z",
        "wallet": {
            "id": 3,
            "user_id": 3,
            "balance": 0,
            "status": "active",
            "created_at": "2023-03-17T13:56:59.422Z",
            "updated_at": "2023-03-17T13:56:59.422Z",
            "transactions": [],
            "debit_cards": []
        }
    }
}
```

## Author

[Benjamin Essilfie Quansah](https://www.linkedin.com/in/benessilfie/)
