<?php
/**
 * @link http://www.lrdouble.com/
 * @copyright Copyright (c) 2017 Double Software LLC
 * @license http://www.lrdouble.com/license/
 */
namespace backend\controllers;

use backend\models\Agency;

use backend\models\Rebate;
use backend\models\RebateConf;
use backend\models\RebateRatio;
use phpDocumentor\Reflection\DocBlock\Tags\Var_;
use yii\web\Response;
use yii\data\Pagination;

/**
 * 返利操作模型
 * Class RebateController
 * @package backend\controllers
 */
class RebateController extends ObjectController
{
    
    
    /**
     * 返利记录搜索
     * @return string
     */
    public function actionIndex()
    {
        $rebate = new Rebate();
        $rebate->load(\Yii::$app->request->get());
        $rebate->initTime();
        $model = Rebate::find();
        $model->andWhere(['>=','time',strtotime($rebate->starttime)])->andWhere(['<=','time',strtotime($rebate->endtime)])->andWhere($rebate->searchWhereLikes());
        $pages      = new Pagination(['totalCount' =>$model->count(), 'pageSize' => \Yii::$app->params['pageSize']]);
        $data       = $model->limit($pages->limit)->offset($pages->offset)->asArray()->orderBy('time DESC')->all();
        $rows = Rebate::find()->select('sum(gold_num),sum(proportion)')->andWhere(['>=','time',strtotime($rebate->starttime)])->andWhere(['<=','time',strtotime($rebate->endtime)])->andWhere($rebate->searchWhereLikes())->asArray()->one();
        return $this->render('index',['model'=>$rebate,'data'=>$data,'pages'=>$pages,'rows'=>$rows]);
    }
    /**
     * 返钻比例设置
     * @return array|string
     */
    public function actionSetting()
    {
        $this->layout = false;
        $model  = RebateConf::findOne(1);
        if(\Yii::$app->request->isPost)
        {
            \Yii::$app->response->format = Response::FORMAT_JSON;
            if($model->load(\Yii::$app->request->post()) && $model->save())
            {
                return ['code'=>1,'message'=>'修改成功'];
            }else{
                $message = $model->getFirstErrors();
                $message = reset($message);
                return ['code'=>0,'message'=>$message];
            }
        }
        return $this->render('setting',['model'=>$model]);
    }
    
    
    /**
     * 返利比列表
     * @return string
     */
    public function actionIndexRatio(){
        $data = RebateRatio::findOne(1);
        return $this->render('index-ratio',['data'=>$data]);
    }
    
    
    /**
     *  修改返利比例
     * @return array|string
     */
    public function actionRatio(){
        $this->layout = false;
        $model  = RebateRatio::findOne(1);
        if(\Yii::$app->request->isPost)
        {
            \Yii::$app->response->format = Response::FORMAT_JSON;
            if($model->load(\Yii::$app->request->post()) && $model->save())
            {
                return ['code'=>1,'message'=>'修改成功'];
            }else{
                $message = $model->getFirstErrors();
                $message = reset($message);
                return ['code'=>0,'message'=>$message];
            }
        }
        return $this->render('ratio',['model'=>$model]);
    }
}