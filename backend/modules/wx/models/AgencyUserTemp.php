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
use backend\models\Agency;
use backend\models\Users;

class AgencyUserTemp extends \yii\db\ActiveRecord
{
    public $message;
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
    
    /**
     * 1.获取玩家信息 2.添加账号 3.绑定玩家代理关系
     * @param $unionid
     * @param $agent_id
     * @param $code
     * @return bool
     */
    public function getUsers($unionid, $agent_id, $code)
    {
        $agency = Agency::findOne(['id' => $agent_id]);//代理商账号
        if (!$agency) {
            $this->message = '该代理商不存在';
            return false; //该代理商不存在
        }
        if ($agency->status !== 1) {
            $this->message = '该代理商不存在';
            return false; //该账号不是正常状态,不能进行绑定
        }
        $user = Users::findOne(['unionid' => $unionid]);
        if (!$user) {
            if (!$this->addUsers($unionid,$agent_id,$agency->code,$agency->name)){
            
            }
            return true;
            
            //TODO 账号不存在,发送消息给, 游戏服务端注册账号
        }
        $users = Users::findOne(['unionid' => $unionid, 'code' => $code]);
        if ($users) {
            //TODO 该账号已经绑定过代理了 直接跳转到下载页面
            $this->message ='该账号已经绑定过代理了 直接跳转到下载页面';
            return false;
        }
        //TODO 账号存在并且玩家没有绑定过代理关系,绑定玩家关系
        $user->superior_id = $agent_id;
        $user->superior_name = $agency->name;
        $user->agency_code = $agency->code;
        return $user->save();
    }
    
    //TODO 把账号信息发送给,游戏服务区帮我们注册并绑定代理关系
    public function addUsers($unionid,$agent_id,$code,$aname){
    
    }

}