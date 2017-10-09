<?php
/**
 * Created by PhpStorm.
 * User: gba12
 * Date: 2017/9/29
 * Time: 19:14
 */

namespace backend\controllers;


use common\models\DrawWaterRatio;
use SebastianBergmann\CodeCoverage\Report\Html\Dashboard;
use yii\web\Response;

class ConfigController extends ObjectController
{
    
    /**
     * 配置列表
     * @return string
     */
    public function actionIndex(){
       $data  = DrawWaterRatio::find()->asArray()->all();
       return $this->render('index',['data'=>$data]);
    }
    
    
    /**
     *  修改抽水比例
     * @return array|string
     */
    public function actionEdit()
    {
        $this->layout = false;
        $id = empty(\Yii::$app->request->get('id')) ? \Yii::$app->request->post('id') : \Yii::$app->request->get('id');
        $model = DrawWaterRatio::findOne($id);
        if(\Yii::$app->request->isPost)
        {
            \Yii::$app->response->format = Response::FORMAT_JSON;
            if($model->edit(\Yii::$app->request->post()))
            {
                return ['code'=>1,'message'=>'修改成功'];
            }
            $message = $model->getFirstErrors();
            $message = reset($message);
            return ['code'=>0,'message'=>$message];
            
        }
        return $this->render('edit',['model'=>$model]);
    }
    
    
    /**
     *  支付开关
     * @return array
     */
    public function actionType(){
        \Yii::$app->response->format = Response::FORMAT_JSON;
        $model = new DrawWaterRatio();
        if ($model->type(\Yii::$app->request->get())){
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