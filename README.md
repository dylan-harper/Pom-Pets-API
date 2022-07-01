# Pom Pets API / Backend
This is a REST API built in Ruby 2.7.2 and Rails 5.2.6 to serve as a database (psql) for a Mod 3 FE React Native project.
This app exposes endpoints to create users, projects, and return a user and their associated projects. 

* CI: GitHub Actions
* CD: Heroku Pipeline (staging)

Available endpoints:

---

#### 1. Create New User: Persists a single user's information to the database

<details>
  <summary> Request </summary>
  
  *POST `https://pom-pets-api.herokuapp.com/api/v1/users`*
  
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

---

#### 2. Create New Project: Persists a new project's information to the database

<details>
  <summary> Request </summary>
  
  *POST `https://pom-pets-api.herokuapp.com/api/v1/projects`*
  
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

---

#### 3. Get User: Returns a user's information and their associated projects

<details>
  <summary> Request </summary>
  
  *GET `https://pom-pets-api.herokuapp.com/api/v1/users/1`*
  
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
                "longPomTime": "10",
                "shortPomTime": "5"
            },
            "projects": [
                {
                    "id": 1,
                    "projectName": "stretch-tech",
                    "projectPet": "tomato",
                    "petHealth": 3,
                    "petLevel": 1,
                    "projectGitHub": "url/ross-van-stretch-tech.com",
                    "petImage": "url/PigeonPet.png",
                    "stats": {
                        "totalWorkTime": "175",
                        "totalLongPomTime": "100",
                        "totalLongSessions": "4",
                        "totalShortPomTime": "45",
                        "totalWorkSessions": "5",
                        "totalShortSessions": "8"
                    },
                    "created_at": "2022-06-01T19:26:22.891Z",
                    "updated_at": "2022-06-01T19:26:22.891Z",
                    "user_id": 1
                }
            ]
        }
    }
}
```
</details>

---

#### 4. Update User: Updates part of a user

<details>
  <summary> Request </summary>
  
  *PATCH `https://pom-pets-api.herokuapp.com/api/v1/users/1`*
  
  `
  { "profilePhoto": "myNewPhoto.png" }
  `
  
  *Note: For nested attributes within settings hash, structure the json body like the following:*
  
  `
  { settings: { workTime: 500 }}
  `
  
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
            "profilePhoto": "myNewPhoto.png"",
            "settings": {
                "workTime": "25",
                "longPomTime": "10",
                "shortPomTime": "5"
            },
            "projects": [
                {
                    "id": 1,
                    "projectName": "stretch-tech",
                    "projectPet": "tomato",
                    "petHealth": 3,
                    "petLevel": 1,
                    "projectGitHub": "url/ross-van-stretch-tech.com",
                    "petImage": "url/PigeonPet.png",
                    "stats": {
                        "totalWorkTime": "175",
                        "totalLongPomTime": "100",
                        "totalLongSessions": "4",
                        "totalShortPomTime": "45",
                        "totalWorkSessions": "5",
                        "totalShortSessions": "8"
                    },
                    "created_at": "2022-06-01T19:26:22.891Z",
                    "updated_at": "2022-06-01T19:26:22.891Z",
                    "user_id": 1
                }
            ]
        }
    }
}
```
</details>

---

#### 5. Update Project: Updates part of a project

<details>
  <summary> Request </summary>
  
  *PATCH `https://pom-pets-api.herokuapp.com/api/v1/projects/1`*
  
  `
  { projectPet: "bibby" }
  `
  
  *Note: For nested attributes within stats hash, structure the json body like the following:*
  
  `
  { stats: { totalWorkTime: 500 }}
  `
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
            "projectPet": "bibby",
            "petHealth": 3,
            "petLevel": 1,
            "projectGitHub": "url/ross-van-stretch-tech.com",
            "petImage": "url/PigeonPet.png",
            "user_id": 1,
            "stats": {
                "totalWorkTime": "175",
                "totalLongPomTime": "100",
                "totalLongSessions": "4",
                "totalShortPomTime": "45",
                "totalWorkSessions": "5",
                "totalShortSessions": "8"
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

---

#### 5. Delete User or Project: Destroy an invidivudal project, or a user and all its dependent projects

<details>
  <summary> Request </summary>
  
  *DELETE `https://pom-pets-api.herokuapp.com/api/v1/users/1`*
  
  or
  
   *DELETE `https://pom-pets-api.herokuapp.com/api/v1/projects/1`*

  </details>
  
  <details>
    <summary> Response </summary>
  
```  
  {
    "deleted": "User 1"
  }
```
</details>

---
