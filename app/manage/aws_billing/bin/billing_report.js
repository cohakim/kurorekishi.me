'use strict';

var INSTANCE_ID = 'your_instance_id';

var AWS = require('aws-sdk');
AWS.config.region = 'ap-northeast-1';

exports.handler = function (event, context) {
    var ec2 = new AWS.EC2();

    var params = {
        InstanceIds: [INSTANCE_ID]
    };

    ec2.startInstances(params, function (err, data) {
        if (err) console.log(err, err.stack);else console.log(data);
    });
};