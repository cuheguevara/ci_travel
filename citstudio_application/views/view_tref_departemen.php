

<div id="notif"></div>
<article class="module width_full">
    <header><h3><?php echo $namaform; ?></h3></header>
    <div class="module_content">
            <a class="ui-state-default ui-corner-all" id="new" href="javascript:void(0)"><span class="ui-icon ui-icon-gear"></span>Baru/Batal</a>
            <a class="ui-state-default ui-corner-all" id="save" href="javascript:void(0)"><span class="ui-icon ui-icon-disk"></span>Simpan</a>
            <a class="ui-state-default ui-corner-all" style="display: none;" id="update" href="javascript:void(0)"><span class="ui-icon ui-icon-disk"></span>Update</a>
            <a class="ui-state-default ui-corner-all" id="delete" href="javascript:void(0)"><span class="ui-icon ui-icon-trash"></span>Hapus</a>
            <a class="ui-state-default ui-corner-all" id="edit" href="javascript:void(0)"><span class="ui-icon ui-icon-pencil"></span>Edit</a>
        <fieldset>
                <label>ENTRY / EDIT DEPARTEMEN</label>
                <input type="hidden" name="t-departemenID" id="t-departemenID" value="<?php echo $departemenID;?>"/>
                <input type="text" name="t-departemenNama" id="t-departemenNama" value="<?php echo $departemenNama;?>"/>
        </fieldset>
        <div class="clear"></div>
    </div>
</article><!-- end of stats article -->
<article class="module width_full">
    <header><h3>DATA DEPARTEMEN</h3></header>
    <div class="module_content">
        <table align="center" style="text-align: center;" id="gDepartemen"></table>
        <div id="pDepartemen"></div>
        <div class="clear"></div>
        
        <div class="clear"></div>
    </div>
</article><!-- end of stats article -->
<script type="text/javascript" src="<?php echo base_url().C_JS;?>application/grid-departemen.js"></script>