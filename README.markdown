This is a second-screen application originally designed for the NewsHour's Vote
2012 Map Center.

## Project Dependencies

This project requires the following software:

* Node.js (available at http://nodejs.org/)
* Redis (available at http://redis.io/)

Once installed, run the following command from this project's root directory:

    npm install

This will install the requisite packages from the Node Package Manager.

The "grunt" build tool is required to build the project. You can check if it is
already installed by typing:

    grunt --version

If not, you may install it globally by running the following command:

    npm install -g grunt

## Building the Project

Issue the following command to build the required source files:

    grunt

Alternatively, you may build a development version of the code, which creates
unminified JavaScript for easier debugging:

    grunt dev

## Running the Services

The standalone map application will function correctly when accessed locally
over the `file://` protocol--simply open the `frontend/dist/index.html` file in
a web browser.

In order to excersize the network functionality, the files in `frontent/dist`
must be served over a network protocol. Run the web server of your choice from
that directory. The backend component is a Node.js service, which can be run
from the `backend` directory with the following command:

    node server.js

# Serving the Application in Production

By default, the service will run on port #8000 of the IP address `127.0.0.1`.
These locations can be overridden by defining the `NODE_PORT` and `NODE_HOST`
environmental variables, respectively.

After defining one or both of these parameters, re-build the project and
re-start the service.
