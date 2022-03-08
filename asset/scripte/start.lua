
loadfile([[./asset/scripte/config.lua]])()

loadfile([[./asset/scripte/globals.lua]])()

loadfile("./asset/scripte/load_scripte.lua")()

loadfile("./asset/scripte/module/test.lua")()

loadfile("./asset/scripte/module/ingame_event_base.lua")()

-- Player
loadfile([[./asset/scripte/module/player.lua]])()

-- Punicat
loadfile([[.\asset\scripte\module\npc\punicat.lua]])()
loadfile([[.\asset\scripte\module\npc\cat_1.lua]])()
loadfile([[.\asset\scripte\module\npc\cat_2.lua]])()


loadfile([[./asset/scripte/module/test_npc.lua]])()

-- @memo
-- event関連はそれ専用のクラスをC++で作ってLuaで呼ぶのがよさそう
-- 座標などはマップデータで読み込んだものをC++で管理してLuaで呼ぶ

