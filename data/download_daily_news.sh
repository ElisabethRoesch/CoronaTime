# download current .csv of john hopkins
curl -o /Users/eroesch/github/CoronaTime/data/Confirmed.csv https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_19-covid-Confirmed.csv
curl -o /Users/eroesch/github/CoronaTime/data/Recovered.csv https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_19-covid-Recovered.csv
curl -o /Users/eroesch/github/CoronaTime/data/Deaths.csv https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_19-covid-Deaths.csv

#renameing colum names. as julia doesnt line / in column names
tr '/' '_' < /Users/eroesch/github/CoronaTime/data/Confirmed.csv > /Users/eroesch/github/CoronaTime/data/Confirmed_mod.csv
tr '/' '_' < /Users/eroesch/github/CoronaTime/data/Recovered.csv > /Users/eroesch/github/CoronaTime/data/Recovered_mod.csv
tr '/' '_' < /Users/eroesch/github/CoronaTime/data/Deaths.csv > /Users/eroesch/github/CoronaTime/data/Deaths_mod.csv
