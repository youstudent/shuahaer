<?php
/**
 * @link http://www.lrdouble.com/
 * @copyright Copyright (c) 2017 Double Software LLC
 * @license http://www.lrdouble.com/license/
 */
namespace backend\controllers;

use backend\models\Agency;
use backend\models\AgencyDeduct;
use backend\models\AgencyPay;
use backend\models\UserPay;
use backend\models\Users;
use yii\data\Pagination;

class PayController extends ObjectController
{

    /**
     * 会员充值记录
     * @return string
     */
    public function actionUserPayLog()
    {
        $model = new Users();
        $data = $model->getPayLog(\Yii::$app->request->get());
        return $this->render('userPayLog',$data);
    }
    
    

    /**
 * 平台充值记录
 * 算法思路
 * @return string
 */
    public function actionAgencyPayLog()
    {
        $agency = new Agency();
        $agency->load(\Yii::$app->request->get());
        $agency->initTime();//初始化默认时间
        $model      = '';
        $row['gold']=0;
        $row['money']=0;
        //判断是否输入关键字
        if($agency->keyword != ''){
            $agencyInfo = Agency::find()->where($agency->searchWhere())->one();
            //查询代理是否存在
            if(isset($agencyInfo->id)) {
                $model = AgencyPay::find()->andWhere(['agency_id' => $agencyInfo->id]);
                
                $rows = AgencyPay::find()->select('sum(gold),sum(money)')->where(['agency_id' => $agencyInfo->id])->andWhere(['>=','time',strtotime($agency->starttime)])->andWhere(['<=','time',strtotime($agency->endtime)])->asArray()->one();
                $row['gold'] = $rows['sum(gold)'];
                $row['money'] = $rows['sum(money)'];
            } else{
                //不存在查询一个不存在代理充值记录
                $model = AgencyPay::find()->where(['id'=>-10]);
            }
        }else {$model = AgencyPay::find();
         $re= AgencyPay::find()->select(['sum(gold),sum(money)'])->andWhere(['>=','time',strtotime($agency->starttime)])->andWhere(['<=','time',strtotime($agency->endtime)])->asArray()->one();
            $row['gold'] = $re['sum(gold)'];
            $row['money'] = $re['sum(money)'];
        }//没有关键字查询所有
        // 添加查询的时间条件
        $model->andWhere(['>=','time',strtotime($agency->starttime)])->andWhere(['<=','time',strtotime($agency->endtime)]);
        $pages      = new Pagination(['totalCount' =>$model->count(), 'pageSize' => \Yii::$app->params['pageSize']]);
        $data       = $model->limit($pages->limit)->offset($pages->offset)->asArray()->orderBy('time DESC')->all();
        //统计每页充值的金币数据
        return $this->render('agencyPayLog',['model'=>$agency,'data'=>$data,'pages'=>$pages,'rows'=>$row]);
    }
    
    /**
     * 扣除
     * 算法思路
     * @return string
     */
    public function actionAgencyDeductLog()
    {
        $agency = new Agency();
        $agency->load(\Yii::$app->request->get());
        $agency->initTime();//初始化默认时间
        $model      = '';
        $row['gold']=0;
        //判断是否输入关键字
        if($agency->keyword != ''){
            $agencyInfo = Agency::find()->where($agency->searchWhere())->one();
            //查询代理是否存在
            if(isset($agencyInfo->id)) {
                $model = AgencyDeduct::find()->andWhere(['agency_id' => $agencyInfo->id]);
                $rows = AgencyDeduct::find()->select('sum(gold)')->where(['agency_id' => $agencyInfo->id])->andWhere(['>=','time',strtotime($agency->starttime)])->andWhere(['<=','time',strtotime($agency->endtime)])->asArray()->one();
                $row['gold'] = $rows['sum(gold)'];
            } else{
                //不存在查询一个不存在代理充值记录
                $model = AgencyDeduct::find()->where(['id'=>-10]);
            }
        }else {$model = AgencyDeduct::find();
            $re= AgencyDeduct::find()->select(['sum(gold)'])->andWhere(['>=','time',strtotime($agency->starttime)])->andWhere(['<=','time',strtotime($agency->endtime)])->asArray()->one();
            $row['gold'] = $re['sum(gold)'];
        }//没有关键字查询所有
        // 添加查询的时间条件
        $model->andWhere(['>=','time',strtotime($agency->starttime)])->andWhere(['<=','time',strtotime($agency->endtime)]);
        $pages      = new Pagination(['totalCount' =>$model->count(), 'pageSize' => \Yii::$app->params['pageSize']]);
        $data       = $model->limit($pages->limit)->offset($pages->offset)->asArray()->orderBy('time DESC')->all();
        return $this->render('agencyDeductLog',['model'=>$agency,'data'=>$data,'pages'=>$pages,'row'=>$row]);
    }
    
}