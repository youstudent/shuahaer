<?php

namespace api\models;

use Yii;

/**
 * This is the model class for table "{{%agency}}".
 *
 * @property string $id
 * @property string $pid
 * @property string $phone
 * @property string $password
 * @property string $name
 * @property string $reg_time
 * @property string $gold
 * @property string $gold_all
 * @property string $identity
 * @property integer $status
 * @property string $code
 * @property integer $manage_id
 * @property string $manage_name
 * @property string $rebate
 * @property string $place_grade
 *
 * @property AgencyDeduct[] $agencyDeducts
 * @property AgencyGold[] $agencyGolds
 * @property AgencyPay[] $agencyPays
 * @property Rebate[] $rebates
 * @property UserDedict[] $userDedicts
 * @property UserPay[] $userPays
 */
class Agency extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%agency}}';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['pid', 'reg_time', 'gold_all', 'status', 'code', 'manage_id'], 'integer'],
            [['gold', 'rebate'], 'number'],
            [['phone'], 'string', 'max' => 12],
            [['password'], 'string', 'max' => 64],
            [['name', 'identity', 'manage_name'], 'string', 'max' => 32],
            [['place_grade'], 'string', 'max' => 20],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'pid' => 'Pid',
            'phone' => 'Phone',
            'password' => 'Password',
            'name' => 'Name',
            'reg_time' => 'Reg Time',
            'gold' => 'Gold',
            'gold_all' => 'Gold All',
            'identity' => 'Identity',
            'status' => 'Status',
            'code' => 'Code',
            'manage_id' => 'Manage ID',
            'manage_name' => 'Manage Name',
            'rebate' => 'Rebate',
            'place_grade' => 'Place Grade',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAgencyDeducts()
    {
        return $this->hasMany(AgencyDeduct::className(), ['agency_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAgencyGolds()
    {
        return $this->hasMany(AgencyGold::className(), ['agency_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAgencyPays()
    {
        return $this->hasMany(AgencyPay::className(), ['agency_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getRebates()
    {
        return $this->hasMany(Rebate::className(), ['agency_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUserDedicts()
    {
        return $this->hasMany(UserDedict::className(), ['agency_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUserPays()
    {
        return $this->hasMany(UserPay::className(), ['agency_id' => 'id']);
    }
}
