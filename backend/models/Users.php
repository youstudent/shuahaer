<?php
/**
 * @link http://www.lrdouble.com/
 * @copyright Copyright (c) 2017 Double Software LLC
 * @license http://www.lrdouble.com/license/
 */
namespace backend\models;

use common\models\GoldConfigObject;
use common\models\UsersObject;
use common\services\Request;
use yii\data\Pagination;
use yii\helpers\ArrayHelper;

/**
 * 平台玩家模型类、对外提供
 * Class Userss
 * @package backend\models
 */
class Users extends UsersObject
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
     * 用户充值的金币数量
     * @var string
     */
    public $pay_gold_num = 0;

    /**
     * 用户充值类型
     * @var string
     */
    public $pay_gold_config = '';

    /**
     * 充值时候的金额
     * @var int
     */
    public $pay_money    = 0;

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

    public function rules()
    {
        return [
            [['select','keyword','pay_gold_num','pay_gold_config'],'safe'],
            ['pay_gold_num','integer','on'=>'pay'],
            ['pay_gold_num','match','pattern'=>'/^\+?[1-9][0-9]*$/','on'=>'pay'],
            ['pay_money','number','on'=>'pay'],
            [['starttime','endtime'],'safe'],
        ];
    }


    public function attributeLabels()
    {
        $arr = [
                'pay_gold_num'    =>'充值金额',
                'pay_money'       =>'收款',
                'pay_gold_config' =>'充值类型',
        ];
        return ArrayHelper::merge(parent::attributeLabels(),$arr);
    }

    /**
     * 用户充值功能
     * @param array $data
     * @return bool
     * @throws \Exception
     */
    public function pay($data = [])
    {
        $this->scenario = 'pay';
        if($this->load($data) && $this->validate())
        {
            /**
             * 查询用户是否存在
             */
            $model = self::findOne($data['id']);
            if($model)
            {
                /**
                 * 请求游戏服务器、并判断返回值进行逻辑处理
                 */
                $data = Request::request_post(\Yii::$app->params['ApiUserPay'],['game_id'=>$model->game_id,'gold'=>$this->pay_gold_num,'gold_config'=>GoldConfigObject::getNumCodeByName($this->pay_gold_config)]);
                if($data['code'] == 1)
                {
                    /**
                     * 开启数据库的事务操作
                     */
                    $transaction = \Yii::$app->db->beginTransaction();
                    try {

//                        $goldConfig = $model->getGold();
//                        foreach ($goldConfig as $key=>$val){
//
//                        }
                        $data = $model->payGold($this->pay_gold_config,$this->pay_gold_num);
                        if (!$data)
                            throw new \Exception('save error 101023'); /* 保存失败抛出异常 */

                        /**
                         * 保存用户充值记录
                         */
                        $userModel = new UserPay();
                        $userModel->agency_id   = '1';
                        $userModel->agency_name = '平台';
                        $userModel->user_id     = $model->id;
                        $userModel->game_id     = $model->game_id;
                        $userModel->nickname    = $model->nickname;
                        $userModel->time        = time();
                        $userModel->gold        = $this->pay_gold_num;
                        $userModel->money       = $this->pay_money;
                        $userModel->status      = 1;
                        $userModel->gold_config = $this->pay_gold_config;

                        /* 保存失败抛出异常 */
                        if ($userModel->save()) {
                            $transaction->commit();
                            return true;
                        }else{
                            throw new \Exception('save error 101024'.reset($userModel->getFirstErrors()));
                        }

                    } catch (\Exception $e) {
                        $transaction->rollBack();
                        throw $e;
                    }
                }else{
                    return $this->addError('pay',$data['message']);
                }
            }
        }
    }

    /**
     * 搜索并分页显示用户的数据
     * @return array
     */
    public function getList($data = [])
    {
        $this->load($data);
        $this->initTime();
        $model   = self::find()->andWhere($this->searchWhere())
                               ->andWhere(['>=','reg_time',strtotime($this->starttime)])
                               ->andWhere(['<=','reg_time',strtotime($this->endtime)]);
        $pages = new Pagination(
            [
                'totalCount' =>$model->count(),
                'pageSize' => \Yii::$app->params['pageSize']
            ]
        );

        $data  = $model->limit($pages->limit)->offset($pages->offset)->all();

        foreach ($data as $key=>$value){
            $data[$key]['gold'] = $value->getGold();
        }

        return ['data'=>$data,'pages'=>$pages,'model'=>$this];
    }

    /**
     * 搜索并分页显示用户充值记录
     * @param array $data
     * @return array
     */
    public function getPayLog($data = [])
    {
        $this->load($data);
        $this->initTime();
        $model   = self::find()->andWhere($this->searchWhere())
                ->andWhere(['>=','reg_time',strtotime($this->starttime)])
                ->andWhere(['<=','reg_time',strtotime($this->endtime)]);
        $idArray = $model->asArray()->select('id')->all();
        $model   = UserPay::find()->where(['IN','user_id',$this->searchIn($idArray)]);
        $pages   = new Pagination(['totalCount' =>$model->count(), 'pageSize' => \Yii::$app->params['pageSize']]);
        $data    = $model->limit($pages->limit)->offset($pages->offset)->asArray()->all();
        return ['data'=>$data,'pages'=>$pages,'model'=>$this];
    }

    /**
     * 搜索并分页显示用户消费记录
     * @param array $data
     * @return array
     */
    public function getOutLog($data = [])
    {
        $this->load($data);
        $this->initTime();
        $model   = self::find()->andWhere($this->searchWhere())
            ->andWhere(['>=','reg_time',strtotime($this->starttime)])
            ->andWhere(['<=','reg_time',strtotime($this->endtime)]);
        $idArray = $model->asArray()->select('id')->all();
        $model   = UserOut::find()->where(['IN','user_id',$this->searchIn($idArray)]);
        $pages   = new Pagination(['totalCount' =>$model->count(), 'pageSize' => \Yii::$app->params['pageSize']]);
        $data    = $model->limit($pages->limit)->offset($pages->offset)->asArray()->all();
        return ['data'=>$data,'pages'=>$pages,'model'=>$this];
    }

    /**
     * 搜索并分页显示用户战绩记录
     * @param array $data
     * @return array
     */
    public function getExploits($data = [])
    {
        $this->load($data);
        $this->initTime();
        $model   = self::find()->andWhere($this->searchWhere())
            ->andWhere(['>=','reg_time',strtotime($this->starttime)])
            ->andWhere(['<=','reg_time',strtotime($this->endtime)]);
        $idArray = $model->asArray()->select('id')->all();
        $model   = GameExploits::find()->where(['IN','user_id',$this->searchIn($idArray)]);
        $pages   = new Pagination(['totalCount' =>$model->count(), 'pageSize' => \Yii::$app->params['pageSize']]);
        $data    = $model->limit($pages->limit)->offset($pages->offset)->asArray()->all();
        return ['data'=>$data,'pages'=>$pages,'model'=>$this];
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

    /**
     * 处理数组 [1,2,3]
     * @param $data
     * @return array
     */
    private function searchIn($data)
    {
        $in = [];
        foreach ($data as $item)
            $in[] = $item['id'];
        return $in;
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
}