### A Pluto.jl notebook ###
# v0.14.4

using Markdown
using InteractiveUtils

# ╔═╡ 8e23ae4c-a9bc-11eb-360c-295de11828c7
using LinkedLists

# ╔═╡ 6e554a62-436e-40a5-82f1-ebf48e24945b
using Luxor, Colors

# ╔═╡ 2cabb6ab-bb27-4cea-b279-027d596ee7eb
l = LinkedList{Int64}

# ╔═╡ 08f7601a-8333-4b7f-8b3b-509e794ca510
v = [10,20]

# ╔═╡ ab08ec0e-d92f-49d5-a14f-4d85a80f5ac7
methods(insert!)

# ╔═╡ d6e2c847-02a8-47a3-b44d-2755c996c0bc
begin
	function insert_vec!(a::Vector{T}, i::Integer, items::Vector{T}) where T
		for (pos, el) in enumerate(items)
			insert!(a, i+pos, el)
		end
	end
end

# ╔═╡ c49f0d50-915d-49ff-a8e6-d8faef043049
#insert_vec!(v, 1, [1,2,3])

# ╔═╡ 180ca001-cd0b-44ae-8950-1e687e331e7d
v

# ╔═╡ ae8e3ce2-db3b-4e68-a6ac-2299335781ab
begin
	function replace_vec!(a::Vector{T}, i::Integer, items::Vector{T}) where T
		for (pos, el) in enumerate(items)
			insert!(a, i+pos, el)
		end
		deleteat!(a, i)
		return(a)
	end
end

# ╔═╡ 27d698bc-9930-4ad8-adc1-6cb53417f4c7
replace_vec!(v, 1, [1,2,3])

# ╔═╡ 0f19086e-b143-4be0-b1cf-3b6d43daae28
replace_vec!([10,20,30], 1, [1,2,3])

# ╔═╡ 820fe813-dc9c-43d3-9654-c1f3e5f6e6c3
struct Rule
	name::String
end

# ╔═╡ 3c359ab5-1a50-4aac-940c-e289f7262405
Rule("ciao")

# ╔═╡ bd6fdcbb-3c53-4a53-a090-aeb2ddafbefe
replacements = Dict(
	"a" => ["a", "b"],
	"b" => ["b", "b"]
)

# ╔═╡ 3061fb91-7619-4f46-be2d-6e32830acce7
replacements["a"]

# ╔═╡ d8800c20-7149-455a-b445-2a5214018804
function l_system_pass(seq::Vector{String}, rules)
	for (i, el) in enumerate(seq)
		if haskey(rules, el)
			rep = rules[el]
			replace_vec!(seq, i, rep)
		end
	end
end

# ╔═╡ bbf96046-b3fc-450a-ba37-d4452aabc1fe
begin
	b = [1,2,3]
	c = b
	push!(c, 4)
	b
end


# ╔═╡ 6710ee14-e109-4cbe-ad4d-5c2f5e6a094b
function l_system_pas(seq::Vector{String}, rules)
	new_seq = map(seq) do el
		@show el
		if haskey(rules, el)
			return rules[el]
		else
			return [el]
		end
	end
	@show new_seq
	return collect(Iterators.flatten(new_seq))
end
		

# ╔═╡ f55b5170-6f8e-4f54-aad1-b5d4ca4bf5ed
seq1 = ["a", "b"]

# ╔═╡ 1d9dcdfc-a78b-45a0-99ca-e40c78d540fb
l_system_pass(seq1, replacements)

# ╔═╡ 5462d819-9267-4550-bbd8-0ed99bea1b0b
@svg line(Point(0,0), Point(10,10), :stroke)

# ╔═╡ b8392544-692d-4d93-844a-d82f53c4a9d7


# ╔═╡ Cell order:
# ╠═8e23ae4c-a9bc-11eb-360c-295de11828c7
# ╠═2cabb6ab-bb27-4cea-b279-027d596ee7eb
# ╠═08f7601a-8333-4b7f-8b3b-509e794ca510
# ╠═ab08ec0e-d92f-49d5-a14f-4d85a80f5ac7
# ╠═d6e2c847-02a8-47a3-b44d-2755c996c0bc
# ╠═c49f0d50-915d-49ff-a8e6-d8faef043049
# ╠═180ca001-cd0b-44ae-8950-1e687e331e7d
# ╠═ae8e3ce2-db3b-4e68-a6ac-2299335781ab
# ╠═27d698bc-9930-4ad8-adc1-6cb53417f4c7
# ╠═0f19086e-b143-4be0-b1cf-3b6d43daae28
# ╠═820fe813-dc9c-43d3-9654-c1f3e5f6e6c3
# ╠═3c359ab5-1a50-4aac-940c-e289f7262405
# ╠═bd6fdcbb-3c53-4a53-a090-aeb2ddafbefe
# ╠═3061fb91-7619-4f46-be2d-6e32830acce7
# ╠═d8800c20-7149-455a-b445-2a5214018804
# ╠═bbf96046-b3fc-450a-ba37-d4452aabc1fe
# ╠═6710ee14-e109-4cbe-ad4d-5c2f5e6a094b
# ╠═f55b5170-6f8e-4f54-aad1-b5d4ca4bf5ed
# ╠═1d9dcdfc-a78b-45a0-99ca-e40c78d540fb
# ╠═6e554a62-436e-40a5-82f1-ebf48e24945b
# ╠═5462d819-9267-4550-bbd8-0ed99bea1b0b
# ╠═b8392544-692d-4d93-844a-d82f53c4a9d7
