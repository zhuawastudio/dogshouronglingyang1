<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>






















































<!-- 首页 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>首页</title>
    <link rel="stylesheet" href="../../layui/css/layui.css">
    <!-- 样式 -->
    <link rel="stylesheet" href="../../css/style.css"/>
    <!-- 主题（主要颜色设置） -->
    <link rel="stylesheet" href="../../css/theme.css"/>
    <!-- 通用的css -->
    <link rel="stylesheet" href="../../css/common.css"/>
</head>
<body>

<div id="app">
    <div class="data-detail">
        <div class="data-detail-breadcrumb">
					<span class="layui-breadcrumb">
						<a href="../home/home.jsp">首页</a>
						<a><cite>{{detail.zaikuquanName}}</cite></a>
					</span>

            <!-- 收藏 -->
            <a onclick="addZaikuquanCollection()" href="javascript:void(0)">
                <i class="layui-icon" style="font-size: 20px;color: red;">&#xe67a;</i>点我收藏
            </a>

        </div>
        <div class="layui-row">
            <div class="layui-col-md5">
                <div class="layui-carousel" id="swiper">
                    <div carousel-item id="swiper-item">
                        <div v-for="(item,index) in swiperList" v-bind:key="index">
                            <img class="swiper-item" :src="item.img">
                        </div>
                    </div>
                </div>

            </div>
            <div class="layui-col-md7" style="padding-left: 20px;">
                <h1 class="title">{{detail.zaikuquanName}}</h1>

                <div v-if="detail.sexdogTypes" class="detail-item">
                    <span>狗性别：</span>
                    <span class="desc">
                        {{detail.sexdogValue}}
                    </span>
                </div>

                <div v-if="detail.zaikuquanPinzhong" class="detail-item">
                    <span>品种：</span>
                    <span class="desc">
                                {{detail.zaikuquanPinzhong}}
                            </span>
                </div>

                <div v-if="detail.zaikuquanXingge" class="detail-item">
                    <span>性格：</span>
                    <span class="desc">
                                {{detail.zaikuquanXingge}}
                            </span>
                </div>

                <div v-if="detail.jieshouTime" class="detail-item">
                    <span>接收时间：</span>
                    <span class="desc">
                        {{detail.jieshouTime}}
                    </span>
                </div>

                <div v-if="detail.sfyimiaoTypes" class="detail-item">
                    <span>是否打过疫苗：</span>
                    <span class="desc">
                        {{detail.sfyimiaoValue}}
                    </span>
                </div>

                <div v-if="detail.sfjueyuTypes" class="detail-item">
                    <span>是否绝育：</span>
                    <span class="desc">
                        {{detail.sfjueyuValue}}
                    </span>
                </div>

                <div v-if="detail.zaikuquanTypes" class="detail-item">
                    <span>犬类型：</span>
                    <span class="desc">
                        {{detail.zaikuquanValue}}
                    </span>
                </div>

                <div class="detail-item">

                    <!--<button onclick="addZaikuquanqqqqqqqq()" type="button" class="layui-btn layui-btn-warm">
                        添加到购物车
                    </button>-->
                    <button @click="jump('../zaikuquanOrder/add.jsp?id='+detail.id)" type="button" class="layui-btn btn-submit">
                        立即预定
                    </button>
                </div>

                <div class="detail-item" style="text-align: right;">
                </div>
            </div>
        </div>

        <div class="layui-row">
            <div class="layui-tab layui-tab-card">

                <ul class="layui-tab-title">

                    <li class="layui-this">详情</li>
                </ul>

                <div class="layui-tab-content">

                    <div class="layui-tab-item layui-show">
                        <div v-html="detail.zaikuquanContent"></div>
                    </div>


                </div>
            </div>
        </div>
    </div>
</div>


<script src="../../layui/layui.js"></script>
<script src="../../js/vue.js"></script>
<!-- 组件配置信息 -->
<script src="../../js/config.js"></script>
<!-- 扩展插件配置信息 -->
<script src="../../modules/config.js"></script>
<!-- 工具方法 -->
<script src="../../js/utils.js"></script>

<script>
    var vue = new Vue({
        el: '#app',
        data: {
            // 轮播图
            swiperList: [],
            // 数据详情
            detail: {
                id: 0
            },
            // 加入购物车数量
            buynumber: 1,
            // 当前详情页表
            detailTable: 'zaikuquan',
        },
        //  清除定时器
        destroyed: function () {
            // 不知道具体作用
            // window.clearInterval(this.inter);
        },
        methods: {
            jump(url) {
                jump(url)
            }
        }
    })

    layui.use(['layer', 'form', 'element', 'carousel', 'http', 'jquery', 'laypage'], function () {
        var layer = layui.layer;
        var element = layui.element;
        var form = layui.form;
        var carousel = layui.carousel;
        var http = layui.http;
        var jquery = layui.jquery;
        var laypage = layui.laypage;

        var limit = 10;

        // 设置数量
        jquery('#buynumber').val(vue.buynumber);

        // 数据ID
        var id = http.getParam('id');
        vue.detail.id = id;

        // 当前详情
        http.request(`${vue.detailTable}/detail/` + id, 'get', {}, function (res) {
            // 详情信息
            vue.detail = res.data;
           // 轮播图片
            vue.swiperList = vue.detail.zaikuquanPhoto ? vue.detail.zaikuquanPhoto.split(",") : [];
            var swiperItemHtml = '';
            for (let item of vue.swiperList) {
                swiperItemHtml +=
                        '<div>' +
                        '<img class="swiper-item" src="' + item + '">' +
                        '</div>';
            }
            jquery('#swiper-item').html(swiperItemHtml);
            // 轮播图
            carousel.render({
                elem: '#swiper',
                width: swiper.width, height: swiper.height,
                arrow: swiper.arrow,
                anim: swiper.anim,
                interval: swiper.interval,
                indicator: swiper.indicator
            });
        });



    });



        // 收藏
        function addZaikuquanCollection(){
            layui.http.requestJson(`${vue.detailTable}Collection/add`, 'post', {
                yonghuId : localStorage.getItem('userid'),
                zaikuquanId : vue.detail.id,
                tableName : localStorage.getItem('userTable')
            }, function (res) {
                if(res.code==0){
                    layer.msg('收藏成功', {
                        time: 2000,
                        icon: 6
                    });
                }else{
                    layer.msg(res.msg, {
                        time: 2000,
                        icon: 2
                    });
                }
            });
        }

        // 添加
        /*function addZaikuquanqqqqqqqq()(){
            layui.http.requestJson(`${vue.detailTable}Cart/add`, 'post', {
                yonghuId : localStorage.getItem('userid'),
                zaikuquanId : vue.detail.id,
                aaaaaaaa : vue.aaaaaaaa
            }, function (res) {
                if(res.code==0){
                    layer.msg('添加成功', {
                        time: 2000,
                        icon: 6
                    });
                }else{
                    layer.msg(res.msg, {
                        time: 2000,
                        icon: 2
                    });
                }
            });
        }*/


</script>
</body>
</html>
