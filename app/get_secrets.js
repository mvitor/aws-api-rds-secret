const AWS = require("aws-sdk");
module.exports = () => {
    secretName = "mysecret002"
    region = process.env.AWS_REGION
	const client = new AWS.SecretsManager({ region });
	return new Promise((resolve, reject) => {
		//retrieving secrets from secrets manager
		client.getSecretValue({ SecretId: secretName }, (err, data) => {
			if (err) {
				reject(err);
			} else {
				resolve(data.SecretString);
			}
		});
	});
};
