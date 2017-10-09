<?php
/**
 * @link http://www.lrdouble.com/
 * @copyright Copyright (c) 2017 Double Software LLC
 * @license http://www.lrdouble.com/license/
 */
namespace api\models;

use common\models\GoldConfigObject;
use common\models\UsersGoldObject;
use common\models\UsersObject;

class Users extends UsersObject
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['game_id', 'gold', 'gold_all', 'reg_time', 'game_count', 'status'], 'integer'],
            [['nickname'], 'string', 'max' => 32],
            [['autograph', 'head'], 'string', 'max' => 255],
            [['phone'], 'string', 'max' => 12],
            [['game_id'],'unique','on'=>'add'],
            [['game_id','nickname','gold'],'required','on'=>'add'],

        ];
    }

    /**
     * 添加会员
     * @param $data
     * @return bool
     */
    public function add($data)
    {
        $this->scenario = 'add';
        if($this->load($data,'') && $this->validate())
        {

            $this->reg_time = time();
            $this->status   = 1;
            $this->gold_all = $this->gold;
            if($this->save())
            {
                $datas = GoldConfigObject::find()->asArray()->all();

                foreach ($datas as $key=>$value)
                {
                    $agencyGold = new UsersGoldObject();
                    $agencyGold->users_id  = $this->id;
                    $agencyGold->gold_config = $value['name'];
                    $agencyGold->gold        = isset($data[$value['en_code']]) ? $data[$value['en_code']] : 0;
                    $agencyGold->sum_gold    = isset($data[$value['en_code']]) ? $data[$value['en_code']] : 0;
                    if($agencyGold->save() == false){
                        $message = $agencyGold->getFirstErrors();
                        $message = reset($message);
                        $this->addError('game_id',$message);
                        return false;
                    }
                }
                return true;
            }
        }
    }
    
    /**
     * 玩家绑定代理商
     * @param $data
     * @return
     */
    public function bound($data){
        $ageny = Agency::findOne(['code'=>$data['code']]);
        if (!$ageny){
            return $this->addError('agency_code','该推荐码不存在');
        }
        $users = Users::findOne(['game_id'=>$data['game_id']]);
        if (!$users){
            return $this->addError('game_id','该玩家不存在');
        }
        $users->agency_code=$ageny->code;
        $users->superior_name=$ageny->name;
        return $users->save(false);
    }
}