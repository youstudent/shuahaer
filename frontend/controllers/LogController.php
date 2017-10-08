<?php
/**
 * @link http://www.lrdouble.com/
 * @copyright Copyright (c) 2017 Double Software LLC
 * @license http://www.lrdouble.com/license/
 */
namespace frontend\controllers;

use frontend\models\Agency;
use frontend\models\AgencyDeduct;
use frontend\models\AgencyPay;
use frontend\models\Rebate;
use frontend\models\UserPay;
use frontend\models\Users;
use yii\base\Model;
use yii\data\Pagination;

class LogController extends ObjectController
{
    /**
     * 充值记录
     * @return string
     */
    public function actionPay()
    {
        $startTime = \Yii::$app->request->get('startTime');
        $endTime   = \Yii::$app->request->get('endTime');
        $model = AgencyPay::find()->andWhere(['agency_id'=>\Yii::$app->session->get('agencyId')]);
        if($startTime)
            $model = $model->andWhere(['>=','time',strtotime($startTime)]);
        else
            $startTime = date('Y-m-d H:i:s',strtotime('-1 month'));

        if ($endTime)
            $model = $model->andWhere(['<=','time',strtotime($endTime)]);
        else
            $endTime = date('Y-m-d H:i:s',time());
        $pages = new Pagination(['totalCount' =>$model->count(), 'pageSize' => \Yii::$app->params['pageSize']]);
        $data = $model->offset($pages->offset)->limit($pages->limit)->all();
        $num =0;
        foreach ($data as $value){
          $num+=$value['gold'];
        }
        return $this->render('pay',['data'=>$data,'pages'=>$pages,'startTime'=>$startTime,'endTime'=>$endTime,'num'=>$num]);
    }

    /**
     * 给用户充值记录
     * @return string
     */
    public function actionUserPay()
    {
        $startTime = \Yii::$app->request->get('startTime');
        $endTime   = \Yii::$app->request->get('endTime');
        $model = UserPay::find()->andWhere(['agency_id'=>\Yii::$app->session->get('agencyId')]);
        if($startTime)
            $model = $model->andWhere(['>=','time',strtotime($startTime)]);
        else
            $startTime = date('Y-m-d H:i:s',strtotime('-1 month'));
        if ($endTime)
            $model = $model->andWhere(['<=','time',strtotime($endTime)]);
        else
            $endTime = date('Y-m-d H:i:s',time());
        $pages = new Pagination(['totalCount' =>$model->count(), 'pageSize' => \Yii::$app->params['pageSize']]);
        $data = $model->offset($pages->offset)->limit($pages->limit)->all();
        $models = new UserPay();
        return $this->render('userPay',['data'=>$data,'pages'=>$pages,'startTime'=>$startTime,'endTime'=>$endTime,'model'=>$models]);
    }
    /**
     * 返利记录
     * @return string
     */
    public function actionRebate()
    {
        $startTime = \Yii::$app->request->get('startTime');
        $endTime   = \Yii::$app->request->get('endTime');
        $model = Rebate::find()->andWhere(['agency_id'=>\Yii::$app->session->get('agencyId')]);
        if($startTime)
            $model = $model->andWhere(['>=','time',strtotime($startTime)]);
        else
            $startTime = date('Y-m-d H:i:s',strtotime('-1 month'));

        if ($endTime)
            $model = $model->andWhere(['<=','time',strtotime($endTime)]);
        else
            $endTime = date('Y-m-d H:i:s',time());
        $pages = new Pagination(['totalCount' =>$model->count(), 'pageSize' => \Yii::$app->params['pageSize']]);
        $data = $model->offset($pages->offset)->limit($pages->limit)->all();
        return $this->render('rebate',['data'=>$data,'pages'=>$pages,'startTime'=>$startTime,'endTime'=>$endTime]);
    }
    /**
     * 提现记录
     * @return string
     */
    public function actionDeduct()
    {
        $startTime = \Yii::$app->request->get('startTime');
        $endTime   = \Yii::$app->request->get('endTime');
        $model = AgencyDeduct::find()->andWhere(['agency_id'=>\Yii::$app->session->get('agencyId')]);
        if($startTime)
            $model = $model->andWhere(['>=','time',strtotime($startTime)]);
        else
            $startTime = date('Y-m-d H:i:s',strtotime('-1 month'));

        if ($endTime)
            $model = $model->andWhere(['<=','time',strtotime($endTime)]);
        else
            $endTime = date('Y-m-d H:i:s',time());
        $pages = new Pagination(['totalCount' =>$model->count(), 'pageSize' => \Yii::$app->params['pageSize']]);
        $data = $model->offset($pages->offset)->limit($pages->limit)->all();
        return $this->render('deduct',['data'=>$data,'pages'=>$pages,'startTime'=>$startTime,'endTime'=>$endTime]);
    }
    
    /**
     * 下级代理商
     * @return string
     */
    public function actionAgency()
    {
        $model = new Agency();
        $data = $model->getDistributionAll(\Yii::$app->request->get());

        return $this->render('distribution',$data);
    }
    
    /**
     * 下级玩家
     * @return string
     */
    public function actionUsers()
    {
        $model = new Users();
        $data = $model->getDistributionAll(\Yii::$app->request->get());
        
        return $this->render('distributionUsers',$data);
    }

}