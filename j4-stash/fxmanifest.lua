-- Janiel Vault Resource
fx_version 'cerulean'
game 'gta5'

author 'JANIEL'
description 'Janiel Stash Script'
version '1.0.0'

-- Bağımlılıklar
dependencies {
    'qb-core', -- QBCore bağımlılığı
    'qb-target', -- Target sistemini kullanıyorsanız
}

-- Sunucu tarafı dosyaları
server_scripts {
    'server.lua', -- Sunucu dosyası
    '@oxmysql/lib/MySQL.lua'
}

-- İstemci tarafı dosyaları
client_scripts {
    'client.lua', -- İstemci dosyası
}

-- Yükleme sırasında dikkat edilecek dosyalar
lua54 'yes' -- Lua 5.4'ü desteklemek için
