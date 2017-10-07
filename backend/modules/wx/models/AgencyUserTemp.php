<?php

/*
 * @link http://www.angkebrand.com/
 * @copyright Copyright (c) 2017/7/31 angke|lrdouble Software LLC
 * @license http://www.angkebrand.com/license/
 * @author lrdouble
 * @author_link http://www.lrdouble.com
 */

/**
 * @property integer $id
 * @property string $unionid
 * @property integer $agent_id
 * @property integer $code
 * @property string $create_time
 * @property integer $status
 *
 * Class AgencyUserTemp
 */
namespace backend\modules\wx\models;
class AgencyUserTemp extends \yii\db\ActiveRecord
{
    /**
     * 表名称
     * @return string
     */
    public static function tableName()
    {
        return '{{%agency_user_temp}}';
    }

    /**
     * 规则
     * @return array
     */
    public function rules()
    {
        return [
            [['unionid', 'agent_id', 'code',  'status'], 'required'],
            ['create_time','string'],
            ['unionid', 'unique']
        ];
    }

    public function attributeLabels()
    {
        return [
            'unionid' => '微信唯一的ID',
            'agent_id' => '代理ID',
            'code' => '代理推荐码',
            'create_time' => '创建时间',
            'status' => '状态',
        ];
    }

    /**
     * 添加记录的操作
     * @param $unionid
     * @param $agent_id
     * @param $code
     * @return bool
     */
    public function add($unionid, $agent_id, $code)
    {
        $this->unionid = $unionid;
        $this->agent_id = $agent_id;
        $this->code = $code;
        $this->status = 1;
        if ($this->validate() && $this->save()) {
            return true;
        }
        return false;
    }

    /**
     * 获取关系
     * @param $unionid
     * @return AgencyUserTemp|array|null|\yii\db\ActiveRecord
     */
    public static function getUnionid($unionid)
    {
        return self::find()->where(['unionid' => $unionid])->where(['status' => 1])->one();
    }

    /**
     * 删除绑定关系
     * @param $unionid
     * @return bool
     */
    public static function removeUnionid($unionid)
    {
        if ($model = self::getUnionid($unionid)) {
            return $model->delete() ? true : false;
        }
        return false;
    }

    /**
     * 保存的前置操作函数
     * @param bool $insert
     * @return bool
     */
    public function beforeSave($insert)
    {
        $this->create_time = date('Y-m-d H:i:s');
        return true;
    }

}