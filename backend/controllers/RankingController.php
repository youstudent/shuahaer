<?php
/**
 * Created by PhpStorm.
 * User: gba12
 * Date: 2017/9/29
 * Time: 20:52
 */

namespace backend\controllers;


use backend\models\Users;
use yii\web\Response;

class RankingController extends ObjectController
{
    
    /**
     * 财富
     * @return string
     */
    public function actionWealth(){
       $model = new Users();
       $data = $model->getWealth(\Yii::$app->request->get());
       return $this->render('wealth',$data);
    }
    
    /**
     * 充值
     * @return string
     */
    public function actionPay(){
        $model = new Users();
        $data = $model->PayRanking(\Yii::$app->request->get());
        return $this->render('pay',$data);
    }
    
    /**
     * 交易
     * @return string
     */
    public function actionDeal(){
        $model = new Users();
        $data = $model->getDealNum(\Yii::$app->request->get());
        return $this->render('dealnum',$data);
    }
    
    /**
     * 修改货币
     * @return array|string
     */
    public function actionAddNum()
    {
        $this->layout = false;
        $id = empty(\Yii::$app->request->get('id')) ? \Yii::$app->request->post('id') : \Yii::$app->request->get('id');
        $model = Users::findOne($id);
        if(\Yii::$app->request->isPost)
        {
            \Yii::$app->response->format = Response::FORMAT_JSON;
            if($model->editNum(\Yii::$app->request->post()))
            {
                return ['code'=>1,'message'=>'添加次数成功'];
            }
            $message = $model->getFirstErrors();
            $message = reset($message);
            return ['code'=>0,'message'=>$message];
            
        }
        return $this->render('addnum',['model'=>$model]);
    }
    
}