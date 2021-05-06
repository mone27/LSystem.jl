### A Pluto.jl notebook ###
# v0.14.4

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ f1dabadc-87be-42b7-b1e8-5f27a7818728
using Revise

# ╔═╡ e9ae675b-c499-4060-ad4f-dbe2270ec58e
using PlutoUI, Luxor, LSystem

# ╔═╡ 37ee208a-1ea2-4ca4-bae3-6b28ffe57f08
rules = Dict(
	"A" => "F(10) LMul(.5) [ T(60) F B ] F",
	"B" => "F(10) LMul(.5) [ T(-60) F A ] F"
)

# ╔═╡ 5bcc3fbf-1c9b-4007-877b-bad8b06f337e
@bind times Slider(1:10)

# ╔═╡ 69326372-61d1-45a6-b270-1c29740f7fa4
times

# ╔═╡ 6f45bd3e-bc4b-4197-9392-cfc74f18421d
plot_l_system("M(-300) F(30) A", rules, times)

# ╔═╡ cdda1f35-4c5f-4f78-904e-6023ca50f806
LTurtle()

# ╔═╡ 1fbf2b2a-af0c-4e7d-8b0a-db4f03d1c4ad
rules2 = Dict(
	"A" => "LMul(.85) [ LMul(.6) T(40) F(50) B ] F(70) B",
	"B" => "LMul(.85) [ LMul(.6) T(-40) F(50) A ] F(70) A"
)

# ╔═╡ 7ed53d6a-6657-423e-be9d-8093414adca9
@bind times2 Slider(1:17)

# ╔═╡ 9a9fb7f6-0d64-4fe6-bfff-898923967ef7
times2

# ╔═╡ f7d4a57e-d2c6-43f2-9b66-18038b55ce7b
plot_l_system("M(-250) F(30) A B", rules2, times2, write_text=false)

# ╔═╡ d39c2721-8d70-4a2f-bac3-2df4f93b4067
rules3 = Dict(
	"A" => "LMul(.85) [ LMul(.55) T(40) F(40) A ] [ LMul(.55) T(-40) F(40) A ] F(80) A"
)

# ╔═╡ c696cc8d-fa46-4883-a1ad-d9e87bec7107
@bind times3 Slider(1:15)

# ╔═╡ 30a489f9-f10c-4917-9597-585aec3bc319
times3

# ╔═╡ eb3e5ece-f7e0-4999-b5b7-e720c15c34da
plot_l_system("M(-300) Col(0,.4,0.1) F(30) A B", rules3, times3, write_text=false)

# ╔═╡ Cell order:
# ╠═f1dabadc-87be-42b7-b1e8-5f27a7818728
# ╠═e9ae675b-c499-4060-ad4f-dbe2270ec58e
# ╠═37ee208a-1ea2-4ca4-bae3-6b28ffe57f08
# ╠═5bcc3fbf-1c9b-4007-877b-bad8b06f337e
# ╟─69326372-61d1-45a6-b270-1c29740f7fa4
# ╠═6f45bd3e-bc4b-4197-9392-cfc74f18421d
# ╠═cdda1f35-4c5f-4f78-904e-6023ca50f806
# ╠═1fbf2b2a-af0c-4e7d-8b0a-db4f03d1c4ad
# ╠═7ed53d6a-6657-423e-be9d-8093414adca9
# ╟─9a9fb7f6-0d64-4fe6-bfff-898923967ef7
# ╠═f7d4a57e-d2c6-43f2-9b66-18038b55ce7b
# ╠═d39c2721-8d70-4a2f-bac3-2df4f93b4067
# ╠═c696cc8d-fa46-4883-a1ad-d9e87bec7107
# ╠═30a489f9-f10c-4917-9597-585aec3bc319
# ╠═eb3e5ece-f7e0-4999-b5b7-e720c15c34da
