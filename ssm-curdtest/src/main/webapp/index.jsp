<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>员工列表</title>
    <!-- 关于web路径的问题
    不一/开始的路径，是以当前资源路径做为基准，经常出现问题
    以/开始的路径，是以服务器的路径作为基准的，就是以http://localhost:8080为基准
    我们使用的路径的时候需要添加项目名/资源名
     -->
   <!-- 引入JQuery的文件 -->
   <%
String path = request.getContextPath();
pageContext.setAttribute("app_path",path);
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script src="${app_path}/static/js/jquery.js"></script>
	<!-- 引入BootStrap的CSS文件 (注意link没有结束标签)-->
	<link rel="stylesheet" href="${app_path}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" >
	<!-- 引入BootStrap的JS文件 -->
	<script src="${app_path}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	
	<script >
	$(document).ready(function(){
	    to_page(1);
	   
        //45，给新建员工的按钮添加点击事件
	     $("#emp_add_btn").click(function(){
	     
	     reset_form("#empAddModal form");
	     
	     // 47，获取部门信息
	       getDepts("#dept_add_select");
	     $("#empAddModal").modal({
	     backdrop:"static"
	     });
	        });
	     //52，给新建员工模态框保存按钮设置点击事件
	     $("#emp_save_btn").click(function(){
	     //53,首先验证输入的数据格式
	     if(!check_input_form()){
	       return false;
	     }
	      if($(this).attr("ajax-valu")=="error"){
	       return false;
	     }
	      if($(this).attr("ajax-value")=="error"){
	       return false;
	     }
	     //67，使用ajax中的serialize方法将表单提交数据转变为字符串再提交
	     var data1=$("#empAddModal form").serialize();
	     
	     $.ajax({
	     url: "${app_path}/emp",
	     type: "POST",
	     data: data1,
	     success: function(result){
	     if(result.code==100){
	      //68，关闭模态框
	     $("#empAddModal").modal('hide');
	     //69，添加成功后，跳转到尾页
	      to_page(9999);
	     }else{
	     if(undefined!=result.extend.errorsFields.email){
	     check_status_msg("#email_add_input","error","email不可用或格式不正确");
	     }
	     if(undefined!=result.extend.errorsFields.empName){
	     check_status_msg("#empName_add_input","error","员工姓名格式不正确");
	     }
	     }
	    
	     }
	     });
	       });
	   
	    //63，给empName文本框添加改变事件
	     $("#empName_add_input").change(function(){
	     
	     var empName=$("#empName_add_input").val();
	     $.ajax({
	     url: "${app_path }/checkempName",
	     type: "POST",
	     data:  "empName="+empName,
	     success: function(resul){
	  
	     if(resul.code==100){
	     check_status_msg("#empName_add_input","success","用户名可用");
	     //64，给按钮设置一个自定义的属性，我们通过这个属性判断按钮是否可以提交
	     $("#emp_save_btn").attr("ajax-valu","success");
	     
	     
	     }else {
	     check_status_msg("#empName_add_input","error","用户名不可用");
	      $("#emp_save_btn").attr("ajax-valu","error");
	     }
	     
	     }
	     });
	     });
	     
	   
	     //65，给email文本框添加改变事件
	     $("#email_add_input").change(function(){
	     
	     var email=$("#email_add_input").val();
	     $.ajax({
	     url: "${app_path }/checkemp",
	     type: "POST",
	     data:  "email="+email,
	     success: function(resul){
	  
	     if(resul.code==100){
	     check_status_msg("#email_add_input","success","email可用");
	     //66，给按钮设置一个自定义的属性，我们通过这个属性判断按钮是否可以提交
	     $("#emp_save_btn").attr("ajax-value","success");
	     
	     
	     }else {
	     check_status_msg("#email_add_input","error","email不可用");
	      $("#emp_save_btn").attr("ajax-value","error");
	     }
	     
	     }
	     });
	       });
	     /*
	       由于我们的编辑按钮是发送ajax请求，获取数据，获取数据之后是通过js的dom方式生成代码
	       所以我们不能直接设置点击事件。我们需要通过一个JQuery提供的方法:
	     live():旧版本的jquery中存在的方法
	     on():新版本的jquery中存在的方法
	     */
	     
	     $(document).on("click",".edit_btn",function(){
	     //70，获取部门信息
	       getDepts("#dept_edit_select");
	       //71，获取员工的信息
	      
	       getEmp($(this).attr("edit-id"));
	        //72，动态的给弹出的模态框中的更新按钮设置属性
	        $("#emp_edit_save_btn").attr("edit-id",$(this).attr("edit-id"));
	     //73，显示模态框
	     $("#empEditModal").modal({
	     backdrop:"static"
	     });
	     });
	     
	     //79，给单个删除按钮添加点击事件
	      $(document).on("click",".delete_btn",function(){
	     
	        //80，获取要删除员工的姓名
	        var empName=$(this).parents("tr").find("td:eq(1)").text();
	         //81，获取要删除员工的ID
	        var empId=$(this).attr("del-id");
	          if(confirm("确定删除"+empName+"?"+empId)){
	          $.ajax({
	            url:"${app_path}/emp/"+empId,
	            type: "DELETE",
	            success: function(){
	            to_page(currentPage);
	            }
	          });
	          }

	     });
	     
	     
	     
	     //74，给更新员工的模态框中的更新按钮设置点击事件
	    
	     $("#emp_edit_save_btn").click(function(){
	     
	     //75，验证员工的邮箱
	      var email=$("#email_edit_input").val();
	 //76，编写验证输入员工邮箱验证的正则表达式
	 var regEmail=/^\w{4,16}@[a-zA-Z0-9]{2,6}\.(cn|com|net)$/;
	 if(!regEmail.test(email)){
	   check_status_msg("#email_edit_input","error","员工邮箱格式不正确");
	   return false;
	 }else{
	   check_status_msg("#email_edit_input","success","员工邮箱格式正确");
	   }
	    //发送更新员工数据的ajax请求
	    //通常请求只支持post和get,调用请求put，需要配置web.xml下的
	    //org.springframework.web.filter.HttpPutFormContentFilter。class过滤类
	    var data1= $("#empEditModal form").serialize();
	   
	    $.ajax({
	    url:"${app_path}/emp/"+$(this).attr("edit-id"),
	    type: "PUT",
	    data: data1,
	    success:function(result){
	  
	    //77，关闭模态框
	     $("#empEditModal").modal("hide");
	     //78，跳转到当前页
	     to_page(currentPage);
	    }
	    
	    });
	     
	     });
	     //81，为全选框设置点击事件
	     $(".check_all").click(function(){
	     $(".check_item").prop("checked",$(this).prop("checked"));
	     
	     });
	     //82，给每个小的复选框设置点击事件
	     $(document).on("click",".check_item",function(){
	     //83，判断当前选择的个数是否是所以的复选框
	     var flag=$(".check_item:checked").length==$(".check_item").length;
	     $(".check_all").prop("checked",flag);
	     });
	    
	    
	    //84，给全部删除的按钮设置点击事件
	    $("#emps_delete_btn").click(function(){
	  
	    //85，获取要删除的员工的姓名
	    var empNames="";
	    var del_ids="";
	    $.each($(".check_item:checked"),function(){
	    empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
	    del_ids+=$(this).parents("tr").find("td:eq(1)").text()+",";
	    
	    });
	    empNames=empNames.substring(0,empNames.length-1);
	    del_ids=del_ids.substring(0,del_ids.length-1);
	    if(confirm("确定要删除"+empNames+"吗??")){
	     $.ajax({
	     url:"${app_path}/emp/"+del_ids,
	     type:"DELETE",
	     success:function(){
	     $(".check_all").prop("checked",false);
	     to_page(currentPage);
	     }
	     
	     });
	    }
	    
	    
	    });
	    
	    
	    
	  
	     });
	   
	     
	     //编写获取员工信息的函数
	     function getEmp(id){
	     $.ajax({
	     url: "${app_path}/emp/"+id,
	     type: "GET",
	     success: function(result){
	       
	     var empdata=result.extend.emp;
	     $("#empName_edit_static").text(empdata.empName);
	     $("#email_edit_input").val(empdata.email);
	     $("#empEditModal input[name=gender_edit]").val([empdata.gender]);
	      $("#empEditModal select").val([empdata.dId]);
	     }
	     });
	     }
	     
	     
	     //46，编写清空表单数据的函数
	     function reset_form(ele){
	     $(ele)[0].reset();
	     $(ele).find("*").removeClass("has-error has-success");
	     $(ele).find(".help-block").text("");
	     }
	     
	//59， 编写校验成功或失败的显示信息的方法     
	  function check_status_msg(ele,status,msg){
	  //60，首先清空元素状态
	  $(ele).parent().removeClass("has-success has-error");
	  $(ele).next("span").text("");
	  //61，根据状态进行判断
	  if(status=="success"){
	  //62，使用bootstrap提供的显示样式
	  $(ele).parent().addClass("has-success");
	  $(ele).next("span").text(msg);
	  }else if(status=="error"){
	  $(ele).parent().addClass("has-error");
	  $(ele).next("span").text(msg);
	  }
	  }   
	  
	  
	 //54，编写验证输入数据的方法
	 function check_input_form(){
	 //55，获取表单输入姓名的信息
	 var empName=$("#empName_add_input").val();
	 //56，编写验证输入员工姓名验证的正则表达式
	 var regName=/^[\u4e00-\u9fa5]{2,10}|^[a-zA-Z]{4,20}$/;
	 if(!regName.test(empName)){
	   check_status_msg("#empName_add_input","error","员工姓名格式不正确");
	   return false;
	 }else{
	   check_status_msg("#empName_add_input","success","员工姓名格式正确");
	 }
	 
	  //57，获取表单输入邮箱的信息
	  var email=$("#email_add_input").val();
	 //58，编写验证输入员工邮箱验证的正则表达式
	 var regEmail=/^\w{4,16}@[a-zA-Z0-9]{2,6}\.(cn|com|net)$/;
	 if(!regEmail.test(email)){
	   check_status_msg("#email_add_input","error","员工邮箱格式不正确");
	   return false;
	 }else{
	   check_status_msg("#email_add_input","success","员工邮箱格式正确");
	 }
	 
	 return true;
	 }
	 
	 
	     
	//48，编写查询部门信息的函数
	function getDepts(ele){
	$.ajax({
	url: "${app_path}/depts",
	type: "GET",
	success: function(result){
	$(ele).empty();
	//49，向模态框添加部门数据
	
	$.each(result.extend.depts,function(){
	//50， 创建option标签
	 var option=$("<option></option>").append(this.deptName).attr("value",this.deptId);
	 //51，设置option标签添加到select中
	 option.appendTo($(ele));
	});
	}
	});
	
	}
	//44，编写跳转到某一页的函数
	function to_page(pn){
	$.ajax({
	url:"${app_path}/emps",
	data:"pn="+pn,
	type:"GET",
    success:function(result){
    //1,解析并显示员工的数据
    build_emp_table(result);
    //2,解析并显示分页的数据
    build_page_info(result);
    build_page_nav(result);
   }
	});
	}
	//编写解析并显示员工的数据
	function build_emp_table(result){
	//3,由于我们现在使用的是Ajax的请求，没有整个页面的全部刷新，所有每次添加组件前，都需要清空之前的内容
	
	   $("#emps_table tbody").empty();
	    //4,获取员工数据
	  var emps=result.extend.pageinfo.list;
	  //5，遍历员工的集合
	  $.each(emps,function(index,item){
	  //6，创建复选框TD
	    var checkTD=$("<td><input type='checkbox' class='check_item' /></td>");
	  //7，创建员工的编号的TD
	  var empIdTD=$("<td></td>").append(item.empId);
	  //8，创建员工的姓名的TD
	  var empNameTD=$("<td></td>").append(item.empName);
	  //9，创建员工的性别的TD
	  var empGenderTD=$("<td></td>").append(item.gender=="M"?"男":"女");
	  //10，创建员工的邮箱的TD
	  var empEmailTD=$("<td></td>").append(item.email);
	  //11，创建员工的部门的TD
	  var empdIdTD=$("<td></td>").append(item.department.deptName);
	  //12，创建编辑按钮
	  var editBtn=$("<button></button>").addClass("btn btn-primary edit_btn").
	  append("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑");
	  editBtn.attr("edit-id",item.empId);
	   //13，创建删除按钮
	  var delBtn=$("<button></button>").addClass("btn btn-danger delete_btn").
	  append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");
	   delBtn.attr("del-id",item.empId);
	  //14，创建按钮的TD
	  var btnTD=$("<td></td>").append(editBtn).append(delBtn);
	  //15，将td的数据添加到tr数据中，然后将tr添加到tbody中
	       $("<tr></tr>").append(checkTD).append(empIdTD).append(empNameTD).append(empGenderTD)
	       .append(empEmailTD).append(empdIdTD).append(btnTD).appendTo("#emps_table tbody");
	  });
	
	}
	
	//定义一个全局变量代表当前的页数
	var currentPage=1;
	//16，编写解析并显示分页信息的函数
	function build_page_info(result){
	//17，每次显示之前先清空
	$("#page_info_area").empty();
	//18，解析并添加分页信息数据
	$("#page_info_area").append("当前第："+result.extend.pageinfo.pageNum+"页，总共："+result.extend.pageinfo.pages+"页，总计："+
	result.extend.pageinfo.total+"条记录" );
	currentPage=result.extend.pageinfo.pageNum ;
	}
	
	
	//19，编写解析并显示分页条的函数
	function build_page_nav(result){
	//20，每次显示之前先清空
	$("#page_nav_area").empty();
	//21，创建ul标签
	var ul=$("<ul></ul>").addClass("pagination");
	//22，创建首页的li
	var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
	//23，创建尾页的li
	var lastPageLi=$("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
	//24，创建前一页的li
	var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
	//25，创建下一页的li
	var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
	//26，判断是否存在前一页
	if(result.extend.pageinfo.hasPreviousPage==false){
	   //27，不显示首页
	firstPageLi.addClass("disabled");
	//28，不显示前一页
	 prePageLi.addClass("disabled");
	} else{
	//29，给首页按钮添加点击事件
	firstPageLi.click(function(){
	 to_page(1);
	});
	//30，给前一页按钮添加点击事件,当我们在首页的时候点击前一页可能会出错
	//因为我们没有第0页，此时需要到mybatis的插件中配置pagehelper
	prePageLi.click(function(){
	to_page(result.extend.pageinfo.pageNum-1);
	});
	}
	
	//31，判断是否存在后一页
	if(result.extend.pageinfo.hasNextPage==false){
	//32，不显示尾页
	
	lastPageLi.addClass("disabled");
	//33，不显示下一页
	nextPageLi.addClass("disabled");
	
	}else{
	//34，显示下一页
	nextPageLi.click(function(){
	to_page(result.extend.pageinfo.pageNum+1);
	});
	//35，给尾页按钮添加点击事件
	lastPageLi.click(function(){
	to_page(result.extend.pageinfo.pages);
	});
	}
	//36，添加首页以及前一页
	ul.append(firstPageLi);
	ul.append(prePageLi);
	//37，创建显示页数的li
	$.each(result.extend.pageinfo.navigatepageNums,function(index,item){
	var numLi=$("<li></li>").append($("<a></a>").append(item));
	//38，判断显示的页码是否是当前的页码
	if(result.extend.pageinfo.pageNum==item){
	numLi.addClass("active");
	}
	//39，给每一个页码添加点击事件
	numLi.click(function(){
	to_page(item);
	});
	//40，将页码添加到ul
	ul.append(numLi);
	});
	//41，向ul添加下一页以及最后一页
	ul.append(nextPageLi);
	ul.append(lastPageLi);
	//42，将ul添加到导航栏
	var nav=$("<nav></nav>").append(ul);
	//43，将导航栏添加到div中
	nav.appendTo("#page_nav_area");
	}
	
	</script>
  </head>
  
  <body>
  
  <!--         模块三编辑员工                 -->
  
  <!-- 修改员工的模态框 -->
  <!-- Modal -->
  <div class="modal fade" id="empEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel1">修改员工</h4>
      </div>
      <div class="modal-body">
      
       <!-- 输入员工信息的表单 -->
       <form class="form-horizontal">
  <div class="form-group">
    <label  class="col-sm-2 control-label">empName:</label>
    <div class="col-sm-10">
      <p class="form-control-static"   id="empName_edit_static"></p>
      
      <span id="helpBlock2" class="help-block"></span>
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-2 control-label">email:</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="email" id="email_edit_input" placeholder="email">
        <span id="helpBlock2" class="help-block"></span>
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-2 control-label">gender:</label>
    <div class="col-sm-10">
      <label class="radio-inline">
    <input type="radio" name="gender" id="male_edit" value="M" checked="checked">男
   </label>
    <label class="radio-inline">
   <input type="radio" name="gender" id="female_edit" value="F"> 女
   </label>
    </div>
  </div>
  
  <div class="form-group">
    <label  class="col-sm-2 control-label">deptName:</label>
    <div class="col-sm-10">
 <select class="form-control" name="dId" id="dept_edit_select">
  
  </select>
    </div>
  </div>
</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_edit_save_btn">更新</button>
      </div>
    </div>
  </div>
</div>
  
  <!--         模块二 增添员工                 -->
  
  <!-- 新增员工的模态框 -->
  <!-- Modal -->
  <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">新增员工</h4>
      </div>
      <div class="modal-body">
      
       <!-- 输入员工信息的表单 -->
       <form class="form-horizontal">
  <div class="form-group">
    <label  class="col-sm-2 control-label">empName:</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="empName">
      <span id="helpBlock2" class="help-block"></span>
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-2 control-label">email:</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="email" id="email_add_input" placeholder="email">
        <span id="helpBlock2" class="help-block"></span>
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-2 control-label">gender:</label>
    <div class="col-sm-10">
      <label class="radio-inline">
    <input type="radio" name="gender" id="male" value="M" checked="checked">男
   </label>
    <label class="radio-inline">
   <input type="radio" name="gender" id="female" value="F"> 女
   </label>
    </div>
  </div>
  
  <div class="form-group">
    <label  class="col-sm-2 control-label">deptName:</label>
    <div class="col-sm-10">
 <select class="form-control" name="dId" id="dept_add_select">
  
  </select>
    </div>
  </div>
</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
      </div>
    </div>
  </div>
</div>
  
  
  <!--       模块一：读取数据并加载在页面                   -->
   <div class=".container">
   <!-- 标题 -->
   <div class="row">
  <div class="col-md-12">
  <h1 align="center">员工信息管理</h1>
  </div></div>
  
   <!-- 新建与删除的按钮 -->
   <div class="row">
  <div class="col-md-4 col-md-offset-8">
  <button type="button" class="btn btn-primary" id="emp_add_btn">新建</button>
  <button type="button" class="btn btn-danger" id="emps_delete_btn">删除</button>
  </div></div>
  
   <!-- 显示员工的数据-->
    <div class="row">
  <div class="col-md-12 ">
  <table class="table" id="emps_table">
  <thead>
  <tr>
  <th><input type="checkbox" class="check_all"/>  </th>
  <th>员工的编号 </th>
   <th> 员工的姓名</th>
   <th>员工的性别 </th>
   <th>员工的邮箱 </th>
     <th> 员工的部门</th>
     <th> 操作</th>
  </tr> </thead>
  <tbody>
  </tbody>
  </table>
  </div></div>
  
   <!-- 显示分页的数据 -->
   <div class="row">
   <!--1， 分页的文字信息 -->
  <div class="col-md-6" id="page_info_area">
  </div>
  <!-- 2，分页条 -->
  <div class="col-md-6" id="page_nav_area">
  </div>
  </div>
   </div>
  </body>
</html>
