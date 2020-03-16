using DataFrames, Query, CSV, Plots
# this line downloads daily updated numbers. See the called .sh files for details
# run(`bash data/download_daily_news.sh`);

csv_path_Confirmed = "data/Confirmed_mod.csv"
csv_path_Deaths = "data/Deaths_mod.csv"
csv_path_Recovered = "data/Recovered_mod.csv"
df_Confirmed = DataFrame(CSV.File(csv_path_Confirmed))
df_Deaths = DataFrame(CSV.File(csv_path_Deaths))
df_Recovered = DataFrame(CSV.File(csv_path_Recovered))

names(df_Confirmed)==names(df_Deaths)==names(df_Recovered)
dates = names(df_Recovered)[5:end]

mutable struct country
      name::String
      confirmed::AbstractArray{Int32, 2}
      deaths::AbstractArray{Int32, 2}
      recovered::AbstractArray{Int32, 2}
end

function get_time_course_for_country(temp_c)
      #filter for the country
      temp_c_Confirmed = df_Confirmed |> @filter(_.Country_Region == temp_c) |> DataFrame
      temp_c_Deaths = df_Deaths |> @filter(_.Country_Region == temp_c) |> DataFrame
      temp_c_Recovered = df_Recovered |> @filter(_.Country_Region == temp_c) |> DataFrame
      #get timecourse
      temp_c_Confirmed_time_course = Array(temp_c_Confirmed[r".20"])
      temp_c_Deaths_time_course = Array(temp_c_Deaths[r".20"])
      temp_c_Recovered_time_course = Array(temp_c_Recovered[r".20"])
      return country(temp_c, temp_c_Confirmed_time_course, temp_c_Deaths_time_course, temp_c_Recovered_time_course)
end

function visualise_time_course(temp_c)
      temp_c_plt = scatter(log.(temp_c.confirmed[:]), color = "red", label = "Confirmed",
            grid = "off", legend=:topleft, title = temp_c.name, ylab = "log(Cases)", xlab = "Days since outbreak")
      scatter!(log.(temp_c.deaths[:]), color ="white", label = "Death")
      scatter!(log.(temp_c.recovered[:]), color ="green", label = "Recovered")
      plot!(log.(temp_c.confirmed[:]), color = "red", label = "")
      plot!(log.(temp_c.deaths[:]), color ="black", label = "")
      plot!(log.(temp_c.recovered[:]), color ="green", label = "")
      return temp_c_plt
end

example_country = "Germany"
g = get_time_course_for_country(example_country)
g_plt = visualise_time_course(g)

example_country = "Italy"
i = get_time_course_for_country(example_country)
i_plt = visualise_time_course(i)
