select *
from CovidDeaths

select *
from CovidVacc



--peak daily deaths and daily vacs and also you search specific country you want
SELECT cd.location,cd.date,
	COALESCE (new_deaths, 0 ) as dailyDeaths,
	COALESCE(cv.new_vaccinations,0) as dailyvacs

FROM CovidDeaths cd
	left join CovidVacc cv
on cd.date = cv.date and cd.location=cv.location
WHERE cd.location ='philippines'
ORDER BY dailyDeaths desc



--Here I calculate the total deaths and total vaccinations of the each country, you can also search a specific country you want to check. And I use
--CTE so I can optimize the data and it will not take so long to execute it. Also we have the coalesce to convert the null into 0

WITH DeathsCTE AS (
    SELECT 
        location, 
        SUM(CAST(new_deaths AS FLOAT)) AS total_deaths
    FROM 
        CovidDeaths
	where location in ('Philippines', 'Indonesia')
    GROUP BY 
        location
),
VaccinationsCTE AS (
    SELECT 
        location, 
        SUM(CAST(new_vaccinations AS FLOAT)) AS total_vaccinations
    FROM 
        CovidVacc
		where location in ('Philippines', 'Indonesia')
    GROUP BY 
        location
)

SELECT 
    d.location, 
    COALESCE(d.total_deaths, 0) AS total_deaths,
    COALESCE(v.total_vaccinations, 0) AS total_vaccinations
FROM 
    DeathsCTE d
LEFT JOIN 
    VaccinationsCTE v
ON 
    d.location = v.location;