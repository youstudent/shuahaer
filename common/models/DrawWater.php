<?php

namespace common\models;

use backend\models\Users;
use Codeception\Module\REST;
use Yii;
use yii\data\Pagination;

/**
 * This is the model class for table "{{%draw_water}}".
 *
 * @property integer $id
 * @property integer $gane_id
 * @property string $nickname
 * @property integer $pay_out_money
 * @property string $winner
 * @property integer $num
 * @property integer $created_at
 */
class DrawWater extends \yii\db\ActiveRecord
{
    /**
     * 搜索时使用的用于记住筛选
     * @var string
     */
    public $select  = '';
    
    /**
     * 搜索时使用的用于记住关键字
     * @var string
     */
    public $keyword = '';
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
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%draw_water}}';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['id', 'game_id','created_at','type','roll_in_game_id'], 'integer'],
            [['nickname'], 'string', 'max' => 30],
            [['winner'], 'string', 'max' => 20],
            [['pay_out_money','num'],'number'],
            [['starttime','endtime','keyword','select','type'],'safe']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'game_id' => '玩家ID',
            'nickname' => '昵称',
            'pay_out_money' => '收入-支出',
            'winner' => '输赢',
            'num' => '数量',
            'created_at' => 'Created At',
            'type'=>'类型',
            'roll_in_game_id'=>'转入ID'
        ];
    }
    
    /**
     * 添加抽水记录
     * @param $data
     * @return bool
     */
    public function add($data){
        if($this->load($data,'') && $this->validate()){
            $model = Users::find()->where(['game_id'=>$this->game_id])->one();
            if (!$model){
                $this->addError('game_id','该玩家不存在');
                return false;
            }
            $this->nickname = $model->nickname;
            $this->created_at     = time();
            /**
             * 添加转账次数
             */
            if ($this->type ==1){
                $model->num+=1;
                $model->save(false);
            }
            
            return $this->save(false);
        }
    }
    
    
    /**
     * 搜索并分页显示用户充值记录
     * @param array $data
     * @return array
     */
    public function getList($data = [],$type)
    {
        $this->load($data);
        $this->initTime();
        $model   = self::find()->andWhere($this->searchWhere())
            ->andWhere(['>=','created_at',strtotime($this->starttime)])
            ->andWhere(['<=','created_at',strtotime($this->endtime)]);
        if ($type){
            $model->andWhere(['type'=>$type]);
        }
        $pages   = new Pagination(['totalCount' =>$model->count(), 'pageSize' => \Yii::$app->params['pageSize']]);
        $data    = $model->limit($pages->limit)->offset($pages->offset)->asArray()->orderBy('created_at DESC')->all();
        return ['data'=>$data,'pages'=>$pages,'model'=>$this];
    }
    
    
    /**
     * 检查筛选条件时间时间
     * 方法不是判断是否有错 是初始化时间
     */
    public function initTime()
    {
        if($this->starttime == '') {
//            $this->starttime = date('Y-m-d H:i:s',strtotime('-1 month'));
            $this->starttime = \Yii::$app->params['startTime'];//"2017-01-01 00:00:00";//date('Y-m-d H:i:s',strtotime('-1 month'));
        }
        if($this->endtime == '') {
            $this->endtime = date('Y-m-d H:i:s');
        }
    }
    
    
    /**
     * 搜索处理数据函数
     * @return array
     */
    private function searchWhere()
    {
        if (!empty($this->select) && !empty($this->keyword))
        {
            if ($this->select == 'game_id')
                return ['game_id'=>$this->keyword];
            elseif ($this->select == 'nickname')
                return ['like','nickname',$this->keyword];
            else
                return ['or',['game_id'=>$this->keyword],['like','nickname',$this->keyword]];
        }
        return [];
    }
}
