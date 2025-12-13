local ship = data.raw["locomotive"]["cargo_ship_engine"]
ship.energy_source = ship.energy_source or {}
--ship.energy_source.effectivity = 1
ship.energy_source.effectivity = 1.5
ship.energy_source.fuel_inventory_size = 10

-- oil rig
if data.raw["electric-pole"]["or_pole"] then
	data.raw["electric-pole"]["or_pole"].supply_area_distance = 7.5 --old was 4.5
end

if data.raw["storage-tank"]["or_tank"] then
	data.raw["storage-tank"]["or_tank"].fluid_box.volume = 150000 --overrides default settings
end
if data.raw["generator"]["or_power_electric"] then
	local gen = data.raw["generator"]["or_power_electric"]
	gen.fluid_box.filter = nil
	gen.max_power_output = "350kW" --was 850
	gen.energy_source.output_flow_limit = "350kW" --was 850
	gen.fluid_box.volume = 500
	gen.effectivity = 5000
end
if data.raw["mining-drill"]["oil_rig"] then
	data.raw["mining-drill"]["oil_rig"].energy_usage = "120kW" -- was 750
end

if data.raw["cargo-wagon"]["cargo_ship"] then
	data.raw["cargo-wagon"]["cargo_ship"].inventory_size = 300
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
