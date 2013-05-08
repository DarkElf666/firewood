minetest.register_node("firewood:firewood", {
  description = "Firewood",
	tiles = {"firewood.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
}) 

minetest.register_craft({
	output = "firewood:firewood",
	recipe = {
		{"", "default:stick", ""},
		{"default:stick", "default:wood", "default:stick"}
	}
})

minetest.register_node("firewood:flame", {
	description = "Firewood Fire",
	drawtype = "plantlike",
	tiles = {{
		name="fire_basic_flame_animated.png",
		animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1},
	}},
	inventory_image = "fire_basic_flame.png",
	light_source = 14,
	groups = {dig_immediate=3},
	drop = '',
	walkable = false,
	buildable_to = true,
	damage_per_second = 1,
})

minetest.register_abm({
	nodenames = {"firewood:firewood"},
	interval = 1,
	chance = 1,
	action = function(p0, node, _, _)
		local fpos = {x = p0.x, y = p0.y + 1, z = p0.z}
		local ps = minetest.env:find_nodes_in_area(fpos, fpos, {"fire:basic_flame"})
		if #ps ~= 0 then
			minetest.env:set_node(fpos, {name="firewood:flame"})
		end
	end,
})

minetest.register_abm({
	nodenames = {"firewood:flame"},
	interval = 1,
	chance = 1,
	action = function(p0, node, _, _)
		local fpos = {x = p0.x, y = p0.y - 1, z = p0.z}
		local ps = minetest.env:find_nodes_in_area(fpos, fpos, {"firewood:firewood"})
		if #ps == 0 then
			minetest.env:set_node(p0, {name="air"})
		end
	end,
})
