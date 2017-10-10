<?php
return [
    'adminEmail' => 'admin@example.com',
    'supportEmail' => 'support@example.com',
    'user.passwordResetTokenExpire' => 3600,
    'distribution'      => true,#是否开启分销代理分销
    'distribution_users'      => true,#是否开启分销玩家分销
    'gold-config'      => false,#是否开启分销玩家分销
    'pageSize'          =>21,
    'backendPayUser' => true,//后台开启给用户充值功能
    'appName'           =>'耍哈儿',//APP名称
    'startTime'         =>'2017-01-01 00:00:00',//时间组件开始时间
//    'ApiUserPay'        => 'http://120.77.155.126:4002',
    'ApiUserPay'        => 'http://192.168.2.113:9010',//游戏服务器地址
    'manyPay'           => true,//多货币开始、关闭状态
    'wxappid'=>'wx1f0573a349ad863e',
    'wxappsecrret'=>'e968c1ce5c24b10e369f8d912e805d76',
];
