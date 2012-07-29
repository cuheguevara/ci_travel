<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Trefkota extends CI_Controller {

    private $nomor_kota_baru;
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
        $this->table = "tref_kota";
        $this->primaryKey = "kotaID";
        
        /* inisialisasi nomor kota baru */
        $this->nomor_kota_baru=  $this->conn->CIT_AUTONUMBER($this->table, $this->primaryKey, 'K', '3');
    }

    public function index(){
        /* inisialisasi variable yang dibutuhkan pada template dan form utama admin */
        $view = array(
            'mainview'=>'view_tref_kota'
            ,'namaform'=>'FORM KOTA'
            ,'information_message'=>'REFERENSI KOTA'
            ,'title'=>'DASHBOARD '.APP_NAME);
        
        /* inisialisasi nilai textbox */
        $textbox = array('kotaID'=>  $this->nomor_kota_baru
                , 'kotaNama'=>''
                , 'propinsiID'=>''
                , 'propinsiNama'=>''
            );
        
        /* merge array */
        $data = array_merge($view,$textbox);
        
        /* render */
        $this->load->view('view_tref_kota',$data);
    }
  
    /* mendapatkan data record dari berdasarkan record yang dipilih pada grid */
    public function getDataKota(){
        /* mendapatkan variabel post kotaID */
        $kotaID   = $_POST["kotaID"]; 
        
        /* mendapatkan nilai yang dibutuhkan berdasarkan variabel yang dikirim */
        $kotaNama = $this->conn->CIT_GETSOMETHING('kotaNama', $this->table, array($this->primaryKey=>$kotaID));
        
        /* simpan nilai yang dibutuhkan berdasarkan variabel yang dikirim kedalam variabel array untuk diencode kedalam bentuk jSon */
        $return = array('kotaNama'=>$kotaNama);
        
        echo json_encode($return);
        
    }

    /* menghapus record */
    public function delete(){
        
        /* mendapatkan variabel post dari text-box id kota pada view */
        $kotaID   = $_POST["kotaID"]; 
        $kotaNama   = $_POST["kotaNama"]; 
        
        /* deklarasi nilai balik proses penyimpanan */
        $return = array();
        
        /* inisialisasi sql statement untuk memanggil stored procedure */
        $sql       = "call sp_kota_delete(?,?,?,?)";

        /* ekseskusi stored procedure, dengan memberikan parameter yang dibutuhkan oleh stored procedure */
        $result    = $this->db->query($sql
                , array(
                    mysql_escape_string($kotaID)
                    , mysql_escape_string($kotaNama)
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
        /* mendapatkan variabel post dari text-box nama kota pada view */
        $kotaNama = $_POST["kotaNama"];
        
        /* mendapatkan variabel post dari text-box id kota pada view */
        $kotaID   = $_POST["kotaID"]; 
        
        /* deklarasi nilai balik proses penyimpanan */
        $return = array();
        
        /* jika nama kota tidak kosong, maka eksekusi stored procedure penyimpanan kota */
        if((isset($kotaNama)) && (trim($kotaNama)!="")){
            
            /* inisialisasi sql statement untuk memanggil stored procedure */
            $sql       = "call sp_kota_update(?,?,?,?)";
            
            /* ekseskusi stored procedure, dengan memberikan parameter yang dibutuhkan oleh stored procedure */
            $result    = $this->db->query($sql
                    , array(
                        mysql_escape_string($kotaID)
                        , mysql_escape_string($kotaNama)
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
            /* jika nama kota kosong, maka tampilkan pesan error */
            $return = array('alert'=>'<h4 class="alert_error">A Success Message</h4>');
        }
                
        /* render pesan sebagai nilai balik */
        echo json_encode($return);
    }
    
    /* memasukan data baru */
    public function entry(){
        /* mendapatkan variabel post dari text-box nama kota pada view */
        $kotaNama = $_POST["kotaNama"];
        
        /* mendapatkan variabel post dari text-box id kota pada view */
        /* $kotaID   = $_POST["kotaID"]; */
        
        /* karena proses insert, dan menghindari duplikasi entry pada kolom kotaID, generate ulang untuk ID Kota */
        $kotaID   = $this->conn->CIT_AUTONUMBER($this->table, $this->primaryKey, 'M', '2');
        
        /* deklarasi nilai balik proses penyimpanan */
        $return = array();
        
        /* jika nama kota tidak kosong, maka eksekusi stored procedure penyimpanan kota */
        if((isset($kotaNama)) && (trim($kotaNama)!="")){
            
            /* inisialisasi sql statement untuk memanggil stored procedure */
            $sql       = "call sp_kota_insert(?,?,?,?)";
            
            /* ekseskusi stored procedure, dengan memberikan parameter yang dibutuhkan oleh stored procedure */
            $result    = $this->db->query($sql
                    , array(
                        mysql_escape_string($kotaID)
                        , mysql_escape_string($kotaNama)
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
            /* jika nama kota kosong, maka tampilkan pesan error */
            $return = array('alert'=>'<h4 class="alert_error">A Success Message</h4>');
        }
                
        /* render pesan sebagai nilai balik */
        echo json_encode($return);
    }
    
    /* menampilkan data */
    public function gridKota(){
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
        $data   = $this->conn->CIT_JQGRID('tref_kota');
        
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
        $row = $this->conn->CIT_JQGRID('tref_kota',$sidx, $sord, $start, $limit);

        $responce->page = $page;
        $responce->total = $total_pages;
        $responce->records = $count;

        $i=0;
        $rowId = 1;

        /* extract data hasil eksekusi dan tempelkan pada array untuk dimasukan kedalam grid*/
        foreach ($row as $val => $r) {
            $responce->rows[$i]['kotaID']=$r['kotaID'];
            $responce->rows[$i]['cell']=array(
                $r['kotaID'],
                $r['kotaNama']
            );
        $i++;
        }
        /* encode array kedalam bentuk json */
        echo json_encode($responce);
    }
    
}