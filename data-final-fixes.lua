if mods["space-exploration"] then
	if not data.raw["fish"]["fish"].collision_mask.colliding_with_tiles_only then
		data.raw["fish"]["fish"].collision_mask.colliding_with_tiles_only = true
	end
end

-- hide bridge and all related things
if settings.startup["tldr-disable-old-train-bridge"].value then
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
