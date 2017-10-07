<?php

namespace backend\modules\wx\controllers;

use backend\modules\wx\models\Wx;
use yii\web\Controller;

/**
 * 微信授权和逻辑处理控制器
 * 1.判断是否授权。
 * 2.授权是否绑定。
 * 3.授权绑定关系。
 */
class DefaultController extends Controller
{

    public $layout = false;

    /**
     * Renders the index view for the module
     * @return string
     */
    public function actionIndex()
    {
        $request = \Yii::$app->request;
        $session = \Yii::$app->session;
        if (!empty($request->get('agency_id')) && !empty($request->get('code'))) {
            $session->set('agency_id', $request->get('agency_id'));
            $session->set('code', $request->get('code'));
            return Wx::goToLogin();
        }
        return $this->render('index');
    }

    /**
     * 用户授权后绑定成功的微信回调函数
     */
    public function actionRedirect()
    {
        $wxModel = new Wx();
        if ($wxModel->getUserInfo(\Yii::$app->request->get('code'))) {
            die('添加成功！');
        }
    }
}
