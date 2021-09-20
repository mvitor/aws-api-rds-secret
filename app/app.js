const express = require("express");
const bodyParser = require("body-parser");
const get_secrets = require("./get_secrets");
const fs = require("fs").promises

const app = express();

// parse requests of content-type: application/json
app.use(bodyParser.json());

// parse requests of content-type: application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

// simple route
app.get("/", async (req, res) => {
  const theSecret =  await fs.readFile(".env")
  res.json({ message: "Welcome to my application. The secret is: "+theSecret+
        " The Database configuration is also working fine at Hostname: "+process.env.RDS_HOSTNAME+
        " Database: "+process.env.RDS_DATABASE

    });
});

require("./routes/dbstatus.js")(app);
require("./routes/index.js")(app);

// set port, listen for requests
app.listen(8080,async () => {
    try {
		const theSecret = await get_secrets();
        await fs.writeFile(".env", theSecret);
        console.log("Secret retrieved successfully")
    }
    catch (error) {
		//log the error and crash the app
		console.log("Error in getting secrets", error);
		process.exit(-1);
	}

  console.log("Server is running on port 8080.");
});
