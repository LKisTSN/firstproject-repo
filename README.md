# **About**

-   Application
    -   NodeJS
        -   node version : 17.7.1
        -   npm version: 8.5.2
-   Database
    -   MongoDB version: 5.0.8
-   Container
    -   Docker version: 20.10.7
-   Infrastructure as a Code
    -   Terraform version: 1.1.9

# **Linux (Prerequisite)**

-   Launch an AWS EC2 Linux instance to run the Docker engine. Refer to guide (<https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html>) on steps to launch a EC2 instance using AWS management Console. Refer to guide (<https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/get-set-up-for-amazon-ec2.html>) for first time setup to use Amazon EC2.
-   Install Docker engine on EC2 Linux, Refer to guide (<https://docs.aws.amazon.com/AmazonECS/latest/developerguide/create-container-image.html>) on instruction to install Docker engine.

# **Windows (Prerequisite)**

-   Download and install NodeJS for Windows (<https://nodejs.org/en/download/>)

# **Database (Prerequisite)**

-   Download and install Mongo cloud database. Refer to guide (<https://www.mongodb.com/basics/mongodb-atlas-tutorial>)
-   Follow the tutorial and
    -   Create MongoDB AWS account.
    -   Create a MongoDB Atlas cluster.
    -   Configure network access to my Windows IP address and create a database user
    -   Connect to the cluster by adding the connection string “mongodb+srv://\<username\>:\<password\>@nodeproj.esegr.mongodb.net/NodeProj?retryWrites=true&w=majority” into my node.js code.

# **To Build Container Image:**

-   Pull application node.js code from GitHub (https://github.com/LKisTSN/firstproject-repo)
-   At the console of EC2 instance, issue command “git clone <https://github.com/LKISTSN/firstproject-repo.git> ./NodeProj” to clone the files into the defined working directory
-   Create a Dockerfile on the EC2 instance. Refer to my Github for the file content. (https://github.com/LKisTSN/firstproject-repo)
-   Issue command “docker build -t node-docker” to build the docker image
-   Wait for image build to finish
-   Type ”docker images”, you should see the image (tagged node-docker) created under *REPOSITORY*

# **To run the application in Docker:**

To run the application in docker, follow the below steps

-   Issue command "docker run --publish \<local IP\>:80:3000 node-docker" to run the docker image.
-   Verify that the container is running by issuing the command “docker ps”.
-   Verify that the application is working by accessing "http://\<Local IP\>:8080/add-blog" to add a new blog entry. The entry can be viewed in the database collection in MongoDB.

# **To push the docker image to Docker Hub repository**

-   Login to Docker Hub with account credentials.
-   Issue command "docker tag node-docker:latest dockerlk04/docker-repo-flo:latest" to tag the local repository to the one on Docker Hub
-   Issue command "docker push dockerlk04/docker-repo-flo:latest" to push the image to Docker Hub

Instead of building the container image again when we need it in the future, we can login to Docker Hub and do a docker pull from **dockerlk04/docker-repo-flo**. Type “docker pull dockerlk04/docker-repo-flo” in the console. Type “docker images”, you should see the image created under REPOSITORY

# **To use Terraform to run the application in Docker**

-   Install Terraform. Refer to guide (<https://www.terraform.io/downloads>).
-   Create a ‘main.tf’ file and define AWS as the provider. (<https://registry.terraform.io/providers/hashicorp/aws/latest/docs>).
-   Include the steps to build and run the application in Docker within the user data section upon instance launch. Refer to main.tf file in my Github (https://github.com/LKisTSN/firstproject-repo)
-   Issue command “terraform init” to initialise a working directory containing Terraform configuration files.
-   Issue command “terraform plan” to show the changes required by current configuration.
-   Issue command “terraform apply” to create the infrastructure.
-   Verify that the application is working by accessing "http://\<IP of EC2 provisioned by Terraform\>:8080/add-blog" to add a new blog entry. The entry can be viewed in the database collection in MongoDB.
