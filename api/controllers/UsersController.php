<?php
/**
 * @link http://www.lrdouble.com/
 * @copyright Copyright (c) 2017 Double Software LLC
 * @license http://www.lrdouble.com/license/
 */
namespace api\controllers;

use api\models\GameExploits;
use api\models\UserOut;
use api\models\Users;
use backend\models\UserPay;
use common\models\DrawWater;

class UsersController extends ObjectController
{

    /**
     * 会员添加接口
     */
    public function actionAdd()
    {
        if(\Yii::$app->request->isPost)
        {
            $model = new Users();
            if($model->add(\Yii::$app->request->post())){
                return $this->returnAjax(1,'成功',[]);
            }
            $message = $model->getFirstErrors();
            $message = reset($message);
            return $this->returnAjax(0,$message,[]);
        }
        return $this->returnAjax(0,'Please submit with POST');
    }

    /**
     * 会员消费
     */
    public function actionConsumption()
    {
        if(\Yii::$app->request->isPost)
        {
            $model = new UserOut();
            if($model->add(\Yii::$app->request->post())){
                return $this->returnAjax(1,'成功',[]);
            }
            $message = $model->getFirstErrors();
            $message = reset($message);
            return $this->returnAjax(0,$message,[]);
        }
        return $this->returnAjax(0,'Please submit with POST');
    }

    /**
     * 会员战绩
     */
    public function actionExploits()
    {
        if(\Yii::$app->request->isPost)
        {
            $model = new GameExploits();
            if($model->add(\Yii::$app->request->post())){
                return $this->returnAjax(1,'成功',[]);
            }
            $message = $model->getFirstErrors();
            $message = reset($message);
            return $this->returnAjax(0,$message,[]);
        }
        return $this->returnAjax(0,'Please submit with POST');
    }
    
    /**
     * 抽水记录
     */
    public function actionDrawWater()
    {
        if(\Yii::$app->request->isPost)
        {
            $model = new DrawWater();
            if($model->add(\Yii::$app->request->post())){
                return $this->returnAjax(1,'成功',[]);
            }
            $message = $model->getFirstErrors();
            $message = reset($message);
            return $this->returnAjax(0,$message,[]);
        }
        return $this->returnAjax(0,'Please submit with POST');
    }
    
    
    /**
     * 游戏端买金币
     */
    public function actionPay()
    {
        if(\Yii::$app->request->isPost)
        {
            $model = new \api\models\UserPay();
            if($model->clientPay(\Yii::$app->request->post())){
                return $this->returnAjax(1,'成功',[]);
            }
            $message = $model->getFirstErrors();
            $message = reset($message);
            return $this->returnAjax(0,$message,[]);
        }
        return $this->returnAjax(0,'Please submit with POST');
    }
    
}