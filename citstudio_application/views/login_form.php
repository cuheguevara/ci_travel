<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="<?php echo base_url().'images/fav_icon.png';?>" />
<style type="text/css">@import url("<?php echo base_url() . C_CSS.'reset.css'; ?>");</style>
<style type="text/css">@import url("<?php echo base_url() . C_CSS.'login.css'; ?>");</style>
<title>Login</title>
<script src="<?php echo base_url().C_JS.'jquery-1.7.2.min.js';?>"></script>
<script>
//	var auto_refresh = setInterval(
//	function()
//	{
//		$('#load_tweets').load('reminder/reminder_kontrak');
//	}, 2000);
</script>
</head>

<body bgcolor="#f3f3f3">
<div id="main_box">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="70%">
        	<div align="center">
        	<img src="<?php echo base_url().C_IMAGES.'logo2.png';?>" />
            </div>
        </td>
        <td width="30%">
        	<div align="center">
            <img src="<?php echo base_url().C_IMAGES.'logo_cit.png';?>" /> 
            </div>
        </td>
      </tr>
      <tr>
        <td width="70%">
        <div id="reminder_box">
		    <center><br />
           	<div id="load_tweets">
                    
                    
                </div>
           	</center>
        </div>
        </td>
        <td width="30%">
        <div id="login_box">
        <h1>Login</h1>
		<?php
            $attributes = array('name' => 'login_form', 'id' => 'login_form');
            echo form_open('login/proses_login', $attributes);
        ?>
		
		<?php 
			$message = $this->session->flashdata('message');
			echo $message == '' ? '' : '<p id="message">' . $message . '</p>';
		?>
		
		<p>
			<label for="username">Username:</label>
			<input type="text" name="username" size="20" class="form_field" 
            value="<?php echo set_value('username');?>"/>			
		</p>
		<?php echo form_error('username', '<p class="field_error">', '</p>');?>
		
		<p>
			<label for="password">Password:</label>
			<input type="password" name="password" size="20" class="form_field" 
            value="<?php echo set_value('password');?>"/>			
		</p>
		<?php echo form_error('password', '<p class="field_error">', '</p>');?>
		
		<p>
			<br><input type="submit" name="submit" id="submit" value="Login" />
		</p>
		</form>

        </div>
        </td>
      </tr>
    </table>
</div>
<div id="footer" align="center">
Copyright &copy; 2012 CITSTUDIO<br />
<a href="http://www.citstudio.com">www.citstudio.com</a>
</div>
</body>
</html>
