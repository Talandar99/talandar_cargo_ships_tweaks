local function register_with_cargo_ships()
	-- add pirateship to cargo_ship ships so it can be entered the same way as other ships
	if remote.interfaces["cargo-ships"] and remote.interfaces["cargo-ships"].add_boat then
		if prototypes.entity["pirateship"] then
			remote.call("cargo-ships", "add_ship", {
				name = "pirateship_rail",
				engine = "pirateship_engine",
				engine_scale = 0.6,
				engine_at_front = true,
			})

			remote.call("cargo-ships", "add_boat", {
				name = "pirateship",
				rail_version = "pirateship_rail",
			})
			log("Registered Pirate Ship as a boat for Cargo Ships system.")
		else
			log("Pirate Ship entity not found.")
		end
	else
		log("Cargo Ships API not available (add_boat missing).")
	end
end

local function on_init(event)
	register_with_cargo_ships()
end
script.on_init(on_init)

local function on_configuration_changed(event)
	register_with_cargo_ships()
end
script.on_configuration_changed(on_configuration_changed)
