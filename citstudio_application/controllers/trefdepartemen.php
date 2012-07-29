<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Trefdepartemen extends CI_Controller {

    private $nomor_departemen_baru;
    private $table;
    private $primaryKey;
    private $username;
    private $conn;
    
    function __construct(){
        
        parent::__construct();
        
        /* mendeklarasikan, meng-inisialisasi variable usernip sebagai penampun session nip */
        $this->usernip = $this->session->userdata('nip');
        
        /* membangun koneksi dengan melakukan panggilan class citdbase */
        $this->conn = new Citdbase();
        
        /* pengecekan, apakah sudah ada yang login atau belum */
        if (($this->usernip == '') || (!isset ($this->usernip))) 
        {
            /* jika belum login, halaman akan terlempar ke halaman login */
            redirect('home', 'refresh');
            
            /* jika tidak berhasil tukarkan dengan perintah ini */
            //  $this->load->view('login_form');
        }
        else{
            /* inisialisasi sql statement untuk memanggil stored procedure */
            $sql       = "call sp_GetUserByNIP(?)";
            
            /* ekseskusi stored procedure */
            $result    = $this->db->query($sql, array(mysql_escape_string($this->usernip)),TRUE)->result();
            
            /* retrieve nilai/hasil dari hasil eksekusi stored procedure */
            foreach ($result as $row) {
                $this->username = $row->username;
            }
        }
        
        /* inisialisasi nama table dan primarykey dari table */
        $this->table = "tref_departemen";
        $this->primaryKey = "departemenID";
        
        /* inisialisasi nomor departemen baru */
        $this->nomor_departemen_baru=  $this->conn->CIT_AUTONUMBER($this->table, $this->primaryKey, 'D', '3');
    }

    public function index(){
        /* inisialisasi variable yang dibutuhkan pada template dan form utama admin */
        $view = array(
            'mainview'=>'view_tref_departemen'
            ,'namaform'=>'FORM DEPARTEMEN'
            ,'information_message'=>'REFERENSI DEPARTEMEN'
            ,'title'=>'DASHBOARD '.APP_NAME);
        
        /* inisialisasi nilai textbox */
        $textbox = array('departemenID'=>  $this->nomor_departemen_baru
                , 'departemenNama'=>'');
        
        /* merge array */
        $data = array_merge($view,$textbox);
        
        /* render */
        $this->load->view('view_tref_departemen',$data);
    }
  
    /* mendapatkan data record dari berdasarkan record yang dipilih pada grid */
    public function getDataDepartemen(){
        /* mendapatkan variabel post departemenID */
        $departemenID   = $_POST["departemenID"]; 
        
        /* mendapatkan nilai yang dibutuhkan berdasarkan variabel yang dikirim */
        $departemenNama = $this->conn->CIT_GETSOMETHING('departemenNama', $this->table, array($this->primaryKey=>$departemenID));
        
        /* simpan nilai yang dibutuhkan berdasarkan variabel yang dikirim kedalam variabel array untuk diencode kedalam bentuk jSon */
        $return = array('departemenNama'=>$departemenNama);
        
        echo json_encode($return);
        
    }

    /* menghapus record */
    public function delete(){
        
        /* mendapatkan variabel post dari text-box id departemen pada view */
        $departemenID   = $_POST["departemenID"]; 
        $departemenNama   = $_POST["departemenNama"]; 
        
        /* deklarasi nilai balik proses penyimpanan */
        $return = array();
        
        /* inisialisasi sql statement untuk memanggil stored procedure */
        $sql       = "call sp_departemen_delete(?,?,?,?)";

        /* ekseskusi stored procedure, dengan memberikan parameter yang dibutuhkan oleh stored procedure */
        $result    = $this->db->query($sql
                , array(
                    mysql_escape_string($departemenID)
                    , mysql_escape_string($departemenNama)
                    , $_SERVER["REMOTE_ADDR"]
                    , $this->username
                    ),TRUE)->result();

        /* inisialisasi hasil kembalian pemanggilan stored procedure */
        $hasil = 0;
        foreach ($result as $row) {
            $hasil = $row->HASIL;
        }

        if($hasil == 'OK'){
            /* jika OK, maka tampilkan pesan berhasil */
            $return = array('alert'=>'<h4 class="alert_success">DATA BERHASIL DIHAPUS</h4>');
        }else{
            /* jika NOK, maka tampilkan pesan gagal */
            $return = array('alert'=>'<h4 class="alert_error">DATA GAGAL DIHAPUS</h4>');
        }
            
        /* render pesan sebagai nilai balik */
        echo json_encode($return);
    }
    
    /* merubah data */
    public function update(){
        /* mendapatkan variabel post dari text-box nama departemen pada view */
        $departemenNama = $_POST["departemenNama"];
        
        /* mendapatkan variabel post dari text-box id departemen pada view */
        $departemenID   = $_POST["departemenID"]; 
        
        /* deklarasi nilai balik proses penyimpanan */
        $return = array();
        
        /* jika nama departemen tidak kosong, maka eksekusi stored procedure penyimpanan departemen */
        if((isset($departemenNama)) && (trim($departemenNama)!="")){
            
            /* inisialisasi sql statement untuk memanggil stored procedure */
            $sql       = "call sp_departemen_update(?,?,?,?)";
            
            /* ekseskusi stored procedure, dengan memberikan parameter yang dibutuhkan oleh stored procedure */
            $result    = $this->db->query($sql
                    , array(
                        mysql_escape_string($departemenID)
                        , mysql_escape_string($departemenNama)
                        , $_SERVER["REMOTE_ADDR"]
                        , $this->username
                        ),TRUE)->result();
            
            /* inisialisasi hasil kembalian pemanggilan stored procedure */
            $hasil = 0;
            foreach ($result as $row) {
                $hasil = $row->HASIL;
            }
            
            if($hasil == 'OK'){
                /* jika OK, maka tampilkan pesan berhasil */
                $return = array('alert'=>'<h4 class="alert_success">DATA BERHASIL DISIMPAN</h4>');
            }else{
                /* jika NOK, maka tampilkan pesan gagal */
                $return = array('alert'=>'<h4 class="alert_error">DATA GAGAL DISIMPAN</h4>');
            }
        }else{
            /* jika nama departemen kosong, maka tampilkan pesan error */
            $return = array('alert'=>'<h4 class="alert_error">A Success Message</h4>');
        }
                
        /* render pesan sebagai nilai balik */
        echo json_encode($return);
    }
    
    /* memasukan data baru */
    public function entry(){
        /* mendapatkan variabel post dari text-box nama departemen pada view */
        $departemenNama = $_POST["departemenNama"];
        
        /* mendapatkan variabel post dari text-box id departemen pada view */
        /* $departemenID   = $_POST["departemenID"]; */
        
        /* karena proses insert, dan menghindari duplikasi entry pada kolom departemenID, generate ulang untuk ID Departemen */
        $departemenID   = $this->conn->CIT_AUTONUMBER($this->table, $this->primaryKey, 'M', '2');
        
        /* deklarasi nilai balik proses penyimpanan */
        $return = array();
        
        /* jika nama departemen tidak kosong, maka eksekusi stored procedure penyimpanan departemen */
        if((isset($departemenNama)) && (trim($departemenNama)!="")){
            
            /* inisialisasi sql statement untuk memanggil stored procedure */
            $sql       = "call sp_departemen_insert(?,?,?,?)";
            
            /* ekseskusi stored procedure, dengan memberikan parameter yang dibutuhkan oleh stored procedure */
            $result    = $this->db->query($sql
                    , array(
                        mysql_escape_string($departemenID)
                        , mysql_escape_string($departemenNama)
                        , $_SERVER["REMOTE_ADDR"]
                        , $this->username
                        ),TRUE)->result();
            
            /* inisialisasi hasil kembalian pemanggilan stored procedure */
            $hasil = 0;
            foreach ($result as $row) {
                $hasil = $row->HASIL;
            }
            
            if($hasil == 'OK'){
                /* jika OK, maka tampilkan pesan berhasil */
                $return = array('alert'=>'<h4 class="alert_success">DATA BERHASIL DISIMPAN</h4>');
            }else{
                /* jika NOK, maka tampilkan pesan gagal */
                $return = array('alert'=>'<h4 class="alert_error">DATA GAGAL DISIMPAN</h4>');
            }
        }else{
            /* jika nama departemen kosong, maka tampilkan pesan error */
            $return = array('alert'=>'<h4 class="alert_error">A Success Message</h4>');
        }
                
        /* render pesan sebagai nilai balik */
        echo json_encode($return);
    }
    
    /* menampilkan data */
    public function gridDepartemen(){
        /* inisialisasi variable index untuk melakukan sorting pada grid */
        $sidx = $_REQUEST['sidx'];
        
        /* inisialisasi metode sorting pada grid */
        $sord = $_REQUEST['sord'];
        
        /* inisialisasi halaman yang sedang diakses pada grid */
        $page = $_REQUEST['page'];
        
        /* inisialisasi jumlah row yang diakses setiap kali tampil grid */
        $limit = $_REQUEST['rows'];

        /* inisialisasi koneksi */
        // $cn     = new Citdbase(); jika tidak menggunakan variable global
        $data   = $this->conn->CIT_JQGRID('tref_departemen');
        
        /* mendapatkan jumlah data */
        $count  =  count($data);

        /* jika data > 0 , total halaman adalah hasil pembulatan dari jumlah data dibagi batas data yang tampil */
        /* jika data = 0 , total halaman adalah 0 */
        if( $count > 0 ) {
            $total_pages = ceil($count/$limit);
        } else {
            $total_pages = 0;
        }

        /* jika halaman > jumlah halaman , halaman = jumlah halaman*/
        if ($page > $total_pages) $page=$total_pages;

        /* mendapatkan nilai awal untuk query */
        $start = $limit*$page - $limit;

        /* jika nilai awal < 0 , maka nilai awal di set menjadi 0*/
        if ($start<0) $start=0;

        /* membentuk queri dengan limit dan start*/
        $row = $this->conn->CIT_JQGRID('tref_departemen',$sidx, $sord, $start, $limit);

        $responce->page = $page;
        $responce->total = $total_pages;
        $responce->records = $count;

        $i=0;
        $rowId = 1;

        /* extract data hasil eksekusi dan tempelkan pada array untuk dimasukan kedalam grid*/
        foreach ($row as $val => $r) {
            $responce->rows[$i]['departemenID']=$r['departemenID'];
            $responce->rows[$i]['cell']=array(
                $r['departemenID'],
                $r['departemenNama']
            );
        $i++;
        }
        /* encode array kedalam bentuk json */
        echo json_encode($responce);
    }
    
}