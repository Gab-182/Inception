<?php

define( 'DB_NAME', WORDPRESS_DB_NAME);
define( 'DB_USER', WORDPRESS_DB_USER );
define( 'DB_PASSWORD', WORDPRESS_DB_PASSWORD);
define( 'DB_HOST', WORDPRESS_DB_HOST);
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

define('AUTH_KEY',         'wa+W9.(@,m&m$5_)7ja|Gb~,|$4daj~&kh1]$C,7PDfB N3^H>@L~+N?X?@-]68h');
define('SECURE_AUTH_KEY',  'Cug]^.H%6RKDk-)>>$Sf]^s}fv!UYa@]%Gh|uX7eDzH<+;hUf BQ6Y[tiC*+- mp');
define('LOGGED_IN_KEY',    'MmkI+?;0AF5.?UI7$vCMJ-Y(tgL^*>qZwN-,z0zIBb|5@XGNcXNAE>_Z^kI~tT2E');
define('NONCE_KEY',        'QzLkzPU8cl4j1Q_I~Vd9uCW$ppkV@8o#^1b|vL^U(GgoYDbDMm^3=}3)R/=~+HR.');
define('AUTH_SALT',        '4SlwH|[zDjXJwH_IZO|[4I ;J89,1:WJz5QpT/xGjU@,/o3|oSUgBOFtH]Njx9)7');
define('SECURE_AUTH_SALT', '8HBfp>CbdMA,e/h1&,9fNzBR6OdF+lWQR-9GLO#rXE{<fnBEDe&/>UEN+Ln4D2J4');
define('LOGGED_IN_SALT',   ',?WbZbFyJ;7B3+XM,3-9)&Op%7-I1.]+>97TbO2YP-9|t8>@+uA-l42|8MK^hwN?');
define('NONCE_SALT',       'Vs<y?~m4=}F}Vam`N.P6Mo!FZt9O%d&UL7Sz02iIM_l^:!;P`Fr;w?jx|;KK%Y9S');

$table_prefix = 'wp_';

define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';