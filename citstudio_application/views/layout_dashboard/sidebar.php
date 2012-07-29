<script type="text/javascript">
    function loadUrl(url){
       $("#main").load(url);
    }
    $(function(){
       $("#accordion").accordion({
           autoHeight: false,
            navigation: true
       });
    });
</script>
<form class="quick_search">
        <input type="text" value="Quick Search" onfocus="if(!this._haschanged){this.value=''};this._haschanged=true;">
</form>
<hr/>
<?php
    /* mendapatkan informasi user yangsedang login, kemudian mengeluarkan menu berdasarkan hak-akses nya */
    $usernip = $this->session->userdata('uname');
    /* memanggil stored procedure sp_GetModuleAuthenticationByUsername(<param>), yang berguna untuk menyeleksi hak akses*/
    $sql       = "call sp_GetModuleAuthenticationByUsername(?)";
    /* mengeksekusi stored procedure */
    $result    = $this->db->query($sql, array(mysql_escape_string($usernip)),TRUE)->result();
    /* inisialisasi dan instansiasi class citdbase untuk mengkases table dengan queri code-igniter */
    
    $conn = new Citdbase();
    /* keluarkan data hasil eksekusi kueri */
    foreach($result as $row):
?>
    <h3><?php echo strtoupper($row->modulNama);?></h3>
    <!-- membentuk link dan menu untuk masing-masing modul //-->
    <ul class="toggle">
    <?php
        /* mendapatkan nama menu serta link tujuan */
        $submenu    = $conn->CIT_SELECT('conf_submodul','equal', array('modulID'=>$row->modulID,'is_aktif'=>'Y'));

        foreach ($submenu as $value) :
    ?>
        <li class="icn_settings"><a onclick="loadUrl('<?php echo $value["submodulPage_Form_Controller"];?>')" href="javascript:void(0);"><?php echo $value["submodulNama"];?></a></li>
    <?php
        endforeach;
    ?>
    </ul>
<?php        
    endforeach;
?>        
    

<footer>
        <hr />
        <p><strong>Copyright &copy; 2012 C-ITSTUDIO</strong></p>
</footer>