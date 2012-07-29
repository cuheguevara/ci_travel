<!doctype html>
<html lang="en">
<?php $this->load->view(ADMIN_LAYOUT.'import-doctype'); ?>
    <body>
        <header id="header">
            <?php $this->load->view(ADMIN_LAYOUT.'header'); ?>
        </header> <!-- end of header bar -->

        <section id="secondary_bar">
                <?php $this->load->view(ADMIN_LAYOUT.'info-breadcumbs'); ?>
        </section><!-- end of secondary bar -->

        <aside id="sidebar" class="column">
                <?php $this->load->view(ADMIN_LAYOUT.'sidebar'); ?>

        </aside><!-- end of sidebar -->

        <section id="main" class="column">
            <h4 class="alert_info">{information_message}</h4>
                <?php $this->load->view($mainview); ?>
                <div class="spacer"></div>
        </section>
    </body>
</html>