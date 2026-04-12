local ship = data.raw["locomotive"]["cargo_ship_engine"]
ship.energy_source = ship.energy_source or {}
--ship.energy_source.effectivity = 1
ship.energy_source.effectivity = 1.5
ship.energy_source.fuel_inventory_size = 10

-- oil rig
if data.raw["electric-pole"]["or_pole"] then
	data.raw["electric-pole"]["or_pole"].supply_area_distance = 7.5 --old was 4.5
end

--if data.raw["storage-tank"]["or_tank"] then
--data.raw["storage-tank"]["or_tank"].fluid_box.volume = 150000 --overrides default settings
--data.raw["storage-tank"]["or_tank"].fluid_box.volume = 300000 --overrides default settings
--end
if data.raw["generator"]["or_power_electric"] then
	local gen = data.raw["generator"]["or_power_electric"]
	gen.fluid_box.filter = nil
	gen.max_power_output = "350kW" --was 850
	gen.energy_source.output_flow_limit = "350kW" --was 850
	gen.fluid_box.volume = 500
	gen.effectivity = 5000
end

if data.raw["cargo-wagon"]["cargo_ship"] then
	data.raw["cargo-wagon"]["cargo_ship"].inventory_size = 500
end

if data.raw["car"]["indep-boat"] then
	data.raw["car"]["indep-boat"].inventory_size = 50
	data.raw["car"]["indep-boat"].allow_remote_driving = true
	data.raw["car"]["indep-boat"].equipment_grid = "medium-equipment-grid"
	data.raw["car"]["indep-boat"].trash_inventory_size = 10
	data.raw["car"]["indep-boat"].chunk_exploration_radius = 3
	data.raw["car"]["indep-boat"].friction = 0.001
	data.raw["car"]["indep-boat"].braking_power = "0.75MW"
	--indep_boat.friction = 0.002/speed_modifier -- default speed_modifier is 1
end

if mods["pirateship"] then
	-- remove buggy input from pirate ship mod
	data:extend({
		{
			type = "custom-input",
			name = "enter-pirate-ship",
			key_sequence = "",
			consuming = "none",
		},
	})
	require("pirate-ship")
	data.raw["recipe"]["pirateship"].ingredients = {
		{ type = "item", name = "wood", amount = 100 },
		{ type = "item", name = "iron-plate", amount = 10 },
	}
	data.raw["recipe"]["pirateship"].energy_required = 10
	local t = data.raw["technology"]["Pirate_Ship"]

	t.icon = "__talandar_cargo_ships_tweaks__/graphics/pirateship/pirateship_tech_icon.png"
	t.icon_size = 256
	t.effects = {
		{ type = "unlock-recipe", recipe = "pirateship-cannonball" },
	}
end

-------------------------------------------------------------------------------
-- oil rig
-------------------------------------------------------------------------------
data.raw["item"]["oil_rig"].weight = 1000 * kg
if data.raw["mining-drill"]["oil_rig"] then
	data.raw["mining-drill"]["oil_rig"].energy_usage = "120kW" -- was 750
end
local t = data.raw["technology"]["deep_sea_oil_extraction"]
t.prerequisites = {
	"oil-gathering",
	"concrete",
}

t.unit = {
	count = 300,
	ingredients = {
		{ "automation-science-pack", 1 },
		{ "logistic-science-pack", 1 },
	},
	time = 30,
}
if data.raw["recipe"]["oil_rig"] then
	data.raw["recipe"]["oil_rig"].ingredients = {
		{ type = "item", name = "steel-plate", amount = 200 },
		{ type = "item", name = "iron-gear-wheel", amount = 50 },
		{ type = "item", name = "pipe", amount = 100 },
		{ type = "item", name = "steam-engine", amount = 3 },
		{ type = "item", name = "storage-tank", amount = 6 },
		{ type = "item", name = "concrete", amount = 100 },
	}
end
-------------------------------------------------------------------------------
-- port
-------------------------------------------------------------------------------
if data.raw["recipe"]["port"] then
	data.raw["recipe"]["port"].ingredients = {
		{ type = "item", name = "steel-plate", amount = 5 },
		{ type = "item", name = "iron-plate", amount = 20 },
	}
end
-------------------------------------------------------------------------------
-- hide bridge and all related things
if settings["tldr-cargo-ships-old-train-bridge"] then
	-- items
	if data.raw["item"]["bridge_base"] then
		data.raw["item"]["bridge_base"].hidden = true
		data.raw["item"]["bridge_base"].hidden_in_factoriopedia = true
	end

	if data.raw["item"]["bridge_gate"] then
		data.raw["item"]["bridge_gate"].hidden = true
		data.raw["item"]["bridge_gate"].hidden_in_factoriopedia = true
	end

	-- hide train-stop entity
	if data.raw["train-stop"]["bridge_base"] then
		local e = data.raw["train-stop"]["bridge_base"]
		e.selectable_in_game = false
		e.flags = {
			"placeable-neutral",
			"not-blueprintable",
			"not-deconstructable",
			"not-upgradable",
		}
		e.hidden_in_factoriopedia = true
	end

	-- hide gate entity
	if data.raw["gate"]["bridge_gate"] then
		local g = data.raw["gate"]["bridge_gate"]
		g.selectable_in_game = false
		g.flags = {
			"placeable-neutral",
			"not-blueprintable",
			"not-deconstructable",
		}
		g.hidden_in_factoriopedia = true
	end

	-- hide recipes
	if data.raw["recipe"]["bridge_base"] then
		data.raw["recipe"]["bridge_base"].enabled = false
		data.raw["recipe"]["bridge_base"].hidden = true
		data.raw["recipe"]["bridge_base"].hidden_in_factoriopedia = true
	end

	if data.raw["recipe"]["bridge_gate"] then
		data.raw["recipe"]["bridge_gate"].enabled = false
		data.raw["recipe"]["bridge_gate"].hidden = true
		data.raw["recipe"]["bridge_gate"].hidden_in_factoriopedia = true
	end

	local function hide_technology_and_rewire(old_tech, new_tech)
		local old = data.raw.technology[old_tech]
		local new = data.raw.technology[new_tech]

		if not old or not new then
			return
		end

		for _, tech in pairs(data.raw.technology) do
			if tech.prerequisites then
				for i = #tech.prerequisites, 1, -1 do
					if tech.prerequisites[i] == old_tech then
						table.remove(tech.prerequisites, i)

						local exists = false
						for _, p in pairs(tech.prerequisites) do
							if p == new_tech then
								exists = true
								break
							end
						end

						if not exists then
							table.insert(tech.prerequisites, new_tech)
						end
					end
				end
			end
		end

		if old.effects then
			new.effects = new.effects or {}
			for _, effect in pairs(old.effects) do
				table.insert(new.effects, effect)
			end
		end

		old.hidden = true
		old.enabled = false
	end
	data.raw["technology"]["automated_bridges"].effects = {}
	hide_technology_and_rewire("automated_bridges", "automated_water_transport")
end
