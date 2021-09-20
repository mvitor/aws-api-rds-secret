
/*
 * GET home page.
 */

module.exports = app => {
  //const getsecret = require("../controllers/get_secret.controller.js");
  //app.post("tellmesecret", getsecret.mySecrets("mysecret"));
  //secret = getsecret.mySecrets("mysecret");
  //console.log(secret)
}
exports.index = function(req, res){

  // Load the AWS SDK
  var AWS = require('aws-sdk'),
      region = process.env.AWS_REGION,
      secretName = secretName,
      secret,
      decodedBinarySecret;

  // Create a Secrets Manager client
  var client = new AWS.SecretsManager({
      region: region
  });
const result = client
.getSecretValue({
  SecretId: AWSConfig.secretName,
})
.promise();

const parsedResult = JSON.parse(result.SecretString);
  res.render('index', { title: 'Express' });
};
