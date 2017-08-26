<?php
$dbms = 'mysqli';
$dbhost = '{{ salt["pillar.get"]("mysql:hostname") }}';
$dbport = 3306;
$dbname = '{{ salt["pillar.get"]("mysql:database") }}';
$dbuser = '{{ salt["pillar.get"]("mysql:username") }}';
$dbpasswd = '{{ salt["pillar.get"]("mysql:password").strip() }}';
$table_prefix = 'phpbb_';
$acm_type = 'file';
$load_extensions = '';
@define('PHPBB_INSTALLED', true);
