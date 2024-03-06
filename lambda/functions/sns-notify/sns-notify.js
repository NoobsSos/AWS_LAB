var AWS = require('aws-sdk'); 

exports.handler = async (event) => {
    AWS.config.update({region: 'ca-central-1'});
    
    var params = {
        Message: 'Example',
        TopicArn: 'arn:aws:sns:ca-central-1:example:example'
    };
    
    var publishTextPromise = new AWS.SNS({apiVersion: '2010-03-31'}).publish(params).promise();
    
    publishTextPromise.then(
        function(data) {
            console.log(`Message ${params.Message} sent to the topic ${params.TopicArn}`);
            console.log("MessageID is " + data.MessageId);
        }).catch(
        function(err) {
            console.error(err, err.stack);
    });
};