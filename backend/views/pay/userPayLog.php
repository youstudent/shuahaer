<?php
/**
 * @link http://www.lrdouble.com/
 * @copyright Copyright (c) 2017 Double Software LLC
 * @license http://www.lrdouble.com/license/
 */
$this->title = Yii::t('app', 'pay_user') . '-' . Yii::$app->params['appName'];
use yii\bootstrap\ActiveForm;

?>
<section id="content">
    <section class="vbox">
        <section class="scrollable padder">
            <!--            面包屑开始           -->
            <ul class="breadcrumb no-border no-radius b-b b-light pull-in">
                <li><a href="<?= \yii\helpers\Url::to(['site/index']) ?>"><i class="fa fa-home"></i>首页</a></li>
                <li><a href="#">用户管理</a></li>
                <li class="active">玩家充值记录</li>
            </ul>
            <!--            面包屑结束            -->
            <section class="panel panel-default">
                <div class="panel-heading">
                    <!--                搜索开始          -->
                    <div class="row text-sm wrapper">
                        <?php $form = ActiveForm::begin([
                            'action' => ['pay/user-pay-log'],
                            'method' => 'get',
                            'fieldConfig' => [
                                'template' => "{input}",
                            ],
                        ]) ?>
                        <input type="hidden" name="<?= Yii::$app->request->csrfParam ?>"
                               value="<?= Yii::$app->request->getCsrfToken() ?>">

                        <div class="form-inline" style="margin-left: 20px; margin-right: 20px;">

                            <div class="form-group">
                                <div class="controls">
                                    <div id="reportrange" class="pull-left dateRange form-control">
                                        <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                                        <span id="searchDateRange"></span>
                                        <b class="caret"></b>
                                    </div>
                                </div>
                            </div>
                            <?= $form->field($model,'starttime')->hiddenInput(['id'=>'startTime'])?>
                            <?= $form->field($model,'endtime')->hiddenInput(['id'=>'endTime'])?>

                            <div class="form-group">
                                <?= $form->field($model, 'select')
                                    ->dropDownList(["1" => Yii::t('app', 'user_select_search_all'),
                                        "game_id" => Yii::t('app', 'user_select_search_game'),
                                        "nickname" => Yii::t('app', 'user_select_search_nickname')]) ?>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <?php echo $form->field($model, 'keyword')->textInput(['class' => 'form-control', 'placeholder' => Yii::t('app', 'search_input')]) ?>
                                    <span class="input-group-btn">
                                         <button class="btn btn-default" type="submit"><i class="fa fa-search"></i>&nbsp;<?= Yii::t('app', 'search') ?>
                                         </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <?php ActiveForm::end() ?>
                    </div>
                    <!--                搜索结束          -->
                </div>
                <div class="panel-body">
                    <!--                表格开始          -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover" style="border: 0px">
                            <thead>
                            <tr>
                                <th class="text-center" style="border-left: 0px;">编号</th>
                                <th class="text-center">用户ID</th>
                                <th class="text-center">昵称</th>
                                <th class="text-center">代理名称</th>
                                <th class="text-center">充值数量</th>
                                <th class="text-center">充值类型</th>
                                <th class="text-center">人民币</th>
                                <th class="text-center">充值时间</th>
                                <th class="text-center" style="border-right: 0px;">状态</th>
                            </tr>
                            </thead>
                            <tbody>
                            <?php $i = 1; ?>
                            <?php foreach ($data as $key => $value): ?>
                                <tr>
                                    <td class="text-center" style="border-left: 0px;"><?= $i ?></td>
                                    <td class="text-center"><?= $value['game_id'] ?></td>
                                    <td class="text-center"><?= $value['nickname'] ?></td>
                                    <td class="text-center"><?= $value['agency_name'] ?></td>
                                    <td class="text-center"><?= $value['gold'] ?></td>
                                    <td class="text-center"><?= $value['gold_config'] ?></td>
                                    <td class="text-center"><?= $value['money'] ?></td>
                                    <td class="text-center"><?= date('Y-m-d H:i:s', $value['time']) ?></td>
                                    <td class="text-center" style="border-right: 0px;">
                                        <?php if ($value['status'] == 1): ?>
                                            <a href="#" class="active"">
                                        <?php else: ?>
                                        <a href="#" class="">
                                            <?php endif; ?>
                                            <i class="fa fa-check text-success text-active"></i>
                                            <i class="fa fa-times text-danger text"></i>
                                        </a>
                                    </td>
                                </tr>
                                <?php $i++ ?>
                            <?php endforeach; ?>
                            </tbody>
                        </table>
                        <?php if(empty($data)):?>
                            <div class="text-center m-t-lg clearfix wrapper-lg animated fadeInRightBig" id="galleryLoading">
                                <h1><i class="fa fa-warning" style="color: red;font-size: 40px"></i></h1>
                                <h4 class="text-muted"><?php echo sprintf(Yii::t('app','search_null'),$model->keyword)?></h4>
                                <p class="m-t-lg"></p>
                            </div>
                        <?php endif;?>
                    </div>
                    <!--                表格结束          -->
                </div>
                <!--                分页开始          -->
                <footer class="panel-footer">
                    <div class="row">
                        <div class="col-sm-12 text-right text-center-xs">
                            <?= \yii\widgets\LinkPager::widget([
                                'pagination' => $pages,
                                'options' => [
                                    'class' => 'pagination pagination-sm m-t-none m-b-none',
                                ]
                            ]) ?>
                        </div>
                    </div>
                </footer>
                <!--                分页结束          -->
            </section>
        </section>
    </section>
    <a href="" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen" data-target="#nav"></a>
</section>