# firstproject-repo
In this project, I have created a Node.js REST API using the Express framework. Calling the API would generate a new blog entry and store it in a MongoDB database. Next, I build a docker image and hosted it on Docker Hub. Then, I used Terraform to create an AWS EC2 instance and run a container using this Docker image.

To execute the actions in main.tf file, use Terraform commands "init", "plan" and "apply". 
To trigger the API, go to URL: <public ip address>:8080/add-blog.
