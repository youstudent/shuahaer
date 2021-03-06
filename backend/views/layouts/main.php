<?php
use common\services\Menu;
use yii\helpers\Html;
use yii\helpers\Url;

$config = [
    ['label' => '首页中心', 'icon' => 'fa fa-dashboard icon', 'bg_color' => 'bg-danger', 'url' => ['site/index']],
    ['label' => '用户管理', 'icon' => 'fa fa-users icon', 'bg_color' => 'bg-success', 'url' => ['product/index'], 'items' => [
        ['label' => '玩家列表', 'url' => ['users/list']],
        ['label' => '充值记录', 'url' => ['users/pay-log']],
        ['label' => '扣除记录', 'url' => ['users/deduct-log']],
        ['label' => '消费记录', 'url' => ['users/out-log']],
        ['label' => '战绩记录', 'url' => ['users/exploits']],
    ]],
    ['label' => '代理管理', 'icon' => 'fa fa-sitemap icon', 'bg_color' => 'bg-info', 'url' => ['agency/index'], 'items' => [
        ['label' => '代理列表', 'url' => ['agency/index', 'id' => 1]],
        ['label' => '加盟商充值列表', 'url' => ['pay/agency-pay-log']],
        ['label' => '加盟商扣除列表', 'url' => ['pay/agency-deduct-log']],
    ]],
];
$config[] = ['label' => '排行榜管理', 'icon' => 'fa fa-bullhorn icon', 'bg_color' => 'bg-danger', 'url' => ['ranking/wealth'], 'items' => [
    ['label' => '财富排行榜', 'url' => ['ranking/wealth']],
    ['label' => '充值排行榜', 'url' => ['ranking/pay']],
    ['label' => '交易排行榜', 'url' => ['ranking/deal']],
]];
$config[] = ['label' => '抽水管理', 'icon' => 'fa fa-bullhorn icon', 'bg_color' => 'bg-danger', 'url' => ['draw-water/list','type'=>2], 'items' => [
    ['label' => '游戏抽水记录', 'url' => ['draw-water/list','type'=>2]],
    ['label' => '游戏转账记录', 'url' => ['draw-water/list','type'=>1]]
]];
$config[] = ['label' => '公告管理', 'icon' => 'fa fa-bullhorn icon', 'bg_color' => 'bg-info', 'url' => ['notice/index'], 'items' => [
    ['label' => '公告管理', 'url' => ['notice/index']],
]];
$config[] = ['label' => '参数管理', 'icon' => 'fa fa-bullhorn icon', 'bg_color' => 'bg-danger', 'url' => ['config/indexx'], 'items' => [
    ['label' => '系统参数列表', 'url' => ['config/index','type'=>'']],
]];
if (Yii::$app->params['distribution']) {
    $config[] = ['label' => '返利管理', 'icon' => 'fa fa-dollar icon', 'bg_color' => 'bg-primary', 'url' => ['rebate/index'], 'items' => [
        ['label' => '返利规则', 'url' => ['rebate/index-ratio']],
        ['label' => '返利记录', 'url' => ['rebate/index', 'id' => 1]]
    ]];
}
$config[] = ['label' => '设置中心', 'icon' => 'fa fa-bullhorn icon', 'bg_color' => 'bg-info', 'url' => ['manage/index'], 'items' => [
    
    ['label' => '管理员列表', 'url' => ['manage/index', 'id' => 1]],
]];
if (Yii::$app->params['gold-config']){
    $config[] = ['label' => '货币配置', 'icon' => 'fa fa-mail-forward icon', 'bg_color' => 'bg-danger', 'url' => ['gold-config/index']];
}
$config[] = ['label' => '退出登录', 'icon' => 'fa fa-mail-forward icon', 'bg_color' => 'bg-danger', 'url' => ['login/logout']]
?>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <meta charset="utf-8"/>
    <title><?= html::encode($this->title) ?></title>
    <meta name="description" content=""/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <?= Html::csrfMetaTags() ?>
    <link rel="stylesheet" href="/css/app.v2.css" type="text/css"/>

    <!--    <link rel="stylesheet" href="/css/font.css" type="text/css" cache="false" />-->
    <!--[if lt IE 9]>
    <script src="/js/ie/html5shiv.js" cache="false"></script>
    <script src="/js/ie/respond.min.js" cache="false"></script>
    <script src="/js/ie/excanvas.js" cache="false"></script>
    <![endif]-->

</head>
<body>
<section class="vbox">
    <header class="bg-dark dk header navbar navbar-fixed-top-xs">

        <div class="navbar-header aside-md">
            <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen" data-target="#nav"> <i
                        class="fa fa-bars"></i> </a>
            <a href="#" class="navbar-brand" data-toggle="fullscreen"><img src="/images/logo.png" class="m-r-sm"><?php echo Yii::$app->params['appName']; ?>
            </a>
            <a class="btn btn-link visible-xs" data-toggle="dropdown" data-target=".nav-user"> <i class="fa fa-cog"></i>
            </a>
        </div>

        <ul class="nav navbar-nav navbar-right hidden-xs nav-user">
            <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"> <span
                            class="thumb-sm avatar pull-left"> <img
                                src="/images/avatar.jpg"> </span> <?= Yii::$app->session->get('manageName') ?> <b
                            class="caret"></b> </a>
                <ul class="dropdown-menu animated fadeInRight">
                    <span class="arrow top"></span>
                    <li><a href="<?= Url::to(['manage/edit-password']) ?>" data-toggle="modal"
                           data-target="#editPasswordMoal">修改密码</a></li>
                    <li class="divider"></li>
                    <li><a href="<?php echo Url::to(['login/logout']) ?>">安全退出</a></li>
                </ul>
            </li>
        </ul>
    </header>
    <section>
        <section class="hbox stretch">
            <!-- .aside 菜单开始-->
            <aside class="bg-light lter b-r aside-md hidden-print" id="nav">
                <section class="vbox">
                    <!--                    <header class="header bg-primary lter text-center clearfix">-->
                    <!--                        <div class="btn-group">-->
                    <!--                            <button type="button" class="btn btn-sm btn-dark btn-icon" title="New project"><i class="fa fa-plus"></i></button>-->
                    <!--                            <div class="btn-group hidden-nav-xs">-->
                    <!--                                <button type="button" class="btn btn-sm btn-primary dropdown-toggle">Welcome your!</button>-->
                    <!--                            </div>-->
                    <!--                        </div>-->
                    <!--                    </header>-->

                    <section class="w-f scrollable">
                        <div class="slim-scroll" data-height="auto" data-disable-fade-out="true" data-distance="0"
                             data-size="5px" data-color="#333333"> <!-- nav -->
                            <nav class="nav-primary hidden-xs">
                                <?= Menu::widget($config) ?>
                            </nav>
                            <!-- / nav --> </div>
                    </section>

                    <footer class="footer lt hidden-xs b-t b-light">
                        <div id="chat" class="dropup">
                            <section class="dropdown-menu on aside-md m-l-n">
                                <section class="panel bg-white">
                                    <header class="panel-heading b-b b-light"><?= Yii::t('app', 'layout_help') ?></header>
                                    <div class="panel-body animated fadeInRight">
                                        <p class="text-sm"><?= Yii::t('app', 'layout_content') ?></p>
                                    </div>
                                </section>
                            </section>
                        </div>
                        <a href="#nav" data-toggle="class:nav-xs" class="pull-right btn btn-sm btn-default btn-icon"> <i
                                    class="fa fa-angle-left text"></i> <i class="fa fa-angle-right text-active"></i>
                        </a>
                        <div class="btn-group hidden-nav-xs">
                            <button type="button" title="Chats" class="btn btn-icon btn-sm btn-default"
                                    data-toggle="dropdown" data-target="#chat"><i class="fa fa-comment-o"></i></button>
                        </div>
                    </footer>
                </section>
            </aside>
            <!-- /.aside菜单结束 -->
            <?= $content ?>
            <aside class="bg-light lter b-l aside-md hide" id="notes">
                <div class="wrapper">Notification</div>
            </aside>
        </section>
    </section>
    <div class="modal fade" id="editPasswordMoal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"></div>
</section>
<script src="/js/app.v2.js"></script> <!-- Bootstrap --> <!-- App -->
<script src="/js/charts/sparkline/jquery.sparkline.min.js" cache="false"></script>
<!--第三方插件导入-->
<!--alert插件-->
<link rel="stylesheet" href="/js/sweetalert-master/dist/sweetalert.css" type="text/css"/>
<script src="/js/sweetalert-master/dist/sweetalert.min.js"></script>
<!--报表插件-->
<script src="/js/echarts.min.js"></script>
<!--时间插件-->
<link rel="stylesheet" href="/js/datepicker/datepicker.css" type="text/css" cache="false">
<script src="/js/datepicker/bootstrap-datepicker.js" cache="false"></script>
<script src="/js/bootstrap-daterangepicker-master/moment.min.js" cache="false"></script>
<script type="text/javascript" src="/js/bootstrap-daterangepicker-master/daterangepicker.js" cache="false"></script>
<link rel="stylesheet" href="/js/bootstrap-daterangepicker-master/daterangepicker.css" cache="false">

<!--<script src="/js/datepicker/datepicker.css"></script>-->
<script>
    $(function () {
        $('body').on('hidden.bs.modal', '.modal', function () {
            $(this).removeData('bs.modal');
        });

        console.log("一张网页，要经历怎样的过程，才能抵达用户面前？\n一位新人，要经历怎样的成长，才能站在技术之巅？\n你，可以影响世界。\n\t\t\t\t\t\t\t\t__lrdouble");
        $('#reportrange span').html($('#startTime').val() + ' - ' + $('#endTime').val());
        $('#reportrange').daterangepicker({
            startDate: $('#startTime').val(),
            endDate: $('#endTime').val(),
            locale: {
                format: 'YYYY-MM-DD HH:mm:ss',
                applyLabel: '确定',
                cancelLabel: '取消',
                fromLabel: '起始时间',
                toLabel: '结束时间',
                customRangeLabel: '自定义',
                daysOfWeek: ['日', '一', '二', '三', '四', '五', '六'],
                monthNames: ['一月', '二月', '三月', '四月', '五月', '六月',
                    '七月', '八月', '九月', '十月', '十一月', '十二月'],
                firstDay: 1
            },
            ranges: {
                //'最近1小时': [moment().subtract('hours',1), moment()],
                '今日': [moment().startOf('day'), moment()],
                '昨日': [moment().subtract('days', 1).startOf('day'), moment().subtract('days', 1).endOf('day')],
                '最近7日': [moment().subtract('days', 6), moment()],
                '最近30日': [moment().subtract('days', 29), moment()]
            },
            "format": 'YYYY-MM-DD HH:mm:ss',
            "alwaysShowCalendars": true,
            "opens": "center"
        }, function (start, end, label) {
            console.log(start);
            $('#reportrange span').html(start.format('YYYY-MM-DD HH:mm:ss') + ' - ' + end.format('YYYY-MM-DD HH:mm:ss'));
            $('#startTime').val(start.format('YYYY-MM-DD HH:mm:ss'));
            $('#endTime').val(end.format('YYYY-MM-DD HH:mm:ss'));
            $('#lr_form').submit();
//            $('#time').val(start.format('YYYY-MM-DD HH:mm:ss') + ' - ' + end.format('YYYY-MM-DD HH:mm:ss'));
//            console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");
        });
    })
</script>
<style>
    .panel-footer {
        background-color: #ffffff;
    }

    .searchDateRange {
        text-overflow: ellipsis !important;
    }
    #reportrange{
        height: 33px;
        overflow: hidden;
    }
</style>
</body>
</html>
