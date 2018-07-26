# Ayano Payment
Ayano Payment is rails api-only project for learning tdd (Test driven developemt).

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

    ```json 
    {
      "error": {
        "code": 422, 
        "message": "Sorry, username or password is wrong"
      }
    } 
    ```

  - **Notes**

    For next request, add token in header: `Authorization: Bearer <your_token>`
</details>

### Roles 

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

    ```json
    {
      "error": {
        "code": 422, 
        "message": "Name can't be blank"
      }
    }
    ```

    ```json
    {
      "error": {
        "code": 401, 
        "message": "Sorry, you're not authenticated"
      }
    }
    ```

    ```json
    {
      "error": {
        "code": 403,
        "message": "Sorry, you haven't permission"
      }
    }
    ```

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

    ```json
    {
      "error": {
        "code": 404, 
        "message": "Sorry, role not found"
      }
    } 
    ```

    ```json
    {
      "error": {
        "code": 401, 
        "message": "Sorry, you're not authenticated"
      }
    } 
    ```

    ```json
    {
      "error": {
        "code": 403, 
        "message": "Sorry, you haven't permission"
      }
    } 
    ```

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
    
    ```json 
    {
      "error": {
        "code": 422,
        "message": "Sorry, role not found" 
      }
    }
    ```

    ```json 
    {
      "error": {
        "code": 422,
        "message": "Name can't be blank" 
      }
    }
    ```
  
    ```json
    {
      "error": {
        "code": 401, 
        "message": "Sorry, you're not authenticated"
      }
    } 
    ```

    ```json
    {
      "error": {
        "code": 403, 
        "message": "Sorry, you haven't permission"
      }
    } 
    ```

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

    ```json
    {
      "error": {
        "code": 404, 
        "message": "Sorry, role not found"
      }
    } 
    ```

    ```json 
    {
      "error": {
        "code": 401, 
        "message": "Sorry, you're not authenticated"
      }
    }
    ```

    ```json
    {
      "error": {
        "code": 403, 
        "message": "Sorry, you haven't permission"
      }
    } 
    ```
  
  - **Notes** 

    Delete role just for admin.
</details>

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

    ```json
    {
      "error": {
        "code": 401,
        "message": "Sorry, you're not authenticated"
      }
    } 
    ```

    ```json
    {
      "error": {
        "code": 403, 
        "message": "Sorry, you haven't permission"
      }
    } 
    ```

  - **Notes** 

    Show list of roles just for admin 
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

    ```json
    {
      "error": {
        "code": 404, 
        "message": "Sorry, you're user not found"
      }
    } 
    ```
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
      
      ```json 
      {
        "error": {
          "code": 422, 
          "message": "Username can't be blank"
        }
      }
      ```

       ```json 
      {
        "error": {
          "code": 422, 
          "message": "Password can't be blank"
        }
      }
      ```

       ```json 
      {
        "error": {
          "code": 422, 
          "message": "Password doesn't match"
        }
      }
      ```

       ```json 
      {
        "error": {
          "code": 422, 
          "message": "Username has already been taken"
        }
      }
      ```
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

    ```json
    {
      "error": {
        "code": 404, 
        "message": "Sorry, user not found"
      }
    } 
    ```
  
  - **Notes** 

    None
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

    ```json
    {
      "error": {
        "code": 404, 
        "message": "Sorry, user not found"
      }
    } 
    ```

    ```json
    {
      "error": {
        "code": 422, 
        "message": "Username can't be blank"
      }
    } 
    ```

    ```json
    {
      "error": {
        "code": 422, 
        "message": "Password can't be blank"
      }
    } 
    ```

    ```json
    {
      "error": {
        "code": 422, 
        "message": "Passoword doesn't match"
      }
    } 
    ```

    ```json
    {
      "error": {
        "code": 401, 
        "message": "Sorry, you're not authenticated"
      }
    } 
    ```

    ```json
    {
      "error": {
        "code": 403, 
        "message": "Sorry, you haven't permission"
      }
    } 
    ```

  - **Notes** 

    This feature just for owner or admin. 
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
    
    ```json
    {
      "error": {
        "code": 401, 
        "message": "Sorry, you're not authenticated" 
      }
    } 
    ```

    ```json
    {
      "error": {
        "code": 403, 
        "message": "Sorry, you haven't permission"
      }
    } 
    ```
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

    ```json
    {
      "error": {
        "code": 404, 
        "message": "Sorry, user not found" 
      }
    }
    ```

    ```json
    {
      "error": {
        "code": 401, 
        "message": "Sorry, you're not authenticated" 
      }
    }
    ```

    ```json
    {
      "error": {
        "code": 404, 
        "message": "Sorry, you haven't permission" 
      }
    }
    ```

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
      "deposit": {
        "amount": "100,000.00"
      }
    } 
    ```

  - **Error Response** 

    ```json 
    {
      "error": {
        "code": 404, 
        "message": "Sorry, user not found"
      }
    }
    ```

    ```json
    {
      "error": {
        "code": 401, 
        "message": "Sorry, you're not authenticated"
      }
    } 
    ```

    ```json
    {
      "error": {
        "code": 403, 
        "message": "Sorry, you haven't permission"
      }
    }
    ```
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
      "ammount": "50,000.00"
    } 
    ```

  - **Success Response** 

    ```json
    {
      "deposit": {
        "amount": "150,000.00"
      }
    }
    ```

  - **Error Response** 

    ```json
    {
      "error": {
        "code": 404, 
        "message": "Sorry, user not found"
      }
    } 
    ```

    ```json
    {
      "error": {
        "code": 401, 
        "message": "Sorry, you're not authenticated"
      }
    } 
    ```

    ```json
    {
      "error": {
        "code": 403,
        "message": "Sorry, you haven't permission" 
      }
    } 
    ```
  
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
      "deposit": {
        "type": "take", 
        "amount": "70,000.00"
      }
    } 
    ```

  - **Success Response** 

    ```json
    {
      "deposit": {
        "amount": "80,000.00"
      }
    } 
    ```

  - **Error Response** 
    ```json
    {
      "error": {
        "code": 404,
        "message": "Sorry, user not found"
      }
    } 
    ```

    ```json
    {
      "error": {
        "code": 422, 
        "message": "Sorry, your deposit is not enough"
      }
    } 
    ```

    ```json 
    {
      "error": {
        "code": 401, 
        "message": "Sorry, you're not authenticated"
      }
    }
    ```

    ```json 
    {
      "error": {
        "code": 403, 
        "message": "Sorry, you haven't permission"
      }
    }
    ```

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
        "amount": "50,000.00" 
      }
    }
    ```

  - **Success Response** 

    ```json
    {
      "deposit": {
        "ammount": "100,000.00"
      }
    } 
    ```

  - **Error Response** 
  
    ```json
    {
      "error": {
        "code": 422, 
        "message": "Sorry, your deposit is not enough"
      }
    } 
    ```

    ```json
    {
      "error": {
        "code": 404, 
        "message": "Sorry, user not found"
      }
    } 
    ```

    ```json
    {
      "error": {
        "code": 401, 
        "message": "Sorry, you're not authenticated"
      }
    } 
    ```

    ```json
    {
      "error": {
        "code": 403, 
        "message": "Sorry, you haven't permission"
      }
    } 
    ```

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
            "message": "You send 200,000.00 to pquest",
            "created_at": "27-08-2017 15:30"
          }
        }, 
        {
          "log": {
            "message": "You take deposit 100,000.00 ",
            "created_at": "27-08-2017 12:30"
          }
        }, 
        {
          "log": {
            "message": "You added deposit 500,000.00 ",
            "created_at": "27-08-2017 10:30"
          }
        }, 
      ]
    } 
    ```

  - **Error Response**

    ```json
    {
      "error": {
        "code": 404, 
        "message": "Sorry, user not found"
      }
    } 
    ``` 

    ```json
    {
      "error": {
        "code": 401, 
        "message": "Sorry, you're not authenticated"
      }
    } 
    ```

    ```json
    {
      "error": {
        "code": 401, 
        "message": "Sorry, you haven't permission"
      }
    } 
    ```

  - **Notes** 

    None. 
</details>