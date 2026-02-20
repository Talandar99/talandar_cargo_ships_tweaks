local pirate_ship = data.raw["car"]["pirateship"]
pirate_ship.icon = "__talandar_cargo_ships_tweaks__/graphics/pirateship/pirateship_icon.png"
pirate_ship.icon_size = 64
pirate_ship.inventory_size = 40
--pirate_ship.friction = 0.002
--pirate_ship.friction = 0.03
pirate_ship.friction = 0.01
pirate_ship.terrain_friction_modifier = 0.2
pirate_ship.animation = {
	layers = {
		{
			priority = "low",
			direction_count = 128,
			width = 1002,
			height = 1002,
			stripes = {
				{
					filename = "__talandar_cargo_ships_tweaks__/graphics/pirateship/newRend_0.png",
					width_in_frames = 8,
					height_in_frames = 8,
				},
				{
					filename = "__talandar_cargo_ships_tweaks__/graphics/pirateship/newRend_1.png",
					width_in_frames = 8,
					height_in_frames = 8,
				},
			},

			shift = util.by_pixel(0, 0),
			scale = 1,
			max_advance = 0.2,
		},
	},
}
local pirate_ship_pictures = {
	rotated = {
		layers = {
			{
				priority = "low",
				direction_count = 128,
				width = 1002,
				height = 1002,
				filenames = {
					"__talandar_cargo_ships_tweaks__/graphics/pirateship/newRend_0.png",
					"__talandar_cargo_ships_tweaks__/graphics/pirateship/newRend_1.png",
				},
				line_length = 8,
				lines_per_file = 8,
				shift = util.by_pixel(0, -120),
				scale = 1,
				max_advance = 0.2,
			},
		},
	},
}

local pirate_ship_item = data.raw["item-with-entity-data"]["pirateship"]
pirate_ship_item.icon = "__talandar_cargo_ships_tweaks__/graphics/pirateship/pirateship_icon.png"
pirate_ship_item.icon_size = 64
--pirate_ship.water_reflection = {
--	pictures = {
--		{
--			priority = "low",
--			direction_count = 128,
--			width = 1002,
--			height = 1002,
--			stripes = {
--				{
--					filename = "__talandar_cargo_ships_tweaks__/graphics/pirateship/newRend_0_waterreflection.png",
--					width_in_frames = 8,
--					height_in_frames = 8,
--				},
--				{
--					filename = "__talandar_cargo_ships_tweaks__/graphics/pirateship/newRend_1_waterreflection.png",
--					width_in_frames = 8,
--					height_in_frames = 8,
--				},
--			},
--
--			shift = util.by_pixel(0, 0),
--			scale = 1,
--			max_advance = 0.2,
--		},
--	},
--}

--pirate_ship.water_reflection = {
--	{
--		pictures = {
--			filename = "__talandar_cargo_ships_tweaks__/graphics/pirateship/newRend_1_waterreflection.png",
--			width = 1002,
--			height = 1002,
--			shift = util.by_pixel(0, 0),
--			scale = 1,
--			max_advance = 0.2,
--			priority = "extra-high",
--			width_in_frames = 8,
--			height_in_frames = 8,
--		},
--	},
--}
--
----------------------------------------------------------------
------------------------ BOAT  ----------------------------
----------------------------------------------------------------

local boat_max_speed = 0.09

local boat = table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])
boat.name = "pirateship_rail"
boat.icon = "__talandar_cargo_ships_tweaks__/graphics/pirateship/pirateship_icon.png"

boat.icon_size = 64
boat.flags = { "placeable-neutral", "player-creation", "placeable-off-grid", "not-on-map" }
boat.allow_copy_paste = true
boat.minable = { mining_time = 1, result = "pirateship" }
boat.placeable_by = { { item = "pirateship", count = 1 } }
boat.max_health = 1500
boat.selection_box = { { -1.2, -1.5 }, { 1.2, 3 } }
boat.collision_box = { { -1.3, -1.5 }, { 1.3, 3 } }
--boat.collision_box = { { -1.2, -2.2 }, { 1.2, 4.2 } }
--boat.selection_box = { { -1.2, -0.2 }, { 1.2, 6.2 } }
--boat.selection_box = { { -1.2, -0.2 }, { 1.2, 4.2 } }
boat.selection_priority = 51
--boat.vertical_selection_shift = 5
boat.connection_distance = 2.5
boat.joint_distance = 2
--boat.water_reflection = water_reflection("boat/railed/boat", 60, 15, true)
boat.weight = 5000
boat.inventory_size = 40
boat.max_speed = boat_max_speed
boat.pictures = pirate_ship_pictures
boat.stand_by_light = nil
boat.horizontal_doors = nil
boat.vertical_doors = nil
boat.wheels = nil
boat.working_sound = nil
boat.drive_over_tie_trigger = nil
boat.factoriopedia_simulation = nil
boat.corpse = nil

----------------------------------------------------------------
------------------------ BOAT ENGINE ---------------------------
----------------------------------------------------------------

local boat_engine_power = 300

local boat_engine = table.deepcopy(data.raw["locomotive"]["locomotive"])
boat_engine.name = "pirateship_engine"
boat_engine.flags = { "placeable-neutral", "placeable-off-grid", "player-creation" }
boat_engine.hidden_in_factoriopedia = true
boat_engine.allow_copy_paste = true
boat_engine.minable = { mining_time = 1, results = nil }
boat_engine.icon = data.raw["item"]["engine-unit"].icon
boat_engine.weight = 5000
boat_engine.max_speed = boat_max_speed
boat_engine.max_power = boat_engine_power .. "kW"
boat_engine.air_resistance = 0.02
--boat_engine.collision_box = { { -1.1, -1.2 }, { 1.1, 1.2 } }
--boat_engine.selection_box = { { -1.1, -1.2 }, { 1.1, 1.2 } }
boat_engine.collision_box = { { -0.6, -0.8 }, { 0.6, 0.8 } }
boat_engine.selection_box = { { -1.0, -1.0 }, { 1.0, 1.0 } }
boat_engine.selection_priority = 51
boat_engine.connection_distance = 2.5
boat_engine.joint_distance = 1.2
boat_engine.energy_source = {
	type = "void",
}
boat_engine.pictures = nil
boat_engine.water_reflection = nil
boat_engine.wheels = nil
--boat_engine.working_sound = car_sounds
boat_engine.front_light = nil
boat_engine.front_light_pictures = nil
boat_engine.back_light = nil
boat_engine.stand_by_light = nil
boat_engine.stop_trigger = nil
boat_engine.drive_over_tie_trigger = nil
boat_engine.factoriopedia_simulation = nil
boat_engine.corpse = nil

data:extend({ boat, boat_engine })
