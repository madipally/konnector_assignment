# README

## **User Campaigns API**

### Overview

This is a Ruby on Rails application that provides an API for managing users and their associated campaigns. The application includes functionality to list users, add new users, and filter users by campaign names. It is designed to be deployed on an AWS EC2 instance and uses MySQL as the database.

### Features

	1. List Users: Retrieve all users from the database.
	2. Add New User: Add a new user to the database with their name, email, and campaigns list.
	3. Filter Users by Campaign Names: Retrieve users whose campaigns list contains any of the specified campaign names.


### Database Structure

  The users table is structured as follows

  	id (INT, Primary key)
  	name (VARCHAR(255))
  	email (VARCHAR(255))
  	campaigns_list (JSON)
   

### Example Data

> **id	name	email	campaigns_list**

> 1	John	john@gmail.com	[{"campaign_name": "cam1", "campaign_id": "id1"}, {"campaign_name": "cam2", "campaign_id": "id2"}]

> 2	Jane	jane@gmail.com	[{"campaign_name": "cam1", "campaign_id": "id1"}, {"campaign_name": "cam3", "campaign_id": "id3"}]


### **API Endpoints**

  **List Users**

	   •	Endpoint: GET /users
	   •	Function: Retrieve all users from the database.

  **Add New User**

	  •	Endpoint: POST /users
	  •	Function: Add a new user to the database with name, email, and campaigns list.
	  •	Request Body Example:

       {
          "name": "Alice",
          "email": "alice@gmail.com",
          "campaigns_list": [{"campaign_name": "cam4", "campaign_id": "id4"}]
       }
    

  ### **Filter Users by Campaign Names**

	    •	Endpoint: GET /users/filter
	    •	Parameters: campaign_names (comma-separated list of campaign names)
	    •	Function: Retrieve users whose campaigns list contains any of the specified campaign names.
	    •	Example Request

        •	GET /users/filter?campaign_names=cam1,cam2

## **Setup Instructions**

  ### **Prerequisites**

	    •	Ruby (3.3.0)
	    •	Rails (7.1)
	    •	MySQL
	    •	AWS EC2 instance (for deployment)

### **Local Setup**

> 1.	Clone the repository

      git clone [konnector_assignment](https://github.com/madipally/konnector_assignment)
      cd konnector_assignment

> 2.	Install dependencies

      bundle install

      If you got error while installing mysql2 

      Mac
        Install mysql2 library
          brew install mysql2

        Run bunle install
          bundle install

      Ubuntu
          Install following libraries
            sudo apt-get install libmariadb-dev
            sudo apt-get install libmysqlclient-dev

          Run bunle install
            bundle install
          

> 3.	Configure the database

      Create user in MySQL database with '[user]'@'localhost' , '[user]'@'%' and grant privileges

      Edit config/database.yml to set up the MySQL database credentials.

      Create and migrate the database:

      rails db:create
      rails db:migrate

> 4.	Start the Rails server

     rails server


### **Deployment on EC2**

	1.	Set up an EC2 instance and install Ruby, Rails, MySQL, and other dependencies.
	2.	Clone the repository on the EC2 instance.
	3.	Follow the local setup steps on the EC2 instance.
	4.	Ensure the Rails application is running and accessible over the internet.

### ** Accessing the Deployed Application**

	•	Ensure your EC2 instance has a public IP and the necessary ports (e.g., 3000 for HTTP , 3306 for MySQL) are open.
	•	Access the API endpoints using the public IP of the EC2 instance.

## **Example Requests**

### **List Users**

    GET http://3.89.157.71:3000/users

    <img width="1430" alt="Screenshot 2024-07-01 at 7 06 07 AM" src="https://github.com/madipally/konnector_assignment/assets/2417871/feda5bd3-6f28-4730-8234-35245411f851">

### **Add New User**

    POST http://3.89.157.71:3000/users
    Content-Type: application/json

    {
       "name": "Alice",
       "email": "alice@gmail.com",
      "campaigns_list": [{"campaign_name": "cam4", "campaign_id": "id4"}]
    }

    <img width="1423" alt="Screenshot 2024-07-01 at 7 07 14 AM" src="https://github.com/madipally/konnector_assignment/assets/2417871/02d9d2b1-172f-4c32-820a-65c0fb67b58f">


### **Filter Users by Campaign Names**

     GET http://3.89.157.71:3000/users/filter?campaign_names=cam1,cam2

     
     <img width="1422" alt="Screenshot 2024-07-01 at 7 08 33 AM" src="https://github.com/madipally/konnector_assignment/assets/2417871/64f4f89b-fbc5-4579-90e2-219395047a62">

  

