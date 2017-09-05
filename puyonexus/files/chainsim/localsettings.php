<?php
$settings = [
    'settings' => [
        // Database settings
        'database' => [
            'dsn' => 'mysql:host={{ salt["pillar.get"]("mysql:hostname") }};dbname={{ salt["pillar.get"]("mysql:database") }};charset=utf8',
            'username' => '{{ salt["pillar.get"]("mysql:username") }}',
            'password' => '{{ salt["pillar.get"]("mysql:password").strip() }}',
            'tablePrefix' => 'puyosim_',
        ],
    ]
];

return $settings;