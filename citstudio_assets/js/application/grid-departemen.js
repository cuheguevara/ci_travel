
$(function(){
    var lastsel;
	
    jQuery("#gDepartemen").jqGrid({
        url:'Trefdepartemen/gridDepartemen',
        datatype: "json",
        colNames:['ID', 'NAMA'],
        colModel:[
            {name   :'departemenID',index:'departemenID',width : 50},
            {name   :'departemenNama',index:'departemenNama',editable:true,width:150}
        ],
	rownumbers  : true,
        rowNum      : 10,
        autowidth   : true,
        height      : '100%',
        multiselect : true,
        rowList     : [10,20,30],
        pager       : jQuery('#pDepartemen'),
        sortname    : 'departemenID',
        viewrecords : true,
        sortorder   : "ASC",
        loadComplete:function(){
            $("#gDepartemen").hideCol('departemenID');
        },onSelectRow:function(id){
            var id = $("#gDepartemen").getRowData(id)['departemenID'];
            var name = $("#gDepartemen").getRowData(id)['departemenNama'];
            $("#delete").show('fast');
            //jQuery(this).editRow(id, true);
        }
    }).navGrid('#pDepartemen',{edit:true,add:true,del:false});
});

/* tombol penyimpanan */
$("#save").click(function(){
    $.post("Trefdepartemen/entry",{
        departemenID              : $("#t-departemenID").val()
        , departemenNama          : $("#t-departemenNama").val()
    },function(e){
         $("#notif").html(e.alert);
         $("#gDepartemen").trigger('reloadGrid');
    },'json');
});

/* tombol perubahan data */
$("#update").click(function(){
    $.post("Trefdepartemen/update",{
        departemenID              : $("#t-departemenID").val()
        , departemenNama          : $("#t-departemenNama").val()
    },function(e){
         $("#notif").html(e.alert);
         $("#gDepartemen").trigger('reloadGrid');
    },'json');
});

/* tombol baru */
jQuery("#new").click( function() {loadUrl('Trefdepartemen');});

/* tombol edit */
jQuery("#edit").click( function() {
    var s = $("#gDepartemen").jqGrid('getGridParam','selarrrow');
    
    if (s.length > 1 || s.length < 1){
        alert('Select one for editing');
    }else{
        var id = $("#gDepartemen").getRowData(s)['departemenID'];
        $.post("Trefdepartemen/getDataDepartemen", {
            departemenID : id
        }, function(e){
            $("#t-departemenID").val(id);
            $("#t-departemenNama").val(e.departemenNama);
            $("#update").show();
            $("#save").hide();
        }, 'json')
    }
});
        
/* tombol hapus */
jQuery("#delete").click( function() {
    var s = $("#gDepartemen").jqGrid('getGridParam','selarrrow');
    if (s.length < 1){
        alert('Select one for Delete');
    }else{
        var i =0;
        var splitter = s.toString().split(',');
        alert(splitter[0]);
        for (i=0;i<$("#gDepartemen").jqGrid('getGridParam','selarrrow').length;i++){
            var id = $("#gDepartemen").getRowData(splitter[i])['departemenID'];
            $.post('Trefdepartemen/delete', {
                departemenID : id
                ,departemenNama : $("#gDepartemen").getRowData(splitter[i])['departemenNama']
            }, function(e){
                $("#notif").html(e.alert);
                $("#gDepartemen").trigger('reloadGrid');
            },'json');
        }
    }
});

