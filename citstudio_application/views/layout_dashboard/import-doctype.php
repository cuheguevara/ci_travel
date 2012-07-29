<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
	<title>{title}</title>
	<link rel="stylesheet" href="<?php echo base_url().ASSETS; ?>administrator/css/layout.css" type="text/css" media="screen" />
	
	<!--[if lt IE 9]>
	<link rel="stylesheet" href="css/ie.css" type="text/css" media="screen" />
	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->

    <style type="text/css">@import url("<?php echo base_url().C_CSS; ?>themes/smoothness/jquery.ui.all.css");</style>
    <style type="text/css">@import url("<?php echo base_url().C_CSS; ?>themes/smoothness/jquery-ui-1.8.17.custom.css");</style>
	
    
    <script type="text/javascript" src="<?php echo base_url().C_JS; ?>jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="<?php echo base_url().C_JS; ?>jquery/ui/jquery-ui-1.8.17.custom.js"></script>
    <script type="text/javascript" src="<?php echo base_url().C_JS; ?>jquery/ui/external/jquery.bgiframe-2.1.2.js"></script>
    
    <script type="text/javascript" src="<?php echo base_url().C_JS; ?>jquery/ui/jquery.effects.core.js"></script>

    <script type="text/javascript" src="<?php echo base_url().C_JS; ?>jquery/ui/jquery.ui.core.js"></script>
    <script type="text/javascript" src="<?php echo base_url().C_JS; ?>jquery/ui/jquery.ui.dialog.js"></script>
    <script type="text/javascript" src="<?php echo base_url().C_JS; ?>jquery/ui/jquery.ui.position.js"></script>
    <script type="text/javascript" src="<?php echo base_url().C_JS; ?>jquery/ui/jquery.ui.widget.js"></script>
    <script type="text/javascript" src="<?php echo base_url().C_JS; ?>jquery/ui/jquery.ui.button.js"></script>
    <script type="text/javascript" src="<?php echo base_url().C_JS; ?>jquery/ui/jquery.ui.datepicker.js"></script>
    <script type="text/javascript" src="<?php echo base_url().C_JS; ?>jquery/ui/jquery.ui.tabs.js"></script>
    <script type="text/javascript" src="<?php echo base_url().C_JS; ?>jquery/ui/jquery.ui.autocomplete.js"></script>
    <link rel="stylesheet" href="<?php echo base_url().C_CSS; ?>all.setting.css" type="text/css" media="screen" />
    


    <!-- CSS + JS PLUGIN - GRID //-->
    <link rel="stylesheet" type="text/css" media="screen" href="<?php echo base_url().C_JS; ?>jquery/grid/css/ui.jqgrid.css"/>
    <script type="text/javascript" src="<?php echo base_url().C_JS; ?>jquery/grid/js/i18n/grid.locale-en.js"></script>
    <script type="text/javascript" src="<?php echo base_url().C_JS; ?>jquery/grid/js/jquery.jqGrid.min.js"></script>
    <script type="text/javascript" src="<?php echo base_url().C_JS; ?>jquery/grid/js/jquery.jqGrid.min.js"></script>

    <title>{title}</title>
    <style type="text/css">
        .ui-datepicker {z-index:1200;}
    </style>
        
        <script src="<?php echo base_url().ASSETS; ?>administrator/js/hideshow.js" type="text/javascript"></script>
	<script src="<?php echo base_url().ASSETS; ?>administrator/js/jquery.tablesorter.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="<?php echo base_url().ASSETS; ?>administrator/js/jquery.equalHeight.js"></script>
	<script type="text/javascript">
	$(document).ready(function() 
    	{ 
      	  $(".tablesorter").tablesorter(); 
   	 } 
	);
	$(document).ready(function() {

	//When page loads...
	$(".tab_content").hide(); //Hide all content
	$("ul.tabs li:first").addClass("active").show(); //Activate first tab
	$(".tab_content:first").show(); //Show first tab content

	//On Click Event
	$("ul.tabs li").click(function() {

		$("ul.tabs li").removeClass("active"); //Remove any "active" class
		$(this).addClass("active"); //Add "active" class to selected tab
		$(".tab_content").hide(); //Hide all tab content

		var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
		$(activeTab).fadeIn(); //Fade in the active ID content
		return false;
	});

});
    </script>
    <script type="text/javascript">
    $(function(){
        $('.column').equalHeight();
    });
</script>

</head>
