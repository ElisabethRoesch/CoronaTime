using DataFrames, Query, CSV, Plots
# this line downloads daily updated numbers. See the called .sh files for details
run(`bash data/download_daily_news.sh`);

csv_path_Confirmed = "data/Confirmed_mod.csv"
csv_path_Deaths = "data/Deaths_mod.csv"
csv_path_Recovered = "data/Recovered_mod.csv"
df_Confirmed = DataFrame(CSV.File(csv_path_Confirmed))
df_Deaths = DataFrame(CSV.File(csv_path_Deaths))
df_Recovered = DataFrame(CSV.File(csv_path_Recovered))

names(df_Confirmed)==names(df_Deaths)==names(df_Recovered)


function get_time_course_for_country(temp_country)
      #filter for the country
      temp_country_Confirmed = df_Confirmed |> @filter(_.Country_Region == country_temp) |> DataFrame
      temp_country_Deaths = df_Deaths |> @filter(_.Country_Region == country_temp) |> DataFrame
      temp_country_Recovered = df_Recovered |> @filter(_.Country_Region == country_temp) |> DataFrame
      #get timecourse
      temp_country_Confirmed_time_course = Array(temp_country_Confirmed[r".20"])
      temp_country_Deaths_time_course = Array(temp_country_Deaths[r".20"])
      temp_country_Recovered_time_course = Array(temp_country_Recovered[r".20"])
      return
end

example_country = "Germany"
get_time_course_for_country(example_country)
scatter(temp_country_Confirmed_time_course[:])
scatter!(temp_country_Deaths_time_course[:])
scatter!(temp_country_Recovered_time_course[:])

time_cols = names(df_Deaths)[5:end]


length(temp_country_Confirmed_time_course)
