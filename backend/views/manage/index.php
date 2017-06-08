<?php
/**
 * @link http://www.lrdouble.com/
 * @copyright Copyright (c) 2017 Double Software LLC
 * @license http://www.lrdouble.com/license/
 */
$this->title = Yii::t('app', '管理员列表') . '-' . Yii::$app->params['appName'];
?>
<section id="content">
    <section class="vbox">
        <section class="scrollable padder">
            <!--            面包屑开始           -->
            <ul class="breadcrumb no-border no-radius b-b b-light pull-in">
                <li><a href="/site/index"><i class="fa fa-home"></i>首页</a></li>
                <li><a href="#">公告管理</a></li>
                <li class="active">公告管理详情</li>
            </ul>
            <!--            面包屑结束            -->
            <section class="panel panel-default">
                <div class="panel-heading">
                    <!--                搜索开始          -->
                    <div class="row text-sm wrapper">
                        <div class="col-sm-9">
                            <a href="<?= \yii\helpers\Url::to(['manage/add']) ?>" class="btn btn-primary"
                               data-toggle="modal" data-target="#myModal"><i class="fa fa-plus"></i>&nbsp;添加新管理员</a>
                        </div>
                        <div class="col-sm-3 text-right">
                        </div>
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
                                <th class="text-center">姓名</th>
                                <th class="text-center">手机号</th>

                                <th class="text-center" style="border-right: 0px;">操作</th>
                            </tr>
                            </thead>
                            <tbody>

                            <?php $i = 1; ?>
                            <?php foreach ($data as $key => $value): ?>
                                <tr>
                                    <td class="text-center" style="border-left: 0px;"><?= $i ?></td>
                                    <td class="text-center"><?= $value['name'] ?></td>
                                    <td class="text-center"><?= $value['phone'] ?></td>
                                    <td class="text-center" style="border-right: 0px;">
                                        <a href="<?= \yii\helpers\Url::to(['manage/edit','id'=>$value['id']]) ?>" class="btn btn-xs btn-primary"
                                           data-toggle="modal" data-target="#myModal"> 编 辑 </a>
                                        <a href="<?= \yii\helpers\Url::to(['manage/del','id'=>$value['id']]) ?>" onclick="return openAgency(this,'确认删除吗?')" class="btn btn-xs btn-danger"> 删 除 </a>
                                    </td>
                                </tr>
                                <?php $i++ ?>
                            <?php endforeach; ?>
                            </tbody>
                        </table>
                        <?php if(empty($data)):?>
                            <div class="text-center m-t-lg clearfix wrapper-lg animated fadeInRightBig" id="galleryLoading">
                                <h1><i class="fa fa-warning" style="color: red;font-size: 40px"></i></h1>
                                <h4 class="text-muted"><?php echo sprintf(Yii::t('app','search_null'),'管理员列表')?></h4>
                                <p class="m-t-lg"></p>
                            </div>
                        <?php endif;?>
                    </div>
                </div>
                <!--                表格结束          -->
                <!--                分页开始          -->
                <footer class="panel-footer">

                </footer>
                <!--                分页结束          -->
            </section>
        </section>
    </section>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"></div>
    <a href="" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen" data-target="#nav"></a>
</section>
<script>

    //    设置封停的状态
    function setStatus(val) {
        window.location = '<?php echo \yii\helpers\Url::to(['notice/index','show'=>''],true)?>' + val;
        console.log($("#status").val());
    }
    function openAgency(_this, title) {
        swal({
                title: title,
                text: "请确认你的操作时经过再三是考虑!",
                type: "warning",
                showCancelButton: true,
                confirmButtonText: "确认",
                cancelButtonText: "取消",
                closeOnConfirm: false,
                showLoaderOnConfirm: true
            },
            function () {
                console.log(_this.href);
                $.ajax({
                    url: _this.href,
                    success: function (res) {
                        if (res.code == 1) {
                            swal(
                                {
                                    title: res.message,
                                    type: "success",
                                    showCancelButton: false,
                                    confirmButtonText: "确认",
                                    closeOnConfirm: false,
                                    showLoaderOnConfirm: true
                                }, function () {
                                    window.location.reload();
                                }
                            );
                        } else {
                            swal(
                                {
                                    title: res.message,
                                    type: "error",
                                    showCancelButton: false,
                                    confirmButtonText: "确认",
                                    closeOnConfirm: false,
                                }
                            );
                        }
                    }
                });
            });

        return false;
    }
</script>