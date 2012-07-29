

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
                <label>NAMA PROPINSI</label>
                <input type="hidden" name="t-propinsiID" id="t-propinsiID" value="<?php echo $propinsiID;?>"/>
                <input type="text" name="t-propinsiNama" id="t-propinsiNama" value="<?php echo $propinsiNama;?>"/>
                <label>NAMA KOTA</label>
                <input type="hidden" name="t-kotaID" id="t-kotaID" value="<?php echo $kotaID;?>"/>
                <input type="text" name="t-kotaNama" id="t-kotaNama" value="<?php echo $kotaNama;?>"/>
        </fieldset>
        <div class="clear"></div>
    </div>
</article><!-- end of stats article -->
<article class="module width_full">
    <header><h3>DATA KOTA</h3></header>
    <div class="module_content">
        <table align="center" style="text-align: center;" id="gKota"></table>
        <div id="pKota"></div>
        <div class="clear"></div>
        
        <div class="clear"></div>
    </div>
</article><!-- end of stats article -->
<script type="text/javascript" src="<?php echo base_url().C_JS;?>application/grid-tmp-kota.js"></script>
<script type="text/javascript" src="<?php echo base_url().C_JS;?>application/grid-kota.js"></script>