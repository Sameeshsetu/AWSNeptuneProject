# Learning AWS Neptune Project

## Introduction

### In this project, we are learning how to use Amazon's Graph Database i.e. Amazong Neptune to build an engine suggesting friends with similar interests

## Brief Details about Amazong Neptune
### - Fully managed: All Amazon Neptune operations are managed by AWS, allowing you to focus on building your application. You don’t need to think about failovers, backups, or system upgrades.
### - Scalability: Amazon Neptune allows you to store and query billions of relationships with millisecond latency.
### - Security: Amazon Neptune places your database in an Amazon VPC for secure network isolation. It also provides IAM mechanisms for authentication and flexible encryption options.

## Background about the project

### Imagine while building an online social networking website you would like to connect people with similar interests, with the help of this application you can suggest user to know people having similar interests. We have used graph database i.e. Amazong Neptune as it is perfect for the use case as you can analyze existing connections in a graph to identify high-value missing connections.

## Steps performed in the project

### - Creating an AWS account or using the existing AWS account to setup the Cloud9 environment (AWS IDE)
### - Installing the dependent file in the folder application and scripts and and enter the AWS region of your choice
### - Next step is provisioning the neptune database as mentioned above. For this project, we have used the following version of Amazon Neptune 1.0.2.2.R4 (Keep the rest of the setting as default)
### - While your database is provisioning, you can create a security group for your Lambda function. AWS Lambda is a serverless computing service from AWS where you upload code that is executed when certain events happen. You don't need to worry about server provisioning or management -- your code execution is handled entirely for you. We will be naming the security group as - recommendation lambda for simplicity
### - Next in In the list of security groups, find your recommendations-lambda security group. Get the value of the Group ID (starts with sg-).In your Cloud9 terminal, run the echo command to provision that groupid value
### - Now you need to configure your Neptune database so that both your Cloud9 development environment and your AWS Lambda function can access it.In the Neptune database instance details, the Connectivity & security section shows the security groups configured for your database. Choose the security group name to open it and configure the inbound rules for allowing access from cloud 9 and lambda function
### - We again run the echo command in cloud9 to export the neptune endpoint. Now you can access to neptune via cloud9
### - We created a javascript to fetch user interest using gremlin's query language, it is stored with the name findUserInterests.js
### - We created another script findFriendsOfFriends.js, the script generates user-specific recommendations of other users they should follow.
### - In the next script findFriendsWithInterests.js, the logic in the code works on generating recommendations for users that aren’t following any users yet
Authentication
### - We used amazon cognito service to work on the authentication process, first we created a shell script to create a user pool along with the password policy
### - Once user pool is created, we work on creating a user pool client in the shell script create-user-pool-client.sh. A user pool client is used to call unauthenticated methods on the user pool, such as register and sign in. The user pool client is used by your backend Node.js application. To register or sign in, a user makes an HTTP POST request to your application containing the relevant properties. Your application uses the user pool client and forwards these properties to your Amazon Cognito user pool. Then, your application returns the proper data or error message.
### - We created authentication file auth.js, having three core functions - creating cognito user, login function that is used when registered users are authenticating and finally verify token function which verifies an ID token that has been passed up with a request. The ID token given by Amazon Cognito is a JSON Web Token, and the verifyToken function confirms that the token was signed by your trusted source and to identify the user. This function is used in endpoints that require authentication to ensure that the requesting user has access.
Deployment
### - 

