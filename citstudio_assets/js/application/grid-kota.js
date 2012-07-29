
$(function(){
    var lastsel;
	
    jQuery("#gKota").jqGrid({
        url:'Trefkota/gridKota',
        datatype: "json",
        colNames:['ID', 'NAMA'],
        colModel:[
            {name   :'kotaID',index:'kotaID',width : 50},
            {name   :'kotaNama',index:'kotaNama',editable:true,width:150}
        ],
	rownumbers  : true,
        rowNum      : 10,
        autowidth   : true,
        height      : '100%',
        multiselect : true,
        rowList     : [10,20,30],
        pager       : jQuery('#pKota'),
        sortname    : 'kotaID',
        viewrecords : true,
        sortorder   : "ASC",
        loadComplete:function(){
            $("#gKota").hideCol('kotaID');
        },onSelectRow:function(id){
            var id = $("#gKota").getRowData(id)['kotaID'];
            var name = $("#gKota").getRowData(id)['kotaNama'];
            $("#delete").show('fast');
            //jQuery(this).editRow(id, true);
        }
    }).navGrid('#pKota',{edit:true,add:true,del:false});
});

/* tombol penyimpanan */
$("#save").click(function(){
    $.post("Trefkota/entry",{
        kotaID              : $("#t-kotaID").val()
        , kotaNama          : $("#t-kotaNama").val()
    },function(e){
         $("#notif").html(e.alert);
         $("#gKota").trigger('reloadGrid');
    },'json');
});

/* tombol perubahan data */
$("#update").click(function(){
    $.post("Trefkota/update",{
        kotaID              : $("#t-kotaID").val()
        , kotaNama          : $("#t-kotaNama").val()
    },function(e){
         $("#notif").html(e.alert);
         $("#gKota").trigger('reloadGrid');
    },'json');
});

/* tombol baru */
jQuery("#new").click( function() {loadUrl('Trefkota');});

/* tombol edit */
jQuery("#edit").click( function() {
    var s = $("#gKota").jqGrid('getGridParam','selarrrow');
    
    if (s.length > 1 || s.length < 1){
        alert('Select one for editing');
    }else{
        var id = $("#gKota").getRowData(s)['kotaID'];
        $.post("Trefkota/getDataKota", {
            kotaID : id
        }, function(e){
            $("#t-kotaID").val(id);
            $("#t-kotaNama").val(e.kotaNama);
            $("#update").show();
            $("#save").hide();
        }, 'json')
    }
});
        
/* tombol hapus */
jQuery("#delete").click( function() {
    var s = $("#gKota").jqGrid('getGridParam','selarrrow');
    if (s.length < 1){
        alert('Select one for Delete');
    }else{
        var i =0;
        var splitter = s.toString().split(',');
        alert(splitter[0]);
        for (i=0;i<$("#gKota").jqGrid('getGridParam','selarrrow').length;i++){
            var id = $("#gKota").getRowData(splitter[i])['kotaID'];
            $.post('Trefkota/delete', {
                kotaID : id
                ,kotaNama : $("#gKota").getRowData(splitter[i])['kotaNama']
            }, function(e){
                $("#notif").html(e.alert);
                $("#gKota").trigger('reloadGrid');
            },'json');
        }
    }
});

