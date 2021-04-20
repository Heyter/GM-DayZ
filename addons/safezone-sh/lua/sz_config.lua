/**
* General configuration
**/

-- Usergroups allowed to add/modify Safe Zones
SH_SZ.Usergroups = {
	["superadmin"] = true
}

-- Use Steam Workshop for the content instead of FastDL?
SH_SZ.UseWorkshop = true

-- Controls for the Editor camera.
-- See a full list here: http://wiki.garrysmod.com/page/Enums/KEY
SH_SZ.CameraControls = {
	forward = KEY_W,
	left = KEY_A,
	back = KEY_S,
	right = KEY_D,
}

/**
* HUD configuration
**/

-- Where to display the Safe Zone Indicator on the screen.
-- Possible options: topleft, top, topright, left, center, right, bottomleft, bottom, bottomright
SH_SZ.HUDAlign = "top"

-- Offset of the Indicator relative to its base position.
-- Use this if you want to move the indicator by a few pixels.
SH_SZ.HUDOffset = {
	x = 0,
	y = 0,
	scale = false, -- Set to false/true to enable offset scaling depending on screen resolution.
}

/**
* Advanced configuration
* Edit at your own risk!
**/

SH_SZ.WindowSize = {w = 800, h = 300}

SH_SZ.DefaultOptions = {
	name = "Safezone",
	namecolor = "52,152,219",
	hud = true,
	noatk = true,
	nonpc = true,
	noprop = true,
	ptime = 5,
	entermsg = "",
	leavemsg = "",
}

SH_SZ.MaximumSize = 1024

SH_SZ.DataDirName = "sh_safezones"

SH_SZ.ZoneHitboxesDeveloper = false

SH_SZ.TeleportIdealDistance = 512

/**
* Theme configuration
**/

-- Font to use for normal text throughout the interface.
SH_SZ.Font = "Circular Std Medium"

-- Font to use for bold text throughout the interface.
SH_SZ.FontBold = "Circular Std Bold"

-- Color sheet. Only modify if you know what you're doing
SH_SZ.Style = {
	header = Color(52, 152, 219, 255),
	bg = Color(52, 73, 94, 255),
	inbg = Color(44, 62, 80, 255),

	close_hover = Color(231, 76, 60, 255),
	hover = Color(255, 255, 255, 10, 255),
	hover2 = Color(255, 255, 255, 5, 255),

	text = Color(255, 255, 255, 255),
	text_down = Color(0, 0, 0),
	textentry = Color(236, 240, 241),
	menu = Color(127, 140, 141),

	success = Color(46, 204, 113),
	failure = Color(231, 76, 60),
}

/**
* Language configuration
**/

-- Various strings used throughout the chatbox. Change them to your language here.
-- %s and %d are special strings replaced with relevant info, keep them in the string!

SH_SZ.Language = {
	safezone = "Безопасная зона",
	safezone_type = "Тип безопасной зоны",
	cube = "Куб",
	sphere = "Сфера",

	select_a_safezone = "Выбрать безопасную зону",

	options = "Настройка",
	name = "Имя",
	name_color = "Цвет",
	enable_hud_indicator = "Включить индикатор ХУД",
	delete_non_admin_props = "Удаление не-админских элементов",
	prevent_attacking_with_weapons = "Предотвращать атаки игроков",
	automatically_remove_npcs = "Удалить НПС",
	time_until_protection_enables = "Время до включения защиты",
	enter_message = "Сообщение при входе",
	leave_message = "Сообщение при выходе",

	will_be_protected_in_x = "Вы будете защищены в течении %s секунд",
	safe_from_damage = "Вы защищены от любого урона.",

	place_point_x = "Нумеровать точку. %d с помощью мыши",
	size = "Размер",
	finalize_placement = "Выберите место для размещения и нажмите \"Подтвердить\"",

	add = "Добавить",
	edit = "Изменить",
	fill_vertically = "Заполнить вертикально",
	reset = "Восстановить",
	confirm = "Подтвердить",
	teleport_there = "Телепортироваться сюда",
	save = "Сохранить",
	delete = "Удалить",
	cancel = "Отменить",
	move_camera = "Двигать камеру",
	rotate_camera = "Правый щелчок: вращение камерой",

	an_error_has_occured = "Произошла ошибка, перезапустите сервер или повторите попытку",
	not_allowed = "Вы не можете этого сделать!",
	safe_zone_created = "Безопасная зона была успешна создана!",
	safe_zone_edited = "Безопасная зона успешно изменена!",
	safe_zone_deleted = "Безопасная зона успешно удалена!",
}