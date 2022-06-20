
-- Select data that we need to start
Select location, date, total_cases, new_cases, total_deaths, population
From covid_deaths
Where continent is not null 
order by 1,2

-- Total cases & Total deaths
Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From SQL.dbo.covid_deaths
Where continent is not null 
order by 1,2

--Global Total cases & Totall deaths
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From SQL.dbo.covid_deaths
where continent is not null 
order by 1,2
 --By 17/6/2022, 53,7342,574 cases were recorded and the number of deaths rose to 6,275,732 people. The number of deaths accounted for 1.16%. 

--Cases & population
-- Shows what percentage of population infected with Covid
Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From SQL.dbo.covid_deaths
order by 1,2

-- Countries with highest infection rate compared to Population
Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From SQL.dbo.covid_deaths
--Where location like '%vietnam%'
Group by Location, Population
order by PercentPopulationInfected desc
--Faeroe Islands was the country that had the highest infected cases per population 

--Deaths & Population
-- Showing contintents with the highest death count per Population
Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From SQL.dbo.covid_deaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc
--The North America was the continent that has highest number of deaths while Oceania was opposite

-- Countries with highest death count per Population
Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From SQL.dbo.covid_deaths
--Where location like '%vietnam%'
Where continent is not null 
Group by Location
order by TotalDeathCount desc
--United States was the country that recorded the highest number of deaths

-- Population vs Vaccinations
-- Shows Percentage of Population that has recieved Covid Vaccine
Select dea.continent , dea.location, dea.date, dea.total_deaths, (dea.total_deaths/dea.population)*100 as DeathPercentage, vac.people_fully_vaccinated, (vac.people_fully_vaccinated/dea.population)*100 as PercentPopulationvaccinated
From SQL.dbo.covid_deaths dea
Join SQL.dbo.covid_vaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3
--The death rate decreases after people are vaccinated

