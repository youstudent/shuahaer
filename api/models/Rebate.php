<?php

namespace api\models;

use Yii;

/**
 * This is the model class for table "{{%rebate}}".
 *
 * @property integer $id
 * @property integer $agency_pay_id
 * @property string $agency_pay_name
 * @property integer $agency_pay_user_id
 * @property string $agency_id
 * @property string $agency_name
 * @property string $gold_num
 * @property string $notes
 * @property string $time
 * @property string $rebate_conf
 * @property integer $proportion
 * @property string $type
 *
 * @property Agency $agency
 */
class Rebate extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%rebate}}';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['agency_pay_id', 'agency_pay_user_id', 'agency_id', 'time', 'proportion'], 'integer'],
            [['gold_num'], 'number'],
            [['agency_pay_name', 'agency_name'], 'string', 'max' => 32],
            [['notes','pay_name'], 'string', 'max' => 255],
            [['rebate_conf'], 'string', 'max' => 11],
            [['type'], 'string', 'max' => 20],
            [['agency_id'], 'exist', 'skipOnError' => true, 'targetClass' => Agency::className(), 'targetAttribute' => ['agency_id' => 'id']],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'agency_pay_id' => 'Agency Pay ID',
            'agency_pay_name' => 'Agency Pay Name',
            'agency_pay_user_id' => 'Agency Pay User ID',
            'agency_id' => 'Agency ID',
            'agency_name' => 'Agency Name',
            'gold_num' => 'Gold Num',
            'notes' => 'Notes',
            'time' => 'Time',
            'rebate_conf' => 'Rebate Conf',
            'proportion' => 'Proportion',
            'type' => 'Type',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAgency()
    {
        return $this->hasOne(Agency::className(), ['id' => 'agency_id']);
    }
}
