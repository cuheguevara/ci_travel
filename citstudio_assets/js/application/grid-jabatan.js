
$(function(){
    var lastsel;
	
    jQuery("#gJabatan").jqGrid({
        url:'Trefjabatan/gridJabatan',
        datatype: "json",
        colNames:['ID', 'NAMA'],
        colModel:[
            {name   :'jabatanID',index:'jabatanID',width : 50},
            {name   :'jabatanNama',index:'jabatanNama',editable:true,width:150}
        ],
	rownumbers  : true,
        rowNum      : 10,
        autowidth   : true,
        height      : '100%',
        multiselect : true,
        rowList     : [10,20,30],
        pager       : jQuery('#pJabatan'),
        sortname    : 'jabatanID',
        viewrecords : true,
        sortorder   : "ASC",
        loadComplete:function(){
            $("#gJabatan").hideCol('jabatanID');
        },onSelectRow:function(id){
            var id = $("#gJabatan").getRowData(id)['jabatanID'];
            var name = $("#gJabatan").getRowData(id)['jabatanNama'];
            $("#delete").show('fast');
            //jQuery(this).editRow(id, true);
        }
    }).navGrid('#pJabatan',{edit:true,add:true,del:false});
});

/* tombol penyimpanan */
$("#save").click(function(){
    $.post("Trefjabatan/entry",{
        jabatanID              : $("#t-jabatanID").val()
        , jabatanNama          : $("#t-jabatanNama").val()
    },function(e){
         $("#notif").html(e.alert);
         $("#gJabatan").trigger('reloadGrid');
    },'json');
});

/* tombol perubahan data */
$("#update").click(function(){
    $.post("Trefjabatan/update",{
        jabatanID              : $("#t-jabatanID").val()
        , jabatanNama          : $("#t-jabatanNama").val()
    },function(e){
         $("#notif").html(e.alert);
         $("#gJabatan").trigger('reloadGrid');
    },'json');
});

/* tombol baru */
jQuery("#new").click( function() {loadUrl('Trefjabatan');});

/* tombol edit */
jQuery("#edit").click( function() {
    var s = $("#gJabatan").jqGrid('getGridParam','selarrrow');
    
    if (s.length > 1 || s.length < 1){
        alert('Select one for editing');
    }else{
        var id = $("#gJabatan").getRowData(s)['jabatanID'];
        $.post("Trefjabatan/getDataJabatan", {
            jabatanID : id
        }, function(e){
            $("#t-jabatanID").val(id);
            $("#t-jabatanNama").val(e.jabatanNama);
            $("#update").show();
            $("#save").hide();
        }, 'json')
    }
});
        
/* tombol hapus */
jQuery("#delete").click( function() {
    var s = $("#gJabatan").jqGrid('getGridParam','selarrrow');
    if (s.length < 1){
        alert('Select one for Delete');
    }else{
        var i =0;
        var splitter = s.toString().split(',');
        alert(splitter[0]);
        for (i=0;i<$("#gJabatan").jqGrid('getGridParam','selarrrow').length;i++){
            var id = $("#gJabatan").getRowData(splitter[i])['jabatanID'];
            $.post('Trefjabatan/delete', {
                jabatanID : id
                ,jabatanNama : $("#gJabatan").getRowData(splitter[i])['jabatanNama']
            }, function(e){
                $("#notif").html(e.alert);
                $("#gJabatan").trigger('reloadGrid');
            },'json');
        }
    }
});

