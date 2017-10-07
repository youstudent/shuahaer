<?php

namespace backend\models;

use Yii;

/**
 * This is the model class for table "{{%gold_config}}".
 *
 * @property string $name
 * @property integer $type
 * @property integer $num_code
 * @property string $en_code
 *
 * @property AgencyGold[] $agencyGolds
 * @property UsersGold[] $usersGolds
 */
class GoldConfig extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%gold_config}}';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['name'], 'required'],
            [['type', 'num_code'], 'integer'],
            [['name', 'en_code'], 'string', 'max' => 32],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'name' => '货币名',
            'type' => '1数值2时间',
            'num_code' => 'Api编码',
            'en_code' => 'Api编码',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAgencyGolds()
    {
        return $this->hasMany(AgencyGold::className(), ['gold_config' => 'name']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUsersGolds()
    {
        return $this->hasMany(UsersGold::className(), ['gold_config' => 'name']);
    }
}
