<?php
/**
 * @link http://www.lrdouble.com/
 * @copyright Copyright (c) 2017 Double Software LLC
 * @license http://www.lrdouble.com/license/
 */
namespace frontend\models;

use common\models\AgencyPayObject;

/**
 * Class AgencyPay
 * @property integer $pages
 * @package frontend\models
 */
class AgencyPay extends AgencyPayObject
{
    
    
    public static function GoldAll(){
        $data =  \api\models\UserPay::find()->select('sum(gold)')->where(['agency_id'=>\Yii::$app->session->get('agencyId')])->asArray()->one();
       return $data['sum(gold)'];
    }

}