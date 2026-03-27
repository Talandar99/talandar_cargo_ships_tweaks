if mods["pirateship"] then
	table.insert(data.raw.technology["steel-axe"].effects, { type = "unlock-recipe", recipe = "pirateship" })
end
table.insert(data.raw.technology["steel-axe"].effects, { type = "unlock-recipe", recipe = "port" })

data.raw["shortcut"]["give-waterway"].technology_to_unlock = "steel-axe"
