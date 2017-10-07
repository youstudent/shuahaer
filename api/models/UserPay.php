<?php
/**
 * User: harlen-angkemac
 * Date: 2017/6/15 - 下午9:35
 *
 */

namespace api\models;


use backend\models\RebateConf;
use backend\models\RebateRatio;
use common\models\UserPayObject;

class UserPay extends UserPayObject
{
    // public $gold_config;
    
    public function clientPay($post)
    {
        if (!$this->load($post, '')) {
            return null;
        }
        $user = Users::findOne(['game_id' => $this->game_id]);
        if (!isset($user)) {
            $this->addError('user_id', '玩家不存在');
            return false;
        }
        $this->gold_config = $post['gold_config'];
        if (!$user->payGold($this->gold_config, $this->gold)) {
            $this->addError('gold', '充值失败');
            return false;
        }
        //充值成功  返利给代理商
        $this->rebate($user, $this->gold,$this->gold_config);
        $this->agency_name = '客户端';
        $this->user_id = $user->id;
        $this->nickname = $user->nickname;
        $this->status = 1;
        $this->time = time();
        $this->type = 1;
        return $this->save() ? $this : false;
    }
    
    /**
     * 玩家在线充值, 给代理商返利
     * @param $user
     * @param $gold
     * @return bool
     * @throws \Exception
     */
    public function rebate($user, $gold,$gold_config)
    {
        $row = RebateRatio::find()->one();
        $transaction = \Yii::$app->db->beginTransaction();
        try {
            //通过推荐码找玩家
            if (\Yii::$app->params['distribution']) {
                if ($user->agency_code) //\Yii::$app->params['distribution']
                {
                    $one = Agency::findOne(['code' => $user->agency_code]);
                    if ($one) {
                        $rebate = new Rebate();
                        $rebate->agency_pay_user_id = $user->game_id;
                        $rebate->agency_pay_id = 0;
                        $rebate->agency_id = $one->id;
                        $rebate->gold_num = $gold;
                        $rebate->notes = '';
                        $rebate->pay_name =$user->nickname;
                        $rebate->type = '加盟商';
                        $rebate->time = time();
                        $rebate->agency_pay_name = '客户端';
                        $rebate->agency_name = $one->name;
                        $rebate->proportion = $gold * ($row->agency_one / 100);;
                        $rebate->notes = "代理:" . $one->name . " 充值" . $gold_config . $gold . " ，你是一级代理，按返佣比例" . $row->agency_one . "%，你返利" . $rebate->proportion . "返利点";
                        $rebate->rebate_conf = "一级代理";
                        if ($rebate->save() == false) throw new \Exception("一级代理保存数据失败");
                        $one->rebate = $one->rebate + $rebate->proportion;
                        if ($one->save(false) == false) throw  new \Exception("0x00001");
                        #二级
                        if ($one->pid != 0) {
                            $two = Agency::findOne($one->pid);
                            $rebate = new Rebate();
                            $rebate->agency_pay_user_id = $one->pid;
                            $rebate->agency_pay_id = 0;
                            $rebate->agency_id = $two->id;
                            $rebate->gold_num = $gold;
                            $rebate->pay_name =$one->name;
                            $rebate->notes = '';
                            $rebate->type = '加盟商';
                            $rebate->time = time();
                            $rebate->agency_pay_name = '客户端';
                            $rebate->agency_name = $two->name;
                            $rebate->proportion = $gold * ($row->agency_two / 100);
                            $rebate->notes = "代理:" . $two->name . " 充值" . $gold_config  . $gold . " ，你是二级代理，按返佣比例" . $row->agency_two . "%，你返利" . $rebate->proportion . "返利点";
                            $rebate->rebate_conf = "二级代理";
                            if ($rebate->save() == false) throw new \Exception("二级代理保存数据失败");
                            // $data = $two->payGold($this->pay_gold_config, $rebate->gold_num);
                            // if ($data == false) throw  new \Exception("0x00002");
                            $two->rebate = $two->rebate + $rebate->proportion;
                            if ($two->save(false) == false) throw  new \Exception("0x00002");
                        }
                    }
                }
            }
            if (\Yii::$app->params['distribution_users']) {
                // 如果该玩家不是和代理绑定的关系,, 就查询是不是和玩家绑定的关系
                $Users = Users::findOne(['game_id' => $user->superior_id]);
                if ($Users) {
                    $rebate = new Rebate();
                    $rebate->agency_pay_user_id = $user->game_id;
                    $rebate->agency_pay_id = 0;
                    $rebate->agency_id = $Users->game_id;
                    $rebate->gold_num = $gold;
                    $rebate->notes = '';
                    $rebate->type = '玩家';
                    $rebate->time = time();
                    $rebate->agency_pay_name = '客户端';
                    $rebate->agency_name = $Users->nickname;
                    $rebate->proportion = $gold * ($row->users_one / 100);
                    $rebate->notes = "代理:" . $Users->nickname . " 充值" . $gold_config . $gold . " ，你是一级玩家代理，按返佣比例" . $row->users_one . "%，你返利" . $rebate->proportion . "返利点";
                    $rebate->rebate_conf = "一级玩家代理";
                    if ($rebate->save() == false) throw new \Exception("一级代理保存数据失败");
                    
                    $Users->rebate = $Users->rebate + $rebate->proportion ;
                    if ($Users->save(false) == false) throw  new \Exception("0x00002");
                }
            }
            $transaction->commit();
            return true;
        } catch (\Exception $e) {
            $transaction->rollBack();
            throw $e;
        }
        
        
    }
    
    #三级
    /*if($two->pid != 0){
        $three = self::findOne($two->pid);
        $rebate = new Rebate();
        $rebate->agency_pay_user_id = $model->id;
        $rebate->agency_pay_id = $agencyPay->id;
        $rebate->agency_id     = $three->id;
        $rebate->gold_num      = ($agencyPay->gold*($rebateConf->three/100));
        $rebate->notes         = '';
        $rebate->time          = time();
        $rebate->agency_pay_name = $model->name;
        $rebate->agency_name     = $three->name;
        $rebate->proportion      = $rebateConf->three;
        $rebate->notes           = "代理:".$model->name." 充值".$this->pay_gold_config.$agencyPay->gold." ，你是三级代理，按返佣比例".$rebateConf->three."%，你返利".$rebate->gold_num."个钻石";
        $rebate->rebate_conf   = "三级代理";
        if($rebate->save() == false)throw new \Exception("三级代理保存数据失败");
    
        $data = $three->payGold($this->pay_gold_config,$rebate->gold_num);
        if($data == false) throw  new \Exception("0x00003");
    }*/
}