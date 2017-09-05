<?php
$settings = [
    'settings' => [
        // Site settings
        'site' => [
            'name' => 'Puyo Nexus Chain Simulator',
            'description' => 'Create and share Puyo Puyo chains.',
            'titledChainDescription' => 'Create and share Puyo Puyo chains with the Puyo Nexus Chain Simulator.',
            'twitter' => '@puyonexus',
        ],
        // View settings for PhpRenderer
        'views' => [
            'path' => __DIR__ . '/../views/',
        ],
        // Router cache
        'routerCacheFile' => __DIR__ . '/../temp/cache/routes.php',

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