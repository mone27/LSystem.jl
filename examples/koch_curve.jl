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

# ╔═╡ cfa346b6-afde-11eb-1586-794a0420d5d4
using Revise

# ╔═╡ 8b4db20f-ca3e-4b9e-9a7b-0eba2e270eb5
using PlutoUI, LSystem

# ╔═╡ 133da7e2-2585-4af0-8aa4-3b9f39fa293b
@bind times Slider(1:7)

# ╔═╡ 3b1dc783-d337-45e6-b17c-60e6bc8c2ec9
times

# ╔═╡ d8113b52-fcc9-4d89-a7c5-8ab66a7f83fd
plot_l_system("M(-200) LMul(.8) F(10) T(120) F(10) T(120) F(10)",
	Dict("F(x)" => "F(x/3) T(-60) F(x/3) T(60) T(60) F(x/3) T(-60) F(x/3)"),
	times)

# ╔═╡ Cell order:
# ╠═cfa346b6-afde-11eb-1586-794a0420d5d4
# ╠═8b4db20f-ca3e-4b9e-9a7b-0eba2e270eb5
# ╠═133da7e2-2585-4af0-8aa4-3b9f39fa293b
# ╟─3b1dc783-d337-45e6-b17c-60e6bc8c2ec9
# ╠═d8113b52-fcc9-4d89-a7c5-8ab66a7f83fd
