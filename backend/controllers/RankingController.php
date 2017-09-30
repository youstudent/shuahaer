<?php
/**
 * Created by PhpStorm.
 * User: gba12
 * Date: 2017/9/29
 * Time: 20:52
 */

namespace backend\controllers;


use backend\models\Users;

class RankingController extends ObjectController
{
    
    /**
     * 查询玩家金币最多大的
     * @return string
     */
    public function actionWealth(){
       $model = new Users();
       $data = $model->getWealth(\Yii::$app->request->get());
       return $this->render('wealth',$data);
    }
    
}