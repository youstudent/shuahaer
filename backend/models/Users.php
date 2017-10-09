<?php
/**
 * @link http://www.lrdouble.com/
 * @copyright Copyright (c) 2017 Double Software LLC
 * @license http://www.lrdouble.com/license/
 */
namespace backend\models;

use common\models\GoldConfigObject;
use common\models\UsersGoldObject;
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
    public $agency_name;
    
    public $addnum =0;
    /**
     * 充值备注
     * @var
     */
    public $notes;
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
    
    
    public $deduct_gold = 0;

    public function rules()
    {
        return [
            [['addnum'],'match','pattern'=>'/^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/','on'=>'addnum'],
            ['addnum','required','on'=>'addnum'],
            [['select','keyword','pay_gold_num','pay_gold_config','agency_name'],'safe'],
            ['pay_gold_num','integer','on'=>'pay'],
            ['pay_gold_num','match','pattern'=>'/^\+?[1-9][0-9]*$/','on'=>'pay'],
            ['pay_money','number','on'=>'pay'],
            [['starttime','endtime','autograph','notes'],'safe'],
            ['pay_gold_num','validateDeduct','on'=>'deduct'],
            ['pay_gold_num','match','pattern'=>'/^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/','on'=>'deduct'],
        ];
    }


    public function attributeLabels()
    {
        $arr = [
                'pay_gold_num'    =>'充值金额',
                'pay_money'       =>'备注',
                'pay_gold_config' =>'充值类型',
                'autograph' =>'备注',
                'deduct_gold' =>'扣除金币',
                'notes' =>'备注',
                'addnum' =>'次数',
        ];
        return ArrayHelper::merge(parent::attributeLabels(),$arr);
    }
    
    
    /**
     * 严重扣除金币是否符合要求
     * @param $attribute
     * @param $params
     */
    public function validateDeduct($attribute,$params)
    {
        if(!$this->hasErrors())
        {
            $gole = $this->getNoeGold($this->pay_gold_config);
           
        }
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
                /*$datas =[
                    'uid'=>$model->game_id,
                    'mod'=>'gm',
                    'act'=>'charge',
                    'cash'=>$this->pay_gold_num,
                    'gold_config'=>GoldConfigObject::getNumCodeByName($this->pay_gold_config)
                ];*/
                $kind = GoldConfigObject::getNumCodeByName($this->pay_gold_config);
                $url = \Yii::$app->params['ApiUserPay']."?mod=gm&act=charge&uid=".$model->game_id."&cash=".$this->pay_gold_num."&type=1"."&kind=".$kind;
                $data = Request::request_get($url);
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
                        $userModel->agency_name = $this->agency_name;
                        $userModel->user_id     = $model->id;
                        $userModel->game_id     = $model->game_id;
                        $userModel->nickname    = $model->nickname;
                        $userModel->notes       = $this->notes;
                        $userModel->time        = time();
                        $userModel->gold        = $this->pay_gold_num;
                        $userModel->money       = $this->pay_money;
                        $userModel->status      = 1;
                        $userModel->type      = 1;  //充值
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
     * 用户扣除功能
     * @param array $data
     * @return bool
     * @throws \Exception
     */
    public function deduct($data = [])
    {
        $this->scenario = 'deduct';
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
                $kind = GoldConfigObject::getNumCodeByName($this->pay_gold_config);
                $url = \Yii::$app->params['ApiUserPay']."?mod=gm&act=charge&uid=".$model->game_id."&cash=".$this->pay_gold_num."&type=2"."&kind=".$kind;
                $data = Request::request_get($url);
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
                        $data = $model->consumeGold($this->pay_gold_config,$this->pay_gold_num);
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
                        $userModel->notes       = $this->notes;
                        $userModel->time        = time();
                        $userModel->gold        = $this->pay_gold_num;
                        $userModel->money       = $this->pay_money;
                        $userModel->status      = 1;
                        $userModel->type      = 2;  //扣除
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
     * 金币排行榜
     * @return array
     */
    public function getWealth($data = [])
    {
        $this->load($data);
        $this->initTime();
        $model   = self::find()->alias('p')->joinWith('gameGold')->andWhere($this->searchWhere())
            ->andWhere(['>=','reg_time',strtotime($this->starttime)])
            ->andWhere(['<=','reg_time',strtotime($this->endtime)])->orderBy('g_users_gold.gold DESC');
        $pages = new Pagination(
            [
                'totalCount' =>$model->count(),
                'pageSize' => \Yii::$app->params['pageSize']
            ]
        );
        
        $data  = $model->limit($pages->limit)->offset($pages->offset)->limit('100')->all();
        
        foreach ($data as $key=>$value){
            $data[$key]['gold'] = $value->getGold();
        }
        
        return ['data'=>$data,'pages'=>$pages,'model'=>$this];
    }
    
    
    /**
     * 充值
     * @return array
     */
    public function PayRanking($data = [])
    {
        $this->load($data);
        $this->initTime();
        $model   = self::find()->alias('p')->joinWith('pay')->andWhere($this->searchWhere())
            ->andWhere(['>=','reg_time',strtotime($this->starttime)])
            ->andWhere(['<=','reg_time',strtotime($this->endtime)])->orderBy('g_user_pay.gold DESC');
        $pages = new Pagination(
            [
                'totalCount' =>$model->count(),
                'pageSize' => \Yii::$app->params['pageSize']
            ]
        );
        
        $data  = $model->limit($pages->limit)->offset($pages->offset)->limit('100')->all();
        
        foreach ($data as $key=>$value){
            $data[$key]['gold'] = $value->getGold();
        }
        
        return ['data'=>$data,'pages'=>$pages,'model'=>$this];
    }
    
    /**
     * 交易
     * @return array
     */
    public function getDealNum($data = [])
    {
        $this->load($data);
        $this->initTime();
        $model   = self::find()->andWhere($this->searchWhere())
            ->andWhere(['>=','reg_time',strtotime($this->starttime)])
            ->andWhere(['<=','reg_time',strtotime($this->endtime)])->orderBy('num DESC');
        $pages = new Pagination(
            [
                'totalCount' =>$model->count(),
                'pageSize' => \Yii::$app->params['pageSize']
            ]
        );
        
        $data  = $model->limit($pages->limit)->offset($pages->offset)->limit('100')->all();
        
        foreach ($data as $key=>$value){
            $data[$key]['gold'] = $value->getGold();
        }
        return ['data'=>$data,'pages'=>$pages,'model'=>$this];
    }
    
    
    //PayRanking getDealNum

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
        $model   = UserPay::find()->where(['IN','user_id',$this->searchIn($idArray)])->andWhere(['type'=>1]);
        $pages   = new Pagination(['totalCount' =>$model->count(), 'pageSize' => \Yii::$app->params['pageSize']]);
        $data    = $model->limit($pages->limit)->offset($pages->offset)->asArray()->all();
        return ['data'=>$data,'pages'=>$pages,'model'=>$this];
    }
    
    
    /**
     * 搜索并分页显示用户扣除记录
     * @param array $data
     * @return array
     */
    public function getDeductLog($data = [])
    {
        $this->load($data);
        $this->initTime();
        $model   = self::find()->andWhere($this->searchWhere())
            ->andWhere(['>=','reg_time',strtotime($this->starttime)])
            ->andWhere(['<=','reg_time',strtotime($this->endtime)]);
        $idArray = $model->asArray()->select('id')->all();
        $model   = UserPay::find()->where(['IN','user_id',$this->searchIn($idArray)])->andWhere(['type'=>2]);
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
     * 搜索处理数据函数 搜索代理玩家
     * @return array
     */
    private function searchWheres()
    {
        if (!empty($this->select) && !empty($this->keyword))
        {
            if ($this->select == 'game_id')
                return ['game_id'=>$this->keyword];
            elseif ($this->select == 'nickname')
                return ['like','nickname',$this->keyword];
            elseif ($this->select == 'place_grade')
                return ['place_grade'=>$this->keyword];
            elseif ($this->select == 'agency_code')
                return ['agency_code'=>$this->keyword];
            else
                return ['or',['game_id'=>$this->keyword],['like','nickname',$this->keyword],['place_grade'=>$this->keyword]];
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
    
    
    /**
     * 玩家停封 和解封
     * @param $game_id
     * @return
     */
    public function status($game_id)
    {
        //$url = \Yii::$app->params['ApiUserPay']."?mod=gm&act=chargeCard&uid=".$model->game_id."&card=".$this->pay_gold_num;
        $data = Users::findOne(['game_id' => $game_id]);
        if (!$data) {
            return $this->addError('game_id', '玩家不存在');
        }
        if ($data->status == 1) {
            $url = \Yii::$app->params['ApiUserPay'] . "?mod=gm&act=lockAccount&uid=" . $data->game_id; //停封
            $data->status = 0;
        } else {
            $url = \Yii::$app->params['ApiUserPay'] . "?mod=gm&act=unLockAccount&uid=" . $data->game_id; //启用
            $data->status = 1;
        }
        $re = Request::request_get($url);
        
        if ($re['code'] == 1) {
            $data->save();
            return true;
        } else {
            return $this->addError('status', $re['message']);
        }
    }
    
    /**
     * 搜索代理商下级用户
     * @return array
     */
    public function getDown($data = [])
    {
        $this->load($data);
        $this->initTime();
        $model   = self::find()->andWhere($this->searchWheres())
            ->andWhere(['>=','reg_time',strtotime($this->starttime)])
            ->andWhere(['<=','reg_time',strtotime($this->endtime)]);
        $pages = new Pagination(
            [
                'totalCount' =>$model->count(),
                'pageSize' => \Yii::$app->params['pageSize']
            ]
        );
        $data  = $model->limit($pages->limit)->offset($pages->offset)->all();
        return ['data'=>$data,'pages'=>$pages,'model'=>$this];
    }
    
    
    /**
     * 玩家和金币建立一对一关系
     * @return \yii\db\ActiveQuery
     */
    public function getGameGold(){
        return $this->hasOne(UsersGoldObject::className(),['users_id'=>'id']);
    }
    
    /**
     * 玩家和金币建立一对一关系
     * @return \yii\db\ActiveQuery
     */
    public function getPay(){
        return $this->hasMany(UserPay::className(),['user_id'=>'id']);
    }
    
    
    /**
     * 获取玩加所有金币
     * @param $id
     * @return int|mixed
     */
    public static function getPayGold($id){
      $num =   UserPay::find()->select('sum(gold)')->where(['user_id'=>$id])->asArray()->one();
      if ($num['sum(gold)']){
          return $num['sum(gold)'];
      }
          return 0;
    }
    
    /**
     * 修改玩加交易次数
     * @param $data
     * @return bool
     */
    public function editNum($data){
        $this->scenario = 'addnum';
        if ($this->load($data) && $this->validate()){
            $this->num+=$this->addnum;
           return  $this->save(false);
        }
    }
    
    
    
}