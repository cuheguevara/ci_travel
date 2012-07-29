
$(function(){
    var lastsel;
	
    jQuery("#gKategori").jqGrid({
        url:'Trefkategori/gridKategori',
        datatype: "json",
        colNames:['ID', 'NAMA'],
        colModel:[
            {name   :'kategoriID',index:'kategoriID',width : 50},
            {name   :'kategoriNama',index:'kategoriNama',editable:true,width:150}
        ],
	rownumbers  : true,
        rowNum      : 10,
        autowidth   : true,
        height      : '100%',
        multiselect : true,
        rowList     : [10,20,30],
        pager       : jQuery('#pKategori'),
        sortname    : 'kategoriID',
        viewrecords : true,
        sortorder   : "ASC",
        loadComplete:function(){
            $("#gKategori").hideCol('kategoriID');
        },onSelectRow:function(id){
            var id = $("#gKategori").getRowData(id)['kategoriID'];
            var name = $("#gKategori").getRowData(id)['kategoriNama'];
            $("#delete").show('fast');
            //jQuery(this).editRow(id, true);
        }
    }).navGrid('#pKategori',{edit:true,add:true,del:false});
});

/* tombol penyimpanan */
$("#save").click(function(){
    $.post("Trefkategori/entry",{
        kategoriID              : $("#t-kategoriID").val()
        , kategoriNama          : $("#t-kategoriNama").val()
    },function(e){
         $("#notif").html(e.alert);
         $("#gKategori").trigger('reloadGrid');
    },'json');
});

/* tombol perubahan data */
$("#update").click(function(){
    $.post("Trefkategori/update",{
        kategoriID              : $("#t-kategoriID").val()
        , kategoriNama          : $("#t-kategoriNama").val()
    },function(e){
         $("#notif").html(e.alert);
         $("#gKategori").trigger('reloadGrid');
    },'json');
});

/* tombol baru */
jQuery("#new").click( function() {loadUrl('Trefkategori');});

/* tombol edit */
jQuery("#edit").click( function() {
    var s = $("#gKategori").jqGrid('getGridParam','selarrrow');
    
    if (s.length > 1 || s.length < 1){
        alert('Select one for editing');
    }else{
        var id = $("#gKategori").getRowData(s)['kategoriID'];
        $.post("Trefkategori/getDataKategori", {
            kategoriID : id
        }, function(e){
            $("#t-kategoriID").val(id);
            $("#t-kategoriNama").val(e.kategoriNama);
            $("#update").show();
            $("#save").hide();
        }, 'json')
    }
});
        
/* tombol hapus */
jQuery("#delete").click( function() {
    var s = $("#gKategori").jqGrid('getGridParam','selarrrow');
    if (s.length < 1){
        alert('Select one for Delete');
    }else{
        var i =0;
        var splitter = s.toString().split(',');
        alert(splitter[0]);
        for (i=0;i<$("#gKategori").jqGrid('getGridParam','selarrrow').length;i++){
            var id = $("#gKategori").getRowData(splitter[i])['kategoriID'];
            $.post('Trefkategori/delete', {
                kategoriID : id
                ,kategoriNama : $("#gKategori").getRowData(splitter[i])['kategoriNama']
            }, function(e){
                $("#notif").html(e.alert);
                $("#gKategori").trigger('reloadGrid');
            },'json');
        }
    }
});

