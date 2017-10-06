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
        return $this->render('index');
    }

    public function actionLogin()
    {

        return Wx::goToLogin();
    }

    public function actionRedirect()
    {

        $wxModel = new Wx();
        $wxModel->getUserInfo(\Yii::$app->request->get('code'));
    }
}
