
$(function(){
    var lastsel;
	
    jQuery("#gPropinsi").jqGrid({
        url:'Trefpropinsi/gridPropinsi',
        datatype: "json",
        colNames:['ID', 'NAMA'],
        colModel:[
            {name   :'propinsiID',index:'propinsiID',width : 50},
            {name   :'propinsiNama',index:'propinsiNama',editable:true,width:150}
        ],
	rownumbers  : true,
        rowNum      : 10,
        autowidth   : true,
        height      : '100%',
        multiselect : true,
        rowList     : [10,20,30],
        pager       : jQuery('#pPropinsi'),
        sortname    : 'propinsiID',
        viewrecords : true,
        sortorder   : "ASC",
        loadComplete:function(){
            $("#gPropinsi").hideCol('propinsiID');
        },onSelectRow:function(id){
            var id = $("#gPropinsi").getRowData(id)['propinsiID'];
            var name = $("#gPropinsi").getRowData(id)['propinsiNama'];
            $("#delete").show('fast');
            //jQuery(this).editRow(id, true);
        }
    }).navGrid('#pPropinsi',{edit:true,add:true,del:false});
});

/* tombol penyimpanan */
$("#save").click(function(){
    $.post("Trefpropinsi/entry",{
        propinsiID              : $("#t-propinsiID").val()
        , propinsiNama          : $("#t-propinsiNama").val()
    },function(e){
         $("#notif").html(e.alert);
         $("#gPropinsi").trigger('reloadGrid');
    },'json');
});

/* tombol perubahan data */
$("#update").click(function(){
    $.post("Trefpropinsi/update",{
        propinsiID              : $("#t-propinsiID").val()
        , propinsiNama          : $("#t-propinsiNama").val()
    },function(e){
         $("#notif").html(e.alert);
         $("#gPropinsi").trigger('reloadGrid');
    },'json');
});

/* tombol baru */
jQuery("#new").click( function() {loadUrl('Trefpropinsi');});

/* tombol edit */
jQuery("#edit").click( function() {
    var s = $("#gPropinsi").jqGrid('getGridParam','selarrrow');
    
    if (s.length > 1 || s.length < 1){
        alert('Select one for editing');
    }else{
        var id = $("#gPropinsi").getRowData(s)['propinsiID'];
        $.post("Trefpropinsi/getDataPropinsi", {
            propinsiID : id
        }, function(e){
            $("#t-propinsiID").val(id);
            $("#t-propinsiNama").val(e.propinsiNama);
            $("#update").show();
            $("#save").hide();
        }, 'json')
    }
});
        
/* tombol hapus */
jQuery("#delete").click( function() {
    var s = $("#gPropinsi").jqGrid('getGridParam','selarrrow');
    if (s.length < 1){
        alert('Select one for Delete');
    }else{
        var i =0;
        var splitter = s.toString().split(',');
        alert(splitter[0]);
        for (i=0;i<$("#gPropinsi").jqGrid('getGridParam','selarrrow').length;i++){
            var id = $("#gPropinsi").getRowData(splitter[i])['propinsiID'];
            $.post('Trefpropinsi/delete', {
                propinsiID : id
                ,propinsiNama : $("#gPropinsi").getRowData(splitter[i])['propinsiNama']
            }, function(e){
                $("#notif").html(e.alert);
                $("#gPropinsi").trigger('reloadGrid');
            },'json');
        }
    }
});

