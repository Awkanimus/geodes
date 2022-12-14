geodes = {}

minetest.register_node("geodes:calcite", {
	description = "Calcite",
	tiles = {"calcite.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("geodes:amethyst_block", {
	description = "Amethyst Block",
	tiles = {"amethyst_block.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("geodes:basalt", {
	description = "Basalt",
	tiles = {"basalt.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("geodes:amethyst_crystal", {
	description = "Amethyst Crystal",
	tiles = {"amethyst_crystal.png"},
	inventory_image = "amethyst_crystal.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "wallmounted",
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
	node_box = {
		type = "fixed",
		fixed = {-5/16, -0.5, -5/16, 5/16, 5/16, 5/16}
	},
	selection_box = {
		type = "fixed",
		fixed = {-5/16, -0.5, -5/16, 5/16, 5/16, 5/16}
	},
})

minetest.register_node("geodes:geode_core", {
	groups = {not_in_creative_inventory = 1},
})

function geodes.register_geode(outer, middle, inner, crystal, core)

    minetest.register_abm({
        label = "make_geode",
        nodenames = {core},
        interval = 1,
        chance = 1,
        action = function(pos, node)

		local size = math.random(6, 11)

		for x = -size, size do
		for y = -size, size do
		for z = -size, size do
		if minetest.get_node(pos + vector.new(x, y, z)).name ~= "air" then
		if vector.distance(vector.new(x, y, z), vector.new()) < size then
			minetest.set_node(pos + vector.new(x, y, z), {name = outer})
		if vector.distance(vector.new(x, y, z), vector.new()) < size - 1 then
			minetest.set_node(pos + vector.new(x, y, z), {name = middle})
		if vector.distance(vector.new(x, y, z), vector.new()) < size - 2 then
			minetest.set_node(pos + vector.new(x, y, z), {name = inner})
		if vector.distance(vector.new(x, y, z), vector.new()) < size - 3 then
			minetest.set_node(pos + vector.new(x, y, z), {name = "air"})
		end
		end
		end
		end
		end
		end
		end
		end

		for x = -size +4, size -4 do
		for y = -size +4, size -4 do
		for z = -size +4, size -4 do
		if math.random(0, 10) == 0 and vector.distance(vector.new(x, y, z), vector.new()) >= size - 4 and  vector.distance(vector.new(x, y, z), vector.new()) < size - 3 then

			if minetest.get_node(pos + vector.new(x, y + 1, z)).name == inner then
			minetest.set_node(pos + vector.new(x, y, z), {name = crystal, param2 = 0})
			elseif minetest.get_node(pos + vector.new(x, y - 1, z)).name == inner then
			minetest.set_node(pos + vector.new(x, y, z), {name = crystal, param2 = 1})
			elseif minetest.get_node(pos + vector.new(x + 1, y, z)).name == inner then
			minetest.set_node(pos + vector.new(x, y, z), {name = crystal, param2 = 2})
			elseif minetest.get_node(pos + vector.new(x - 1, y, z)).name == inner then
			minetest.set_node(pos + vector.new(x, y, z), {name = crystal, param2 = 3})
			elseif minetest.get_node(pos + vector.new(x, y, z + 1)).name == inner then
			minetest.set_node(pos + vector.new(x, y, z), {name = crystal, param2 = 4})
			elseif minetest.get_node(pos + vector.new(x, y, z - 1)).name == inner then
			minetest.set_node(pos + vector.new(x, y, z), {name = crystal, param2 = 5})
			
			end
		end
		end
		end
		end

	end,
    })

minetest.register_ore({
	ore_type       = "scatter",
	ore            = core,
	wherein        = "default:stone",
	clust_scarcity = 64 * 64 * 64,
	clust_num_ores = 1,
	clust_size     = 1,
	y_max          = -40,
	y_min          = -31000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = core,
	wherein        = "air",
	clust_scarcity = 64 * 64 * 64,
	clust_num_ores = 1,
	clust_size     = 1,
	y_max          = -40,
	y_min          = -31000,
})

end


geodes.register_geode("geodes:basalt", "geodes:calcite", "geodes:amethyst_block", "geodes:amethyst_crystal", "geodes:geode_core")