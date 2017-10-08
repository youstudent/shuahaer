<?php


namespace frontend\controllers;

use dosamigos\qrcode\lib\Enum;
use dosamigos\qrcode\QrCode;
use frontend\models\Agency;
use frontend\models\AgencyPay;
use frontend\models\UserPay;
use frontend\models\Users;
use yii\web\Response;
if (!function_exists('cal_days_in_month'))
{
    function cal_days_in_month($calendar, $month, $year)
    {
        return date('t', mktime(0, 0, 0, $month, 1, $year));
    }
}
if (!defined('CAL_GREGORIAN'))
    define('CAL_GREGORIAN', 1);
/**
 * Site controller
 */

/**
 * Site controller
 */
class SiteController extends ObjectController
{

    /**
     * Displays homepage.
     *
     * @return mixed
     */
    public function actionIndex()
    {

        #获取用户基本资料
        $model = Agency::findOne(\Yii::$app->session->get('agencyId'));

        $year       = date('Y');
        $month      = date('m');
        $dayNum     = cal_days_in_month(CAL_GREGORIAN,$month,$year);//算当前月份的天数
        $startTime  = strtotime(($year."-".$month));//算出开始查询的时间戳
        $endTime    = strtotime(($year."-".$month."-".$dayNum." 23:59:59"));//算出结束查询的时间戳
        $orderMonth = [];//平台给代理的充值总金额
        $userOrder  = [];//平台给用户的充值总金额

        /**
         * 算出平台给代理充值的金额
         * 算法思路:
         *      1.查询这个月的所有销售记录
         *      2.循环并累加一个天
         *      3.进入二次循环并判断时间是否为当天、
         *          为当天并unset当前key、此操作为提高程序性能
         */
        $data = AgencyPay::find()->andWhere(['agency_id'=>\Yii::$app->session->get('agencyId')])
            ->andWhere([">",'time',$startTime])
            ->andWhere(["<","time",$endTime])
            ->orderBy("time ASC")->asArray()->all();
        for ($i=1;$i<=$dayNum;$i++){
            $oderNnm        = 0;
            $endValueTime   = strtotime(($year."-".$month."-".$i." 23:59:59"));
            $orderMonth[$i] = 0;
            foreach ($data as $key=>$value)
            {
                if($value['time'] <= $endValueTime)
                {
                    $orderMonth[$i] = ($oderNnm+$value['gold']);
                    $oderNnm        = ($oderNnm+$value['gold']);
                    unset($data[$key]);
                }elseif($value['time'] > $endValueTime){
                    continue;
                }
            }
        }

        /**
         * 算出平台给用户充值的数量
         * 算法思路 同上
         */
        $data = UserPay::find()->andWhere(['agency_id'=>\Yii::$app->session->get('agencyId')])
            ->andWhere([">",'time',$startTime])
            ->andWhere(["<","time",$endTime])
            ->orderBy("time ASC")->asArray()->all();
        for ($i=1;$i<=$dayNum;$i++){
            $oderNnm = 0;
            $endValueTime   = strtotime(($year."-".$month."-".$i." 23:59:59"));
            $userOrder[$i] = 0;
            foreach ($data as $key=>$value)
            {
                if($value['time'] <= $endValueTime)
                {
                    $userOrder[$i] = ($oderNnm+$value['gold']);
                    $oderNnm       = ($oderNnm+$value['gold']);
                    unset($data[$key]);
                }elseif($value['time'] > $endValueTime){
                    continue;
                }
            }
        }
        return $this->render('index',['model'=>$model,'monthOrderToDay'=>$orderMonth,'userOrderToDay'=>$userOrder]);
    }
    
    /**
     * 二维码下载
     * @return
     */
    public function actionDownload(){
        $FileNamePath = $this->getQRFileName();
        return \Yii::$app->response->sendFile($FileNamePath);
    
    }
    /**
     * 生成二维码
     * @return array|int
     */
    public function actionQrcode()
    {
        $agency_id = \Yii::$app->session->get('agencyId');
        $code = \Yii::$app->session->get('code');
        $FileNamePath = $this->getQRFileName();
        $url = \Yii::$app->request->getHostInfo()."wx/default/index?agency_id=$agency_id&code=$code";
        QrCode::png($url,$FileNamePath,0,10,4,true);
       // $string = QrCode::encode($url,false,Enum::QR_ECLEVEL_L,9);
        return $FileNamePath;
        // echo "<img src='{$string}'>";
        //  die();
    }
    
    /**
     * 获取文件路径名
     * @return string
     */
    public function getQRFileName(){
       $FileNamePath = 'imgcode/'.\Yii::$app->session->get('agencyId').'-'.\Yii::$app->session->get('code').'.png';
       return $FileNamePath;
    }

    /**
     * 修改密码
     * @return array|string
     */
    public function actionEditPass()
    {
        $this->layout = false;
        $model = Agency::findOne(\Yii::$app->session->get('agencyId'));
        if(\Yii::$app->request->isPost) {
            \Yii::$app->response->format = Response::FORMAT_JSON;
            if ($model->editPassword(\Yii::$app->request->post()))
            {
                return ['code'=>1,'message'=>'修改成功'];
            }
            $message = $model->getFirstErrors();
            $message = reset($message);
            return ['code'=>0,'message'=>$message];
        }
        return $this->render('editPassword',['model'=>$model]);
    }
}
