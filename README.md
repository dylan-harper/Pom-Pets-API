# Pom Pets API / Backend
This is a REST API built in Ruby 2.7.2 and Rails 5.2.6 to serve as a database (psql) for a Mod 3 FE React Native project.
This app exposes endpoints to create users, projects, and return a user and their associated projects. 

Available endpoints:

#### 1. Create New User: Persists a single user's information to the database

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

#### 2. Create New Project: Persists a new project's information to the database

<details>
  <summary> Request </summary>
  
  *POST https://pom-pets-api.herokuapp.com/api/v1/projects*
  
  ```
      {
        "projectName": "stretch-tech",
        "petHealth": 3,
        "petLevel": 1,
        "projectPet": "tomato",
        "projectGitHub": "url/ross-van-stretch-tech.com",
        "petImage": "url/PigeonPet.png",
        "user_id": 1,
        "stats": {
          "totalWorkTime": 175,
          "totalWorkSessions": 5,
          "totalShortPomTime": 45,
          "totalShortSessions": 8,
          "totalLongPomTime": 100,
          "totalLongSessions": 4
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
        "type": "project",
        "attributes": {
            "projectName": "stretch-tech",
            "projectPet": "tomato",
            "petHealth": 3,
            "petLevel": 1,
            "projectGitHub": "url/ross-van-stretch-tech.com",
            "petImage": "url/PigeonPet.png",
            "user_id": 1,
            "stats": {
                "totalWorkTime": "175",
                "totalWorkSessions": "5",
                "totalShortPomTime": "45",
                "totalShortSessions": "8",
                "totalLongPomTime": "100",
                "totalLongSessions": "4"
            }
        },
        "relationships": {
            "user": {
                "data": {
                    "id": "1",
                    "type": "user"
                }
            }
        }
    }
}
```
</details>


CI: GitHub Actions
CD: Heroku Pipeline (staging)
