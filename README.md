# Learning AWS Neptune Project

## Introduction and Background of the project

### Imagine while building an online social networking website you would like to connect people with similar interests, with the help of this application you can suggest user to know people having similar interests. We have used applications such as - Amazong Neptune as it is perfect for the use case as you can analyze existing connections in a graph to identify high-value missing connections, Cloud9 is a cloud-based integrated development environment (IDE) that lets you write, run, and debug code with just a browser. AWS Cloud9 includes a code editor, debugger, and terminal. It also comes prepackaged with essential tools for popular programming languages and the AWS Command Line Interface (CLI) preinstalled so that you don’t have to install files or configure your laptop for this lab. Finally deploying your code and running it on AWS Lambda which is a serverless computing service

## Brief Details about Amazong Neptune

### - Fully managed: All Amazon Neptune operations are managed by AWS, allowing you to focus on building your application. You don’t need to think about failovers, backups, or system upgrades.
### - Scalability: Amazon Neptune allows you to store and query billions of relationships with millisecond latency.
### - Security: Amazon Neptune places your database in an Amazon VPC for secure network isolation. It also provides IAM mechanisms for authentication and flexible encryption options.

## Provisioning resources and configuring services - We configured various AWS resources required to successfully run this project including Amazong Neptne, Security Groups, lambda, Cloud9 etc

### - Creating an AWS account or using the existing AWS account to setup the Cloud9 environment (AWS IDE)
### - Installing the dependent file in the folder application and scripts and and enter the AWS region of your choice
### - Next step is provisioning the neptune database as mentioned above. For this project, we have used the following version of Amazon Neptune 1.0.2.2.R4 (Keep the rest of the setting as default)
### - While your database is provisioning, you can create a security group for your Lambda function. AWS Lambda is a serverless computing service from AWS where you upload code that is executed when certain events happen. You don't need to worry about server provisioning or management -- your code execution is handled entirely for you. We will be naming the security group as - recommendation lambda for simplicity
### - Next in In the list of security groups, find your recommendations-lambda security group. Get the value of the Group ID (starts with sg-).In your Cloud9 terminal, run the echo command to provision that groupid value
### - Now you need to configure your Neptune database so that both your Cloud9 development environment and your AWS Lambda function can access it.In the Neptune database instance details, the Connectivity & security section shows the security groups configured for your database. Choose the security group name to open it and configure the inbound rules for allowing access from cloud 9 and lambda function
### - We again run the echo command in cloud9 to export the neptune endpoint. Now you can access to neptune via cloud9

## Logic Embedded - In this section, we designed the data model for providing recommendation to the user using graph database i.e. Amazong Neptune

### - We created a javascript to fetch user interest using gremlin's query language, it is stored with the name findUserInterests.js
### - We created another script findFriendsOfFriends.js, the script generates user-specific recommendations of other users they should follow.
### - In the next script findFriendsWithInterests.js, the logic in the code works on generating recommendations for users that aren’t following any users yet

## Authentication - In this section, we configured Amazon Cognito to use as the authentication provider in the application. Amazon Cognito is a fully managed authentication provider that allows for user sign-up, verification, login, and more.

### - We used amazon cognito service to work on the authentication process, first we created a shell script to create a user pool along with the password policy
### - Once user pool is created, we work on creating a user pool client in the shell script create-user-pool-client.sh. A user pool client is used to call unauthenticated methods on the user pool, such as register and sign in. The user pool client is used by your backend Node.js application. To register or sign in, a user makes an HTTP POST request to your application containing the relevant properties. Your application uses the user pool client and forwards these properties to your Amazon Cognito user pool. Then, your application returns the proper data or error message.
### - We created authentication file auth.js, having three core functions - creating cognito user, login function that is used when registered users are authenticating and finally verify token function which verifies an ID token that has been passed up with a request. The ID token given by Amazon Cognito is a JSON Web Token, and the verifyToken function confirms that the token was signed by your trusted source and to identify the user. This function is used in endpoints that require authentication to ensure that the requesting user has access.

## Deployment - In this module, we deployed our application code to AWS Lambda, a serverless computing service. With AWS Lambda, one need not to worry about server management or capacity planning. You simply upload the code you want to run, and AWS runs the code whenever a configured event trigger occurs.One of the event triggers with Lambda is Amazon API Gateway. Amazon API Gateway lets one configure HTTP endpoints that forward requests to AWS Lambda functions.Further, both Lambda and API Gateway are billed on a pay-per-use basis, meaning you only pay for what you use

### - For AWS Lambda function to access Neptune instance, it must be located in a subnet in your VPC and configured with a security group that can access Neptune instance. Hence in this step, we configure private subnet, create a routing table and route and associate the route with the given subnet. It could be done manually or through script. For the sake of simplicity, we have created a script to run it i.e. create-networking.sh
### - We need to package our code and deploy it in lambda. Lambda expects you to upload a ZIP file containing all of your application code. Additionally, we specified a runtime to use and the file and function that serves as the entry point to the code. We have created a file called lambda.sh to perform steps like - Zipping up the file, creating IAM role to be assumed by lambda function, Adding an IAM policy to the IAM role and finally creating lambda function by uploading the zip file
### - Next step is making the lambda function available via API Gateway. We have created a script create-rest-api.sh that provisions an API Gateway REST API and connects it to the Lambda function

## Testing - There are three ways we can test -First, you start with a Registration endpoint, where a new user signs up and creates their account. After you register the user, you view the user's details with the FetchUser endpoint.Second, you use a Login endpoint where a user can use a client (such as a web application or a mobile app) to authenticate and receive an ID token. Third, you use a FetchUserRecommendations endpoint to find users you should follow

### - The first flow for the testing process is the Registration endpoint. At this endpoint, a new user signs up by providing login information, like username and password. Additionally, the new user can indicate some interests when they register. This helps provide more relevant recommendations when the user is new. The logic for this endpoint in the application/app.js file . The handler first validates the incoming payload body on the request. If that succeeds, the handler creates a user in Amazon Cognito and then creates a user in the Neptune database using the createUser function in the file application/data/createUser.js. The registration endpoint can be invoked using CURL command in the function
### - The second part of the testing process is the Login endpoint. Users will submit their username and password to this endpoint to receive an ID token, which will be used to authenticate them on subsequent requests.To handle this authentication and token dispensing, your application has a /login endpoint. The handler is in application/app.js file. Using the curl command, we can give the username and password and retrieve ID token
### - For fetching the recommendation for the new user created, we are going to use fetchUserRecommendations function in application/data/fetchUserRecommendations.js file. The fetchUserRecommendations function takes a username and then runs both of the recommendation strategies we saw in the previous sections. It looks for friends of friends as well as friends with the same interests. It returns the results from both of these strategies.
 

