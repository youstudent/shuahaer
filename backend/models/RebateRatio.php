<?php

namespace backend\models;

use Yii;

/**
 * This is the model class for table "{{%rebate_ratio}}".
 *
 * @property integer $id
 * @property integer $agency_one
 * @property integer $agency_two
 * @property integer $users_one
 */
class RebateRatio extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%rebate_ratio}}';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['agency_one','agency_two','users_one'], 'required'],
            [['id', 'agency_one', 'agency_two', 'users_one'], 'number'],
            [['agency_one', 'agency_two', 'users_one'], 'validateNumber'],
        ];
    }
    
    public function validateNumber(){
        if ($this->agency_one <0 || $this->agency_one>100){
            $this->addError('agency_one','范围0-100之间');
        }
        if ($this->agency_two <0 || $this->agency_two>100){
            $this->addError('agency_one','范围0-100之间');
        }
        if ($this->users_one <0 || $this->users_one>100){
            $this->addError('agency_one','范围0-100之间');
        }
    }
    

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'agency_one' => '一级加盟代理',
            'agency_two' => '二级加盟代理',
            'users_one' => '一级玩家代理',
        ];
    }
    
    
    
}
