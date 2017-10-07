<?php
/**
 * @link http://www.lrdouble.com/
 * @copyright Copyright (c) 2017 Double Software LLC
 * @license http://www.lrdouble.com/license/
 */

namespace backend\models;
use common\models\RebateObject;

class Rebate extends RebateObject{
    
    public $select;
    public $keyword;
    /**
     * 时间筛选开始时间
     * @return array
     */
    public $starttime     = '';
    
    /**
     * 时间筛选开始时间
     * @return array
     */
    public $endtime      = 0;
    
    /**
     * 检查筛选条件时间时间
     * 方法不是判断是否有错 是初始化时间
     */
    public function initTime()
    {
        if($this->starttime == '') {
            $this->starttime = \Yii::$app->params['startTime'];
        }
        if($this->endtime == '') {
            $this->endtime = date('Y-m-d H:i:s');
        }
    }
    
    
    /**
     * 搜索处理数据函数
     * @return array
     */
    public function searchWhereLikes()
    {
        if (!empty($this->select) && !empty($this->keyword))
        {
            if ($this->select == 'agency_id')
                return ['like','agency_id',$this->keyword];
            elseif ($this->select == 'agency_name')
                return ['like','agency_name',$this->keyword];
            else
                return ['or',['like','agency_id',$this->keyword],['like','agency_name',$this->keyword]];
        }
        return [];
    }


}