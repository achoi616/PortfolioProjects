Select *
From coviddeathsdata
Where continent is not null
order by 3,4; 

Select location, date, total_cases, new_cases, total_deaths, population
From coviddeathsdata
Where continent is not null
order by 1,2; 

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract Covid in the United States  

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From coviddeathsdata
Where location like '%states%'
and continent is not null
order by 1,2;

-- Total Cases vs Population
-- Shows what percentage of population infected with Covid 

Select location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
From coviddeathsdata
Where location like '%states%'
order by 1,2;

-- Countries with Highest Infection Rate compared to population

Select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From coviddeathsdata
Group by location, population
Order by PercentPopulationInfected desc; 

-- Countries with Highest Death Count per population

Select location, MAX(cast(total_deaths as char)) as TotalDeathCount
From coviddeathsdata
Where continent is not null
Group by location
Order by TotalDeathCount desc;

-- BREAKING THINGS DOWN BY CONTINENT

-- Showing continents with the highest death count per population

Select location, MAX(cast(total_deaths as char)) as TotalDeathCount
From coviddeathsdata
Where continent is not null
Group by location 
Order by TotalDeathCount desc;

-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as char)) as total_deaths, SUM(cast(new_deaths as char))/SUM(new_cases)*100 as DeathPercentage
From coviddeathsdata
Where continent is not null
Order by 1,2;

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has received at least one Covid Vaccination

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as char)) OVER (Partition by dea.location, dea.date) as RollingPeopleVaccinated    
From coviddeathsdata dea 
Join covidvaccinationsdata vac
	On dea.location = vac.location 
    and dea.date = vac.date
Where dea.continent is not null
Order by 2,3; 

-- Using CTE to perfrom Calculations on Partition By in previous query  

With PopvsVac (continent, location, date, population, New_Vaccinations, RollingPeopleVaccinated)
as
( 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as char)) OVER (Partition by dea.location, dea.date) as RollingPeopleVaccinated    
From coviddeathsdata dea 
Join covidvaccinationsdata vac
	On dea.location = vac.location 
    and dea.date = vac.date
Where dea.continent is not null
-- Order by 2,3; 
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac;

-- Temp Table 

DROP Table if exists PercentPopulationVaccinated;
Create Table PercentPopulationVaccinated
(
Continent char(255), 
Location char(255), 
Date datetime,   
Population numeric, 
New_Vaccinations char,  
RollingPeopleVaccinated numeric 
);


Insert into PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as char)) OVER (Partition by dea.location, dea.date) as RollingPeopleVaccinated    
From coviddeathsdata dea 
Join covidvaccinationsdata vac
	On dea.location = vac.location 
    and dea.date = vac.date;
-- Where dea.continent is not null
-- Order by 2,3 

Select *, (RollingPeopleVaccinated/Population)*100
From PercentPopulationVaccinated;

-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as char)) OVER (Partition by dea.location, dea.date) as RollingPeopleVaccinated    
From coviddeathsdata dea 
Join covidvaccinationsdata vac
	On dea.location = vac.location 
    and dea.date = vac.date
Where dea.continent is not null;






 




