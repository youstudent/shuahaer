<?php
/**
 * Created by PhpStorm.
 * User: gba12
 * Date: 2017/9/29
 * Time: 18:33
 */

namespace backend\controllers;


use common\models\DrawWater;
use common\models\DrawWaterRatio;
use yii\web\Response;

class DrawWaterController extends ObjectController
{
    /**
     * 抽水记录 (转账|游戏)
     * @return string
     */
    public function actionList()
    {
        $model = new DrawWater();
        $type = \Yii::$app->request->get('type');
        $data = $model->getList(\Yii::$app->request->get(),$type);
        $re ='';
        if ($type==1){
            $re = 'list';
        }else{
            $re = 'index';
        }
        return $this->render($re,$data);
    }
    
    
}