fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

ui_page 'http://localhost:3000/'

files {
  'dist/**/*',
}


client_script 'client.lua'

server_script 'server.lua'

--dependency 'rp-radio'