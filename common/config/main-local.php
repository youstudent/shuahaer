<?php
return [
    'components' => [
        'db' => [
            'class' => 'yii\db\Connection',
            'dsn' => 'mysql:host=121.43.231.70;dbname=shuahaer',
            'username' => 'root',
            'password' => 'Caoshuang1',
            'charset' => 'utf8',
            'tablePrefix' =>'g_',
        ],
        'mailer' => [
            'class' => 'yii\swiftmailer\Mailer',
            'viewPath' => '@common/mail',
            // send all mails to a file by default. You have to set
            // 'useFileTransport' to false and configure a transport
            // for the mailer to send real emails.
            'useFileTransport' => true,
        ],
        'urlManager' => [
            'class' => 'yii\web\UrlManager',
            'enablePrettyUrl' => true,
            'showScriptName' => false,
//            'urlSuffix'      =>'html',
        ],
    ],
    'timeZone'=>'Asia/Chongqing',
];
