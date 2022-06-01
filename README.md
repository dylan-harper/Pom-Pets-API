# Pom Pets API / Backend

This is a REST API built in Ruby 2.7.2 and Rails 5.2.6 to serve as a database (psql) for a Mod 3 FE React Native project.

CI: GitHub Actions
CD: Heroku Pipeline (staging)

This app exposes endpoints to create users, projects, and return a user and their associated projects. 

Available endpoints:

#### Create New User: Persists a single user's information to the database

<details>
  <summary> Request </summary>
  
  *POST https://pom-pets-api.herokuapp.com/api/v1/users*
  
  ```
      {
        "username": "Ross",
        "email": "ross@vanMail.com",
        "profilePhoto": "url/ross-in-van.png",
        "settings": {
          "workTime": 25,
          "shortPomTime": 5,
          "longPomTime": 10
        }
      }
  ```
  </details>
  
  <details>
    <summary> Response </summary>
  
```  
    {
        "data": {
            "id": "1",
            "type": "user",
            "attributes": {
                "id": 1,
                "username": "Ross",
                "email": "ross@vanMail.com",
                "profilePhoto": "url/ross-in-van.png",
                "settings": {
                    "workTime": "25",
                    "shortPomTime": "5",
                    "longPomTime": "10"
                }
            }
        }
    }
```
</details>
