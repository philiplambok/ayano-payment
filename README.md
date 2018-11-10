# Ayano Payment
Ayano Payment is rails api-only project for learning tdd (Test driven development).

## Overview
Ayano payment or Ayano-Pay is payment or bank gateway service.

Core Features :

- Authentication
- Roles
- Users
- Deposits
- Transactions 
- Loggings

## Enpoints 
### Authentication

<!-- Sign in -->
<details>
  <summary> <b>Sign In</b> </summary>

  - **URL** 
  
    /api/auth

  - **Method**
  
    `POST`

  - **URL Params**
  
    None

  - **Data Params**

    ```json
    "auth": {
      "username": "your_username", 
      "password": "your_password"
    }
    ```

  - **Success Response** 

    ```json 
    {
      "jwt": "your_token"
    }
    ```

  - **Error Response** 
    
    Status | Message 
    --- | --- 
    422 | Sorry, username or password is wrong 

  - **Notes**

    For next request, add token in header: `Authorization: Bearer <your_token>`
</details>

### Roles 

<!-- show list roles -->
<details>
  <summary><b>Show List Roles</b></summary>

  - **URL** 
  
    /api/roles

  - **Method** 

    `GET`

  - **URL Params** 
    
    None

  - **Data Params** 

    None 

  - **Success Response** 

    ```json
    {
      "roles": [
        {
          "role": {
            "id": 1, 
            "name": "admin"
          }
        }, 
        {
          "role": {
            "id": 2, 
            "name": "member"
          }
        }
      ]
    } 
    ```
  
  - **Error Response** 

    Status | Message
    --- | --- 
    401 | Sorry, you're not authenticated 
    403 | Sorry, you don't have permission

  - **Notes** 

    Show list of roles just for admin 
</details>

<!-- create new role -->
<details>
  <summary><b>Create New Role</b></summary>

  - **URL**

    /api/roles/

  - **Method** 

    `POST`

  - **URL Params**

    None

  - **Data Params** 
  
    ```json
    {
      "role": {
        "id": 1, 
        "name": "admin"
      }
    }
    ```

  - **Success Response** 

    ```json
    {
      "role": {
        "id": 1, 
        "name": "admin"
      }
    }
    ```

  - **Error Response** 

    Status | Message
    --- | --- 
    422 | Name can't be blank
    401 | Sorry, you're not authenticated 
    403 | Sorry, you don't have permission 

  - **Notes** 

    Create new role just for admin.  
</details>

<!-- show role -->
<details>
  <summary><b>Show Role</b></summary>

  - **URL**

    /api/roles/:id
  
  - **Method**
  
    `GET`

  - **URL Params**

    **Required**

    `id=[integer]`

  - **Data Params**

    None

  - **Success Response**

    ```json
    {
      "role": {
        "id": 1, 
        "name": "admin"
      }
    }
    ```  

  - **Error Response** 

    Status | Message 
    401 | Sorry, you're not authenticated 
    403 | Sorry, you don't have permission
    404 | Sorry, role not found 

  - **Notes** 

    Show role just for admin
</details>

<!-- update role -->
<details>
  <summary><b>Update Role</b></summary>
  
  - **URL**

    /api/roles/:id
    
  - **Method** 

    `PUT` | `PATCH`

  - **URL Params** 

    **Required**
  
    `id=[integer]`

  - **Data Params** 
    
    ```json
    {
      "role": {
        "id": 1, 
        "name": "Admin Edit"
      }
    }
    ```    

  - **Success Response**

    ```json
    {
      "role": {
        "id": 1, 
        "name": "Admin Edit"
      }
    } 
    ```

  - **Error Response** 
    
    Status | Message 
    --- | --- 
    401 | Sorry, you're not authenticated 
    403 | Sorry, you don't have permission 
    422 | Name can't be blank, Role can't be blank 

  - **Notes** 
    
    Update role just for admin. 
</details>

<!-- delete role -->
<details>
  <summary><b>Delete Role</b></summary>

  - **URL** 

    /api/role/:id 

  - **Method** 

    `DELETE`

  - **URL Params** 

    None 

  - **Data Params** 

    None 

  - **Success Response**

    ```json 
    {
      "role": {
        "id": 1, 
        "name": "Admin Edit"
      }
    }
    ```

  - **Error Response** 

    Status | Message 
    401 | Sorry, you're not authenticated 
    403 | Sorry, you don't have permission 
    404 | Role not found

  - **Notes** 

    Delete role just for admin.
</details>

### Users 

<!-- show current user-->
<details>
  <summary><b>Show Current User</b></summary>

  - **URL** 

    /api/me 

  - **Method** 

    `GET`
  
  - **URL Params** 

    None

  - **Data Params** 

    None

  - **Success Response** 

    ```json
    {
      "user": {
        "id": 2, 
        "username": "pquest"
      }
    } 
    ```

  - **Error Response** 

    Status | Message 
    --- | --- 
    404 | User not found 

  - **Notes** 
    Don't check authenticated status when visit this.
</details>

<!-- create new user -->
<details>
  <summary><b>Create New User</b></summary>

  - **URL** 

    /api/users 

  - **Method** 

    `POST`

  - **URL Params** 

    None 

  - **Data Params** 
  
    ```json
    {
      "user": {
        "username": "chthonic", 
        "password": "secretcode", 
        "password_confirmation": "secretcode" 
      }
    } 
    ```
    
  - **Success Response**
    ```json
    {
      "user": {
        "id": 1,
        "username": "chthonic"
      }
    } 
    ```

    - **Error Response** 
      
      Status | Message 
      --- | --- 
      422 | Username can't be blank, Password can't be blank, Password doesn't match 
</details>

<!-- show user -->
<details>
  <summary><b>Show User</b></summary>

  - **URL**

    /api/users/:id

  - **Method** 

    `GET`

  - **URL Params** 
    
    **Required** 

    `id=[integer]`

  - **Data Params**

    None

  - **Success Response** 

    ```json
    {
      "user": {
        "id": 1, 
        "username": "pquest"
      }
    } 
    ```

  - **Error Response** 
    
    Status | Message 
    404 | User not found

</details>

<!-- update user -->
<details>
  <summary><b>Update User</b></summary>

  - **URL** 

    /api/users/:id

  - **Method** 

    `PUT` | `PATCH`

  - **URL Params** 

    **Required** 

    `id=[integer]`

  - **Data Params** 

    ```json
    {
      "user": {
        "username": "pquestedit", 
        "password": "secretcodeedit",
        "password_confirmation": "secretcodeedit"
      }
    } 
    ```

  - **Success Response**

    ```json
    {
      "user": {
        "username": "pquestedit"
      }
    } 
    ```

  - **Error Response** 

    Status | Message 
    401 | Sorry, you're not authenticated 
    403 | Sorry, you don't have permission
    404 | User not found 
    422 | Username can't be blank, Password can't be blank, Password doesn't match

  - **Notes** 

    This feature just can be used by owner or admin. 
</details>

<!-- delete user -->
<details>
  <summary><b>Delete User</b></summary>
  
  - **URL** 

    /api/users/:id 

  - **Method** 

    `DELETE`

  - **URL Params** 

    **Required** 

    `id=[integer]`

  - **Data Params**

    None

  - **Success Response** 

    ```json
    {
      "user": {
        "id": 1, 
        "username": "pquest"
      }
    } 
    ```

  - **Error Response** 
    
    Status | Message
    401 | Sorry, you're not authenticated 
    403 | Sorry, you don't have permission 

</details>

<!-- show user role -->
<details>
  <summary><b>Show User Role</b></summary>

  - **URL** 

    /api/users/:id/role 

  - **Method** 

    `GET`

  - **URL Params** 

    `id=[integer]`

  - **Data Params**

    None. 

  - **Success Response** 

    ```json
    {
      "role": {
        "id": 2,
        "name": "member"
      }
    } 
    ```

  - **Error Response** 

    Status | Message 
    401 | Sorry, you're not authenticated 
    403 | Sorry, you don't have permission
    404 | User not found

  - **Notes** 

    None. 

</details>

### Deposits 

<!-- show deposits -->
<details>
  <summary><b>Show Deposit</b></summary>
  
  - **URL** 

    /api/users/:id/deposits

  - **Method** 

    `GET`

  - **URL Params** 

    `id=[integer]`

  - **Data Params** 

    None

  - **Success Response** 

    ```json
    {
      "amount": "100000"
    } 
    ```

  - **Error Response** 

    Status | Message 
    --- | --- 
    401 | Sorry, you're not authenticated 
    403 | Sorry, you don't have permission
    404 | User not found

</details>

<!-- save deposits -->
<details>
  <summary><b>Save Deposit</b></summary>

  - **URL**

    /api/users/:id/deposits/
    
  - **Method** 

    `POST`

  - **URL Params** 
    
    **Required** 
    
    `id=[integer]`

  - **Data Params**

    ```json
    {
      "type": "save", 
      "ammount": "50000"
    } 
    ```

  - **Success Response** 

    ```json
    {
      "amount": "150000"
    }
    ```

  - **Error Response** 

    Status | Message 
    --- | --- 
    401 | Sorry, you're not authenticated 
    403 | Sorry, you haven't permission 
    404 | User not found 
  
  - **Notes** 

    None
</details>

<!-- take deposits -->
<details>
  <summary><b>Take Deposit</b></summary>
  
  - **URL** 
    
    /api/users/:id/deposits

  - **Method** 
  
    `POST`

  - **URL Params** 

    `id=[integer]`

  - **Data Params** 

    ```json
    {
      "type": "take", 
      "amount": "70000"
    } 
    ```

  - **Success Response** 

    ```json
    {
      "amount": "80000"
    } 
    ```

  - **Error Response** 

    Status | Message 
    401 | Sorry, you're not authenticated
    403 | Sorry, you don't have permission
    404 | User not found 
    422 | Sorry, your deposit is not enough

  - **Notes**

    None.
</details>

### Transaction
<!-- create transaction -->
<details>
  <summary><b>Add Transaction</b></summary>

  - **URL** 

    /api/users/:id/transactions

  - **Method** 

    `POST`

  - **URL Params** 

    **Required** 

    `id=[integer]`

  - **Data Params** 

    ```json
    {
      "transaction": {
        "to": 1,
        "amount": "50000" 
      }
    }
    ```

  - **Success Response** 

    ```json
    {
      "deposit": {
        "ammount": "100000"
      }
    } 
    ```

  - **Error Response** 
    
    Status | Message 
    --- | ---
    401 | Sorry, you're not authenticated 
    403 | Sorry, you don't have permission 
    404 | Sorry, user not found 
    422 | Sorry, your deposit is not enough

  - **Notes** 

    `transaction.to` is value of `user_id`
</details>

### Logs
<!-- create logs -->
<details>
  <summary><b>Show Logs</b></summary>

  - **URL** 

    /api/users/:id/logs 
  
  - **Method** 
  
    `GET`

  - **URL Params**

    `id=[integer]`

  - **Data Params** 
    
    None.

  - **Success Response** 

    ```json
    {
      "logs": [
        {
          "log": {
            "message": "You send 200000 to pquest",
            "created_at": "27-08-2017 15:30"
          }
        }, 
        {
          "log": {
            "message": "You take deposit 100000",
            "created_at": "27-08-2017 12:30"
          }
        }, 
        {
          "log": {
            "message": "You added deposit 500000",
            "created_at": "27-08-2017 10:30"
          }
        }, 
      ]
    } 
    ```

  - **Error Response**

    Status | Message 
    --- | ---
    401 | Sorry, you're not authenticated 
    403 | Sorry, you don't have permission
    404 | User not found 

  - **Notes** 

    None. 
</details>

## Usage 
1. Clone the repo
2. Run `bundle` 
3. Run `bin/rspec` to test that everything works. 
3. Run `rails s`
4. Test with api-tester like `curl` / `postman` / etc.. 

## Version 
Last Releases: [v1.0](https://github.com/philiplambok/ayano-payment/releases) 

## Licenses
MIT License. 