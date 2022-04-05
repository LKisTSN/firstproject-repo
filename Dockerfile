# Use an official Node runtime as a parent image
FROM node:13-alpine
WORKDIR /home/ec2-user/NodeProj
RUN npm install g express generator
RUN npm install mongoose
#copy all files to the working directory
COPY . .
CMD [ "node", "test.js" ]
