<?php

namespace common\models;

use Codeception\Module\REST;
use common\services\Request;
use Yii;

/**
 * This is the model class for table "{{%draw_water_ratio}}".
 *
 * @property integer $id
 * @property integer $ratio
 * @property integer $updated_at
 */
class DrawWaterRatio extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%draw_water_ratio}}';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['id'], 'required'],
            [['id', 'ratio', 'updated_at'], 'integer'],
        ];
    }
    
    /**
     *  现在比例范围
     */
    public function validateRatio()
    {
        if ($this->ratio<1 || $this->ratio>100){
            $this->addError('ratio','比例在1-100之间');
        }
    }
    
    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'ratio' => '比例%',
            'updated_at' => 'Updated At',
        ];
    }
    
    /**
     * 修改抽水比例范围
     * @param $data
     * @return bool
     */
    public function edit($data){
        if ($this->load($data) && $this->validate()){
            $url = \Yii::$app->params['ApiUserPay']."?mod=gm&act=pumpProportion&pump=".$this->ratio;
            $data = Request::request_get($url);
            if($data['code'] == 1){
                $this->updated_at =time();
                return $this->save();
            }
                return false;
        }
        
    }
}
