
$(function(){
    var lastsel;
	
    jQuery("#gManufaktur").jqGrid({
        url:'Trefmanufaktur/gridManufaktur',
        datatype: "json",
        colNames:['ID', 'NAMA'],
        colModel:[
            {name   :'manufakturID',index:'manufakturID',width : 50},
            {name   :'manufakturNama',index:'manufakturNama',editable:true,width:150}
        ],
	rownumbers  : true,
        rowNum      : 10,
        autowidth   : true,
        height      : '100%',
        multiselect : true,
        rowList     : [10,20,30],
        pager       : jQuery('#pManufaktur'),
        sortname    : 'manufakturID',
        viewrecords : true,
        sortorder   : "ASC",
        loadComplete:function(){
            $("#gManufaktur").hideCol('manufakturID');
        },onSelectRow:function(id){
            var id = $("#gManufaktur").getRowData(id)['manufakturID'];
            var name = $("#gManufaktur").getRowData(id)['manufakturNama'];
            $("#delete").show('fast');
            //jQuery(this).editRow(id, true);
        }
    }).navGrid('#pManufaktur',{edit:true,add:true,del:false});
});

/* tombol penyimpanan */
$("#save").click(function(){
    $.post("Trefmanufaktur/entry",{
        manufakturID              : $("#t-manufakturID").val()
        , manufakturNama          : $("#t-manufakturNama").val()
    },function(e){
         $("#notif").html(e.alert);
         $("#gManufaktur").trigger('reloadGrid');
    },'json');
});

/* tombol perubahan data */
$("#update").click(function(){
    $.post("Trefmanufaktur/update",{
        manufakturID              : $("#t-manufakturID").val()
        , manufakturNama          : $("#t-manufakturNama").val()
    },function(e){
         $("#notif").html(e.alert);
         $("#gManufaktur").trigger('reloadGrid');
    },'json');
});

/* tombol baru */
jQuery("#new").click( function() {loadUrl('Trefmanufaktur');});

/* tombol edit */
jQuery("#edit").click( function() {
    var s = $("#gManufaktur").jqGrid('getGridParam','selarrrow');
    
    if (s.length > 1 || s.length < 1){
        alert('Select one for editing');
    }else{
        var id = $("#gManufaktur").getRowData(s)['manufakturID'];
        $.post("Trefmanufaktur/getDataManufaktur", {
            manufakturID : id
        }, function(e){
            $("#t-manufakturID").val(id);
            $("#t-manufakturNama").val(e.manufakturNama);
            $("#update").show();
            $("#save").hide();
        }, 'json')
    }
});
        
/* tombol hapus */
jQuery("#delete").click( function() {
    var s = $("#gManufaktur").jqGrid('getGridParam','selarrrow');
    if (s.length < 1){
        alert('Select one for Delete');
    }else{
        var i =0;
        var splitter = s.toString().split(',');
        alert(splitter[0]);
        for (i=0;i<$("#gManufaktur").jqGrid('getGridParam','selarrrow').length;i++){
            var id = $("#gManufaktur").getRowData(splitter[i])['manufakturID'];
            $.post('Trefmanufaktur/delete', {
                manufakturID : id
                ,manufakturNama : $("#gManufaktur").getRowData(splitter[i])['manufakturNama']
            }, function(e){
                $("#notif").html(e.alert);
                $("#gManufaktur").trigger('reloadGrid');
            },'json');
        }
    }
});

/* tombol export */
jQuery("#export-excel").click( function() {
    $.post("Trefmanufaktur/getExcel",{}, function(e){
                $("#notif").html(e.alert);
    },'json');
                
});


