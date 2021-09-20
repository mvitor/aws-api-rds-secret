// Use this code snippet in your app.
// If you need more information about configurations or implementing the sample code, visit the AWS docs:
// https://aws.amazon.com/developers/getting-started/nodejs/
async function mySecrets(secretName) {
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
const result = await client
.getSecretValue({
  SecretId: AWSConfig.secretName,
})
.promise();

const parsedResult = JSON.parse(result.SecretString);

return parsedResult
};
    