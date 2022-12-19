# Start from a Node.js base image
FROM node:12

# Set the working directory for the app
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install the app dependencies
RUN npm install

# Copy the rest of the app code to the working directory
COPY . .

# Expose the app port
EXPOSE 3000

# Run the app
CMD ["npm", "start"]
