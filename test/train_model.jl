using DifferentialEquations

# u[1] is Susceptible (all people or all peaple - infected + 20 days)
# u[2] is infected (eg confirmed for me)
# u[3] is removed
function f(du,u,p,t)
    p = [0.9/80000000000,1/5] # ß,v
    du[1]=-p[1]u[1]u[2]
    du[2]=p[1]u[1]u[2]-p[2]u[2]
    du[3]=p[2]u[2] # = N - u[1] - u[2]
    return du
end


u0 = [80000000000.,5.,0]
tspan = (0.0,1000.0)
prob = ODEProblem(f,u0,tspan)
sol = Array(solve(prob, Tsit5(), reltol=1e-8, abstol=1e-8))


plot(log.(sol[1,:]), label = "Susceptible", color = "blue",
    grid = "off", legend=:bottomright, title = "SIR Model", ylab =
     "log(Cases)", xlab = "Pseudo time")
plot!(log.(sol[2,:]), color = "red", label = "Infected")
plot!(log.(sol[3,:]), label = "Recovered", color = "green")

scatter!(log.(i.confirmed[:]), color = "red", markershape = :star4, label = "Italy confirmed")
scatter!(log.(i.recovered[:]), color = "green", markershape = :star4, label = "Italy recovered")

scatter!(log.(g.confirmed[:]), color = "red", markershape = :cross, label = "Germany confirmed")
scatter!(log.(g.recovered[:]), color = "green", markershape = :cross, label = "Germany recovered")
