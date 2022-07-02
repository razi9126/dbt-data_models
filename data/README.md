
### Razi Ul Haq
### Github repo: https://github.com/razi9126/dbt-data_models/tree/main

Hey everyone,
I’m more comfortable with Word so using this instead of the markdown document.
Firstly, sorry if my answers seem too to the point, I have no context of the game and have never played it from where I come from.  Secondly, for part2, I could have used simple if statements for every model, but I chose to do all this through macros and Jinja to make the code reuseable and demonstrate my knowledge.
I used Standard SQL on BigQuery for this case study

### 1
For this I used Python code(located in `/scripts`) to simply output each sheet as individual csv to the data folder. From there `dbt seed` command was used to import this data into BigQuery. This data was imported into `models_source` dataset.

### 2
For this part I used pure jinja + macro combo to write reuseable code. The function just takes in the name of the table to `ref` to. It extracts all columns using `dbt.utils`, then writes Jinja code that checks it againsta all possible options for the column and assigns the required name. Simpler solutions do exist, I just went a bit overboard after reading that we could go wild with this 😂. Output for this part was written to `models_standardized`(schema name) dataset.

### 3
This part basically wanted us to build the core tables that can be then used to make team/task specific datasets. I tried to normalize the tables as far as I could. However, I feel like I am missing some context about the game so I could have deviated somewhere.  Output for this part was written to `models_main`(schema name) dataset.

### 4
This part again required some Jinja finesse. Specially for part(d) I calculated all occurences of all possible behaviors, aggregated those each month wise. A simple sum across each column would enable us to get answers for parts (c) and (d). For part (a) and (b) I created the `sighting_properties_monthwise` table that has the required columns(and a few more) to enable us to calculate everything we are looking for by just using `SUM()` and `FILTER`. I believe this is the main purpose of an analytics engineer that they enable business people to find answers to their questions by just these 2 functions that can easily be performed on even Excel.

![Alt text](/image/lineage.png "Lineage")


