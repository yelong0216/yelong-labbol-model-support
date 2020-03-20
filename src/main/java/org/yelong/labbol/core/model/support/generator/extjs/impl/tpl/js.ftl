Co.initialize();

Ext.onReady(function() {
	var API = {
		save${code.className} : "${code.classNameActionInvocation}/save",
		query${code.className} : "${code.classNameActionInvocation}/query",
		delete${code.className} : "${code.classNameActionInvocation}/delete",
		retrieve${code.className} : "${code.classNameActionInvocation}/retrieve"
	};
	
	//============================ Model =========================
	Co.defineModel("${code.className}", [${code.classFields}]);
	//============================ Store =========================
	var ${code.classNameLowerPrefix}GridStore = Co.gridStore("${code.classNameLowerPrefix}GridStore", API.query${code.className}, "${code.className}", {
		autoLoad : false,
		output : "${code.classNameLowerPrefix}Tbar",
		sorters : [{
			property : "createTime",
			direction : "desc"
		}]
	});
		
	//============================ View =========================
	var ${code.classNameLowerPrefix}Tbar = Co.toolbar("${code.classNameLowerPrefix}Tbar", [{
			type : "+", 
			handler : add${code.className},
			showAtContextMenu : true
		},{
			type : "*",
			handler : delete${code.className},
			showAtContextMenu : true
		},{
			type : "-",
			handler : edit${code.className},
			showAtContextMenu : true
		},"->",{
			type : "@",
			handler : search${code.className},
			searchField : [],
			searchEmptyText : []
		}
	]);
	
	var ${code.classNameLowerPrefix}Columns = [
		${code.gridColumns}
	];
	
	var ${code.classNameLowerPrefix}Grid = Co.grid("${code.classNameLowerPrefix}Grid", ${code.classNameLowerPrefix}GridStore, ${code.classNameLowerPrefix}Columns, ${code.classNameLowerPrefix}Tbar, null, {
		listeners : {
			itemdblclick : function(view, record) {
				edit${code.className}();
			}
		}
	});
	
	Co.load(${code.classNameLowerPrefix}GridStore);
	
	var ${code.classNameLowerPrefix}Form = Co.form(API.save${code.className}, [${code.formItems}]);
	
	var ${code.classNameLowerPrefix}FormWindow = Co.formWindow("新增", ${code.classNameLowerPrefix}Form, ${code.formWindowWidth}, ${code.formWindowHeight}, "fit", {
		okHandler : save${code.className}
	});
	
	Ext.create("Ext.container.Viewport", {
		layout : "fit",
		items : ${code.classNameLowerPrefix}Grid
	});
	//============================ Function =========================
	function add${code.className}() {
		Co.resetForm(${code.classNameLowerPrefix}Form, true);
		${code.classNameLowerPrefix}FormWindow.setTitle("新增");
		${code.classNameLowerPrefix}FormWindow.show();
	}
	
	function save${code.className}() {
		Co.formSave(${code.classNameLowerPrefix}Form, function(form, action){
			Co.alert("保存成功！", function(){
				${code.classNameLowerPrefix}FormWindow.hide();
				Co.reload(${code.classNameLowerPrefix}GridStore);
			});
		});
	}
	
	function edit${code.className}() {
		Co.formLoad(${code.classNameLowerPrefix}Form, ${code.classNameLowerPrefix}Grid, API.retrieve${code.className}, function(result, opts, selectedId){
			if (true === result.success) {
				${code.classNameLowerPrefix}FormWindow.setTitle("修改");
				${code.classNameLowerPrefix}FormWindow.show();
			} else {
				Co.showError(result.msg || "数据加载失败！");
			}
		});
	}
	
	function delete${code.className}() {
		Co.gridDelete(${code.classNameLowerPrefix}Grid, API.delete${code.className}, function(result){
			if (result.success === true) {
				Co.alert("删除成功！", function(){
					Co.reload(${code.classNameLowerPrefix}GridStore);
				});
			} else {
				Co.alert(result.msg);
			}
		});	
	}
	
	function search${code.className}() {
		Co.load(${code.classNameLowerPrefix}GridStore);
	}
});