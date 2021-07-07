Select *
From UFC; 

-- Country/Region of Title Fights 
-- Tableau 01

Select R_fighter, B_fighter, location, title_bout, winner 
From UFC
Where title_bout = 'TRUE';

Select location
From UFC;

-- Number of title fights vs non-title fights (including TUF finale) 
-- Total fights in dataset = 4954
-- Tableau 02

Select SUM(title_bout = 'TRUE') as TitleFight, SUM(title_bout = 'FALSE') as NonTitleFight
From UFC;

-- Percentage of Title Fights vs Non-Title Fights 

Select SUM(title_bout = 'TRUE')/'4954'*100 as PercentageOfTitle, SUM(title_bout = 'FALSE')/'4954'*100 as PercentageOfNonTitle
From UFC;



-- BATTLE OF STANCES > WHICH STANCE HAS THE HIGHEST WINNING PERCENTAGE? 

-- Orthodox winning percentages
-- Findings: 46% of Red winners were orthodox, 26.9% of Blue winners were orthodox

-- Tableau 04

Select winner, SUM(b_stance = 'orthodox')/'4954'*100 as PercentBlueOrthodox, SUM(r_stance = 'orthodox')/'4954'*100 as PercentRedOrthodox
From UFC
Group by winner; 

-- Southpaw winning percentages 
-- Findings: 13.7% of Red winners were southpaw, 7.5% of Blue winners were southpaw

-- Tableau 05

Select winner, SUM(b_stance = 'southpaw')/'4954'*100 as PercentBlueSouthpaw, SUM(r_stance = 'southpaw')/'4954'*100 as PercentRedSouthpaw
From UFC
Group by winner; 

-- Switch winning percentages 
-- Findings: 1.9% of Red winners switched stances, 1.8% of Blue winners switched stances

-- Tableau 06

Select winner, SUM(b_stance = 'switch')/'4954'*100 as PercentBlueSwitch, SUM(r_stance = 'switch')/'4954'*100 as PercentRedSwitch
From UFC
Group by winner; 


-- RED VS BLUE!!! 
-- Findings: 61.9% of wins are from fighters in the red corner (champions, higher ranked), 36.3% of wins are from fighters in the blue corner

-- Tableau 07

Select SUM(winner = 'Red')/'4954'*100 as RedWins, SUM(winner = 'Blue')/'4954'*100 as BlueWins
From UFC;


-- Number of Title Fights per weight class 

-- Tableau 08

Select weight_class, SUM(title_bout = 'TRUE') as TitleFight, SUM(title_bout = 'FALSE') as NonTitleFight
From UFC
Group by weight_class;







 










