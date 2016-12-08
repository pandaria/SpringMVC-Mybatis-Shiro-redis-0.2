<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.sojson.common.utils.DateUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%> 
<%--shiro 标签 --%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
String version = DateUtil.dateToStringWithTime();

%>

<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>安全提交Demo  —个人中心</title>
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<link   rel="icon" href="http://img.wenyifan.net/images/favicon.ico" type="image/x-icon" />
		<link   rel="shortcut icon" href="http://img.wenyifan.net/images/favicon.ico" />
		<link href="${basePath}/js/common/bootstrap/3.3.5/css/bootstrap.min.css?<%= version %>" rel="stylesheet"/>
		<link href="${basePath}/css/common/base.css?<%= version %>" rel="stylesheet"/>
	</head>
	<body data-target="#one" data-spy="scroll">
		
		<!--  top 0 start -->
		<base href="<%=basePath%>">
		<script baseUrl="${basePath}" src="<%=basePath%>/js/user.login.js"></script>
		<div class="navbar navbar-inverse navbar-fixed-top animated fadeInDown" style="z-index: 101;height: 41px;">
			  
		      <div class="container" style="padding-left: 0px; padding-right: 0px;">
		        <div class="navbar-header">
		          <button data-target=".navbar-collapse" data-toggle="collapse" type="button" class="navbar-toggle collapsed">
		            <span class="sr-only">导航</span>
		            <span class="icon-bar"></span>
		            <span class="icon-bar"></span>
		            <span class="icon-bar"></span>
		          </button>
			     </div>
			     <div role="navigation" class="navbar-collapse collapse">
			     		<a id="_logo"  href="http://shiro.itboy.net/" style="color:#fff; font-size: 24px;" class="navbar-brand hidden-sm">SSM + Shiro Demo 演示</a>
			          <ul class="nav navbar-nav" id="topMenu">
						<li class="dropdown ">
							<a aria-expanded="false" aria-haspopup="true" role="button" data-toggle="dropdown" class="dropdown-toggle" href="/user/index.shtml">
								个人中心<span class="caret"></span>
							</a>
							<ul class="dropdown-menu">
								<li><a href="/user/index.shtml">个人资料</a></li>
								<li><a href="/user/updateSelf.shtml" >资料修改</a></li>
								<li><a href="/user/updatePswd.shtml" >密码修改</a></li>
								<li><a href="/role/mypermission.shtml">我的权限</a></li>
							</ul>
						</li>	  
						<%--拥有 角色888888（管理员） ||  100002（用户中心）--%>
						<shiro:hasAnyRoles name='888888,100002'>          
						<li class="dropdown ">
							<a aria-expanded="false" aria-haspopup="true"  role="button" data-toggle="dropdown" class="dropdown-toggle" href="/member/list.shtml">
								用户中心<span class="caret"></span>
							</a>
							<ul class="dropdown-menu">
								<shiro:hasPermission name="/member/list.shtml">
									<li><a href="/member/list.shtml">用户列表</a></li>
								</shiro:hasPermission>
								<shiro:hasPermission name="/member/online.shtml">
									<li><a href="/member/online.shtml">在线用户</a></li>
								</shiro:hasPermission>
							</ul>
						</li>	
						</shiro:hasAnyRoles>         
						<%--拥有 active888888（管理员） ||  100003（权限频道）--%>
						<shiro:hasAnyRoles name='888888,100003'>
							<li class="dropdown active">
								<a aria-expanded="false" aria-haspopup="true"  role="button" data-toggle="dropdown" class="dropdown-toggle" href="/permission/index.shtml">
									权限管理<span class="caret"></span>
								</a>
								<ul class="dropdown-menu">
									<shiro:hasPermission name="/role/index.shtml">
										<li><a href="/role/index.shtml">角色列表</a></li>
									</shiro:hasPermission>
									<shiro:hasPermission name="/role/allocation.shtml">
										<li><a href="/role/allocation.shtml">角色分配</a></li>
									</shiro:hasPermission>
									<shiro:hasPermission name="/permission/index.shtml">
										<li><a href="/permission/index.shtml">权限列表</a></li>
									</shiro:hasPermission>
									<shiro:hasPermission name="/permission/allocation.shtml">
										<li><a href="/permission/allocation.shtml">权限分配</a></li>
									</shiro:hasPermission>
								</ul>
							</li>	
						</shiro:hasAnyRoles>
						<!-- 
						<li>
							<a class="dropdown-toggle" target="_blank" href="http://www.sojson.com/tag/shiro">
								Shiro 博客<span class="collapsing"></span>
							</a>
						</li>	          
						<li>
							<a class="dropdown-toggle" href="http://www.sojson.com/shiro">
								本项目介绍<span class="collapsing"></span>
							</a>
						</li>
						 -->          
			          </ul>
			           <ul class="nav navbar-nav  pull-right" >
						<li class="dropdown " style="color:#fff;">
							<%--已经登录（包括记住我的）--%>
							<shiro:user>  
								<a aria-expanded="false" aria-haspopup="true"  role="button" data-toggle="dropdown" onclick="location.href='/user/index.shtml'" href="/user/index.shtml" class="dropdown-toggle qqlogin" > 
								<shiro:principal property="nickname"/>
								<span class="caret"></span></a>
								<ul class="dropdown-menu" userid="<shiro:principal property="id"/>">
									<li><a href="#">个人资料</a></li>
									<li><a href="#">我的权限</a></li>
									<li><a href="javascript:void(0);" onclick="logout();">退出登录</a></li>
								</ul>
							</shiro:user>   
		
							<%--没有登录(游客)--%>
							<shiro:guest>  
								 <a aria-expanded="false" aria-haspopup="true"  role="button" data-toggle="dropdown"  href="javascript:void(0);" class="dropdown-toggle qqlogin" >
								<img src="http://qzonestyle.gtimg.cn/qzone/vas/opensns/res/img/Connect_logo_1.png">&nbsp;登录</a>
							</shiro:guest>  
						</li>	
			          </ul>
			          <style>#topMenu>li>a{padding:10px 13px}</style>
			    </div>
		  	</div>
		</div>
		<!-- top 0 end -->
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<#--row-->
			<div class="row">
				<!-- @_left.user 2 start -->
				<div id="one" class="col-md-2">
					<ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
					  <li class="">
					      <a href="${basePath}/user/index.shtml">
					    	 <i class="glyphicon glyphicon-chevron-right"></i>个人资料
					      </a>
					       <ul class="dropdown-menu" aria-labelledby="dLabel" style="margin-left: 160px; margin-top: -40px;">
				              <li><a href="${basePath}/user/updateSelf.shtml">资料修改</a></li>
				              <li><a href="${basePath}/user/updatePswd.shtml">密码修改</a></li>
				          </ul>
					  </li>
					  <li class="active dropdown">
					      <a href="${basePath}/role/mypermission.shtml">
					    	 <i class="glyphicon glyphicon-chevron-right"></i>我的权限
					      </a>
					  </li>
					</ul>
				</div>
				<!-- @_left.user 2 end -->
				<div class="col-md-10">
					<h2>安全提交测试</h2>
					<hr>
					<div id="getPermissionTree" >
						<form class=" col-md-8" method="post" action="${basePath}/demo/submit/${urlPart}.shtml" enctype="multipart/form-data" id="formId">
						  <input type="hidden" name="id" value="1">
						  <div class="form-group">
						     <div class="input-group">
							     <span class="input-group-btn">
						            <button class="btn btn-default" type="button">Phone</button>
						          </span>
						          <input type="text" class="form-control" name="${phone}" >
						          <div class="input-group-btn">
						            <button type="button" class="btn btn-success">发送验证码</button>
						          </div>
				        	  </div>
						  </div>
						  <div class="form-group">
						     <div class="input-group">
							     <span class="input-group-btn">
						            <button class="btn btn-default" type="button">LoginName</button>
						          </span>
						          <input type="text" class="form-control" name="${loginName}" >
				        	  </div>
						  </div>
						  <div class="form-group">
						     <div class="input-group">
							     <span class="input-group-btn">
						            <button class="btn btn-default" type="button">Password</button>
						          </span>
						          <input type="text" class="form-control" name="${password}">
				        	  </div>
						  </div>
						  <div class="form-group">
							  <button class="btn btn-success pull-right" type="submit">提交信息</button>
						  </div>
					    	<p class="help-block"></p>
						</form>
					
					</div>
				</div>
			</div>
			<#--/row-->
		</div>
		<script  src="http://open.sojson.com/common/jquery/jquery1.8.3.min.js"></script>
		<script  src="${basePath}/js/common/layer/layer.js"></script>
		<script  src="${basePath}/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script  src="${basePath}/js/common/bootstrap/bootstrap-treeview.js"></script>
		<script  src="${basePath}/js/shiro.demo.js"></script>
	</body>
</html>