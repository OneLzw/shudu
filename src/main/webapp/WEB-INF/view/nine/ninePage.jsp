<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<style type="text/css">
	    table
		{
		    border-collapse:collapse;
		}
	
	    td 
	    { 
	        border:1px solid; 
	    } 
	  .bottomBorder {border-bottom:2px solid;}
	  .rightBorder {border-right:2px solid;}
	</style>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>9*9</title>
</head>
<body>
<script type="text/javascript" src="../jQuery/jQuery-1.7.1.js"></script>
<script type="text/javascript">
	window.onload=function(){
		initBorder();
	}
	function initBorder () {
		$("table#numtable tr:nth-child(3n)").addClass("bottomBorder");
		$("table").find("td").each(function(i){//搜寻表格里的每一个区间 
			if((i+1)%3 == 0){
				$(this).addClass("rightBorder");
			}//给区间加上特定样式 
		}); 
    }
	
	function valueChange(obj) {
		var value = obj.value;
		if (value.length > 0) {
			value = value.substring(value.length-1 , value.length);
			if (value == "0") {
				value = "";
			}
			obj.value = value;
		}
		checkValue(obj)
	}
	
	function checkValue (obj) {
		var id = obj.id;
		var x = id.substring(0,1);
		var y = id.substring(1,2);
		var value = obj.value;
		var curxObj;
		var curyObj;
		var nextObj;
		var xhasCommon = 0;
		var yhasCommon = 0;
		for (var i = 1 ; i < 10 ; i++) {
			xhasCommon = 0;
			yhasCommon = 0;
			curxObj = document.getElementById("" + x + i);
			curyObj = document.getElementById("" + i + y);
			for (var j = 1 ; j < 10 ; j++) {
				if (j != i) {
					nextObj = document.getElementById("" + x + j);
					if (curxObj.value == nextObj.value && curxObj.value != 0) {
						xhasCommon = 1;
						curxObj.style.backgroundColor="rgb(254, 112, 120)";
						nextObj.style.backgroundColor="rgb(254, 112, 120)";
					}
					nextObj = document.getElementById("" + j + y);
					if (curyObj.value == nextObj.value && curyObj.value != 0) {
						yhasCommon = 1;
						curyObj.style.backgroundColor="rgb(254, 112, 120)";
						nextObj.style.backgroundColor="rgb(254, 112, 120)";
					}
				}
			}
			if (x != y) {
				
			}
			if (xhasCommon == 0) {
				curxObj.style.backgroundColor="#fff";
			}
			if (yhasCommon == 0) {
				curyObj.style.backgroundColor="#fff";
			}
			if (x == y && x == i) {
				if (xhasCommon == 1 || yhasCommon) {
					curxObj.style.backgroundColor="rgb(254, 112, 120)";
				}
			}
		}
// 		curObj.style.backgroundColor="rgb(254, 112, 120)";
	}
	
    function jisuan () {
        var rows = "";
        var longnumber = "";
        var haveNumber = null;
        for (var i = 1 ; i < 10 ; i++) {
            rows =  document.getElementsByName(i);
            for (var j = 0; j < rows.length ; j++) {
                var number = rows[j].value;
                if (number == "") {
                    number = 0;
                } else {
                    haveNumber = document.getElementById(""+ i + (j + 1));
                    haveNumber.disabled = "disabled";
                    haveNumber.style.backgroundColor  = "#3fad";
                }
                if (j == rows.length - 1) {
                    longnumber += number;
                } else {
                    longnumber += number + ",";
                }
            }

            longnumber += ";";
        }

        $.ajax({
            type:'post',
            url:'countnine',
            // data:$("#myform").serialize(),
            data: {
                "longnumber" : longnumber
            },
            cache:false,
            dataType:'json',
            success:function(data){
                alert(data.msg);
                if (data.state) {
                	var dataArray = data.data;
                	for (var i = 0 ; i < 9 ; i++) {
                		for (var j = 0 ; j < 9 ; j++) {
                			document.getElementById(""+ (i+1) + (j+1)).value = dataArray[i][j];
                		}
                	}
                }
            }
        });
    }
    function revert () {
        for (var i = 1 ; i < 10 ; i++) {
            var rows =  document.getElementsByName(i);
            for (var j = 0; j < rows.length ; j++) {
                var haveNumber = rows[j];
                //haveNumber.value = "";
                haveNumber.disabled = "";
                haveNumber.style.backgroundColor  = "#fff";
            }
        }
    }
    
    function clean () {
    	 for (var i = 1 ; i < 10 ; i++) {
             var rows =  document.getElementsByName(i);
             for (var j = 0; j < rows.length ; j++) {
                 var haveNumber = rows[j];
                 haveNumber.value = "";
                 haveNumber.disabled = "";
                 haveNumber.style.backgroundColor  = "#fff";
             }
         }
    }
</script>


    <form action="countshu" method="post" style="padding-left: 15px">
        <table frame="box" style = "border: 2px solid" id = "numtable">
            <c:forEach var="i" begin="1" end="9" step="1">
                <tr>
                    <c:forEach var="j" begin="1" end="9" step="1">
                        <td>
                            <input type="text" id="${i}${j}" name="${i}" onkeyup='this.value=this.value.replace(/\D/gi,"")' oninput="valueChange(this)" style="width: 25px;text-align: center;border:0px;">
                        </td>
                     </c:forEach>
                </tr>
            </c:forEach>
        </table>
        <span>
            <input type="button" name="tijiao" onclick="jisuan()" value="计算" >
            <input type="button" name="chongzhi" onclick="revert()" value="重置">
            <input type="button" name="chongzhi" onclick="clean()" value="清空">
        </span>
    </form>
    </br>
    <span><a href="history">return</a></span></br>
    </br>

    <%-- <span style="float: left;">perfect</span></br>
        <#list 0..(perfectList?size)-1 as index >
        <#if index != 0 && index%6 == 0>
            </br></br></br></br>
        </#if>
        <span style="float: left;padding-left: 2px;" name="history${index}">
            <table border="1px">
                <#list 0..(perfectList[index]?size)-1 as row>
                    <tr style="width: 25px;">
                        <#list 0..(perfectList[index][row]?size)-1 as line>
                            <td style="width: 25px;text-align: center" >
                                <span>${perfectList[index][row][line]}</span>
                            </td>
                        </#list>
                    </tr>
                </#list>
            </table>
        </span>
    </#list>
    </br></br></br></br></br>

    <span style="float: left;">history</span></br>
    <#list 0..(list?size)-1 as index >
        <#if index != 0 && index%6 == 0>
            </br></br></br></br>
        </#if>
        <span style="float: left;padding-left: 2px;" name="history${index}">
            <table border="1px">
                <#list 0..(list[index]?size)-1 as row>
                    <tr style="width: 25px;">
                        <#list 0..(list[index][row]?size)-1 as line>
                            <td style="width: 25px;text-align: center" >
                                <span>${list[index][row][line]}</span>
                            </td>
                        </#list>
                    </tr>
                </#list>
            </table>
        </span>
    </#list> --%>
</body>
</html>