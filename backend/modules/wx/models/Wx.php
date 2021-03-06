<?php
/*
 * @link http://www.angkebrand.com/
 * @copyright Copyright (c) 2017/7/31 angke|lrdouble Software LLC
 * @license http://www.angkebrand.com/license/
 * @author lrdouble
 * @author_link http://www.lrdouble.com
 */

namespace backend\modules\wx\models;

use common\services\Request;
use yii\base\Model;
use yii\helpers\ArrayHelper;

/**
 * 获取微信的功能
 * Class Wx
 * @package backend\modules\wx\models
 */
class  Wx extends Model
{
    public $wxappid = 'wxda66dd84468204e8';
    public $wxappsecrret = '1342d68cdf1bfada87c9a91b5770546e';
    public $accessToken = '';

    /**
     * 前置操作函数、初始化配置文件的
     * @return bool
     */
    public function init()
    {
        parent::init(); // TODO: Change the autogenerated stub
        // TODO： 获取微信的可以和secrret
        $this->wxappid = \Yii::$app->params['wxappid'];
        $this->wxappsecrret = \Yii::$app->params['wxappsecrret'];
        return true;
    }

    /**
     * 获取微信的accessToken并缓存本地两个小时
     * @return mixed|string
     */
    public function getAccessToken()
    {
        if ($this->accessToken) {
            return $this->accessToken;
        }
        $getAccessTokenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid={$this->wxappid}&secret={$this->wxappsecrret}";
        $data = $this->RequestGetDataToArray($getAccessTokenUrl);
        if (isset($data['errcode'])) {
            var_dump($data);
            die();
        }
        \Yii::$app->cache->set('wxBaseAccessToken', $data['access_token'], 7200);
        $this->accessToken = $data['access_token'];
        return $this->accessToken;
    }

    /**
     * GET发送请求、并返回数组格式
     * @param $url
     * @return array
     */
    public function RequestGetDataToArray($url)
    {
        $data = Request::curl_get($url);
        return ArrayHelper::toArray(json_decode($data));
    }

    /**
     * 获取用户资料并绑定关系
     * @param $code
     * @return bool
     * @throws \Exception
     */
    public function getUserInfo($code)
    {
        try {
            $requestUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid={$this->wxappid}&secret={$this->wxappsecrret}&code={$code}&grant_type=authorization_code";
            $userAccessToken = $this->RequestGetDataToArray($requestUrl);
            if (isset($userAccessToken['errcode'])) throw new \Exception($userAccessToken['errmsg'], 11001100);
            $requestUrl = "https://api.weixin.qq.com/sns/userinfo?access_token={$userAccessToken['access_token']}&openid={$userAccessToken['openid']}}&lang=zh_CN";
            $userInfo = $this->RequestGetDataToArray($requestUrl);
            if (isset($userInfo['errcode'])) {
                throw new \Exception($userInfo['errmsg'], 11001100);
            } elseif (!isset($userInfo['unionid'])) {
                throw new \Exception('<h1 style="text-align: center;padding-top: 100px;">请将公众号绑定到微信开放平台帐号后在使用本功能!</h1>', 11001100);
            }
            $model = new AgencyUserTemp();
            if ($model->add($userInfo['openid'], \Yii::$app->session->get('agency_id'), \Yii::$app->session->get('code'))) {
                return true;
            } else {
                $message = $model->getFirstErrors();
                $message = reset($message);
                throw new \Exception($message);
            }
        } catch (\Exception $exception) {
            if ($exception->getCode() == 11001100) {
                die($exception->getMessage());
            }
            throw $exception;
        }
    }

    /**
     * 用户登录跳转到微信的授权页面
     */
    public static function goToLogin()
    {
        $wxappid = \Yii::$app->params['wxappid'];
        $redirectUri = \Yii::$app->request->hostInfo . "/wx/default/redirect";
        $headerUrl = "Location:https://open.weixin.qq.com/connect/oauth2/authorize?appid={$wxappid}&redirect_uri=" . urlencode($redirectUri) . "&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect";
        Header($headerUrl);
        die();
    }
}