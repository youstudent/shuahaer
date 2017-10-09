<?php
/**
 * @link http://www.lrdouble.com/
 * @copyright Copyright (c) 2017 Double Software LLC
 * @license http://www.lrdouble.com/license/
 */
namespace backend\controllers;

use backend\models\Users;
use Codeception\Module\MongoDb;
use dosamigos\qrcode\formats\MailTo;
use dosamigos\qrcode\lib\Enum;
use dosamigos\qrcode\QrCode;
use Yii;
use yii\web\Response;
/**
 * 游戏玩家管理类
 * Class UsersController
 * @package backend\controllers
 */
class UsersController extends ObjectController
{

    /**
     * 平台给玩家充值处理
     * @return array|string
     */
    public function actionPay()
    {
        $this->layout = false;
        if(Yii::$app->request->isPost)
        {
            /**
             * 设置返回为json格式
             */
            Yii::$app->response->format = Response::FORMAT_JSON;
            $model = new Users();
            if($model->pay(Yii::$app->request->post()))
            {
                return ['code'=>1,'message'=>Yii::t('app','users_pay_success')];
            }
            /**
             * 获取model返回的错误
             */
            $message = $model->getFirstErrors();
            $message = reset($message);
            return ['code'=>0,'message'=>$message];
        }
        /**
         * 查询用户并返回给页面进行渲染
         */
        $model = Users::findOne(Yii::$app->request->get('id'));
        $model->agency_name = Yii::$app->request->get('agency_name');
        $model->goldArr = $model->getGold();
        return $this->render('payModal',['model'=>$model]);
    }
    
    /**
     * 平台给玩家扣除处理
     * @return array|string
     */
    public function actionDeduct()
    {
        $m = new \MongoClient();
        $this->layout = false;
        if(empty(\Yii::$app->request->get('id'))){
            $id =  \Yii::$app->request->post('id');
        } else{
            $id =  \Yii::$app->request->get('id');
        }
        
        if(\Yii::$app->request->isPost)
        {
            /**
             * 设置返回为json格式
             */
            \Yii::$app->response->format = Response::FORMAT_JSON;
            $model = new Users();
            if($model->deduct(\Yii::$app->request->post()))
            {
                return ['code'=>1,'message'=>"扣除成功"];
            }
            /**
             * 发送错误读取错误是什么、并返回给客户端
             */
            $message = $model->getFirstErrors();
            $message = reset($message);
            return ['code'=>0,'message'=>$message];
        }
        
        $model = Users::findOne(Yii::$app->request->get('id'));
        $model->goldArr = $model->getGold();
        return $this->render('deduct',['model'=>$model]);
    }
    
    

    /**
     * 显示用户列表
     * @return string
     */
    public function actionList()
    {
        $model = new Users();
        $data = $model->getList(Yii::$app->request->get());
        return $this->render('list',$data);
    }
    
    
    /**
     * 查询代理商的下级玩家
     * @return string
     */
    public function actionDown()
    {
        $model = new Users();
        $data = $model->getDown(Yii::$app->request->get());
        return $this->render('down',$data);
    }
    

    /**
     * 显示用户的充值记录表
     * @return string
     */
    public function actionPayLog()
    {
        $model = new Users();
        $data = $model->getPayLog(Yii::$app->request->get());
        return $this->render('pay_log',$data);
    }
    
    
    
    /**
     * 显示用户的充值记录表
     * @return string
     */
    public function actionDeductLog()
    {
        $model = new Users();
        $data = $model->getDeductLog(Yii::$app->request->get());
        return $this->render('deduct_log',$data);
    }
    

    /**
     * 显示用户消费记录
     * @return string
     */
    public function actionOutLog()
    {
        $model = new Users();
        $data = $model->getOutLog(Yii::$app->request->get());
        return $this->render('out_log',$data);
    }

    /**
     * 显示用户战绩
     * @return string
     */
    public function actionExploits()
    {
        $model = new Users();
        $data = $model->getExploits(Yii::$app->request->get());
        return $this->render('exploits',$data);
    }
    
    
    /**
     * 玩家停封和启用
     * @return array
     */
    public function actionStatus(){
     \Yii::$app->response->format = Response::FORMAT_JSON;
       $model = new Users();
       if ($model->status(Yii::$app->request->get())){
           return ['code'=>1,'message'=>"操作成功"];
       }
        /**
         * 发送错误读取错误是什么、并返回给客户端
         */
        $message = $model->getFirstErrors();
        $message = reset($message);
        return ['code'=>0,'message'=>$message];
    }
}
