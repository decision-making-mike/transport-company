# Transport company

[ongoing-todos.txt](ongoing-todos.txt)

[ongoing-reads.txt](ongoing-reads.txt)

[completed-todos.txt](completed-todos.txt)

[completed-reads.txt](completed-reads.txt)

## Update 6. The scripts `database/create-tables.sql` and `database/insert-data.sql`.

In this update I'm publishing the scripts `database/create-tables.sql` and `database/insert-data.sql`. They are simplified versions of the scripts with the same names that I have created back when this project still was a subproject.

The script `database/insert-data.sql` is worth a word. Currently, on my machine, it generates and inserts 10 thousand rows into a 1-column table in about 0.55 s. For 100 thousand rows the time grows to 4 s, and for the desired 1 million rows to 40 s. Given I expect to perform the generation and insertion multiple times during debugging, I have fallen back to 10 thousand rows for now. My conclusion is, these times are not acceptable, especially given there will be more tables than this one to prepare and insert data into. I'm going to look for optimization.

## Update 5. The entity-relationship model of the company.

In this update I'm publishing the entity-relationship model of the company. On a side note, I now think that it should have been published before the `database/reset-database.bash` script. This model doesn't expect the database to exist, while the `database/reset-database.bash` script is a helper script for creating the database.

[The article about "entity-relationship model" on Wikipedia](https://en.m.wikipedia.org/wiki/Entity%E2%80%93relationship_model) lists 3 levels of such models, namely conceptual, logical and physical. I'm not familiar with data modeling, and this model is simple, so I've decided to not categorize it anyhow, and just name it an "entity-relationship model". If I had to categorize, I'd say it's a logical ER model that doesn't want to abandon the simplicity of a conceptual ER model. Should I need to create additional ER models in the future, I shall distinguish them by their names from this one. I don't know if I will change then the name of this model, though.

The model is a simplified version of the model that was represented by the `create table` statements I've published back when this project still was a subproject. You can review them at https://github.com/decision-making-mike/sql-postgresql-learning/blob/main/archive/transport-company/database/create-tables.sql. Only as soon as the need arises, I'm going to make it more sophisticated. By the by, I like how simple it currently looks.

## Update 4. The `database/reset-database.bash` script.

In this update I'm starting to publish files related to the database. The file `database/reset-database.bash` will be the first.

This script I've created back when this project still was a subproject. You can see the previous version at https://github.com/decision-making-mike/sql-postgresql-learning/blob/main/archive/transport-company/database/reset-database.sh. I'm going to discuss all the changes one by one.

One, I've changed the extension of the file from `sh` to `bash`. This is consistent with the practice I introduced in update 1.

Two, I've changed the `#!/usr/bin/bash` shebang to `#!/bin/bash`. First, I don't know if there is any difference between them from the point of view of an average Linux distribution. Here I mean only a theoretical difference as I don't assume the script to be run by anyone other than me. Also, I don't make my GitHub scripts executable, so, at least I guess so, there is no need for the shebang anyway if I'm about to run the script.

Second, there is a difference between them from my point of view. `/bin/bash` is shorter and more ituitive for me, thus easier to conceptualize, remember and type. As a side note, this difference has led me to plan to use this shorter shebang in all the scripts in my GitHub projects from now on (at least to the extent I'm going to remember this decision in case of any future GitHub projects). If anyone has any insights on which shebang could I prefer to use, please make an issue, I'd be glad to know.

Three, I've put single quotes (`'`) around more strings, the main ones being the file names `create-tables.sql` and `insert-data.sql`. Now the script is consistent with my belief that it is a good practice to use single quotes in Bash wherever it doesn't do any harm to the code. For instance, theoretically one could place command names inside single quotes, but I am not sure if this wouldn't harm readability of the code. I am open to consideration here.

Four, I've lowercased all the variable names. In that I am consistent with my current practice of making lowercase the names of all the variables I create (but I don't exclude a possibility that there is a language out there not allowing creation of lowercase variable names). As the main benefit of the practice I find no need to decide on a script-by-script basis. This saves energy both for the lack of decision, and for not keeping in mind why I have made some names lowercase, and some uppercase.

Five, in case of the `echo` commands, I've moved the redirections `1>&2` right after the names of the commands. I think the redirections are now more evident. But I am open to consideration where they should go in a command in the general case.

Six, I'm now checking for the error of the last command in the same pipeline. That is, instead of using `$?`, and doing

```bash
<some command>

if [[ $? != 0 ]]
then
    echo "Database creation error" 1>&2
    exit 1
fi
```

as it was before, now I use `||`, and do

```bash
<some command> || {
    echo 1>&2 "Error when dropping or creating the database, exiting"
    exit 1
}
```

effectively having gotten rid of using the `$?` variable in the script. I now think this was unnecessary. But as reverting the change could be only done manually now, that is, with no help of Git, I'm not going to change it.

Seven, I've introduced the `time` command. This command will let us compare the times of data preparation (and incidentally of insertion, since they are to be bundled). I guess the time of data preparation is worth to keep an eye on for three complementing reasons. First, I assume `reset-database.bash` to run as quick as not to dishearten the person that has run it, given a machine performing similarly to mine. Second, I plan that the script load all the data I plan for the database to hold. Third, I aim for 1 million rows at least in some of the tables. I say "at least in some" because the number of rows in some tables might depend on other tables. I haven't analyzed it yet. Lastly, worth to mention that in case the times won't be satisfying, I don't plan to do any aggresive optimization. This would use my energy for things I don't feel I need. I'd rather lower either the bar of performance, or of numbers of rows, and keep the whole project move on.

## Update 3. Graph visualization update.

Firstly, I've moved the `visualize-graphs.bash` and its corresponding `split-labels-contents.awk` scripts from the `business` directory to the main directory of the repository. The reason was to have their location reflect that now they are to visualize DOT graphs in the whole repository instead of only in the `business` directory. Although currently any DOT graphs are only in the `business` directory, I plan to have more of them elsewhere, too.

Secondly, in the `visualize-graphs.bash` script, I've removed the "main" `sed` command and the corresponding `sed_commands` variable. The reason was there was no DOT graph with labels that the commands could be use on. Also, the script is now simpler. However, I haven't removed the comments within the `business/goals.dot` file that are relevant to the `sed` commands, that is, `// [label="responsibility=top management"]`, and the like. I still believe that the information about "responsibilities" that they contain may have its uses in the future, when the graph will grow.

Thirdly, also in the `visualize-graphs.bash` script, I've removed the command `eog --fullscreen ./` and added a pipeline utilizing `find`, `grep`, `xargs` and `eog`. The reason was to allow displaying the generated images in the whole repository, that is, recursively, instead of just in the main directory of it. One may note I use the `--print0`, `--null-data`, and `--null` options. The reason is that the pipeline run in more cases without errors related to unusual file names than it would without those options.

## Update 2. Update of the goals of the company.

I've updated the goals of the company. First, I've added information about hiring employees. Then, I've restructured and updated goals related to storing shipments and deliveries. Here, notably, I've introduced the notion of the route of a parcel. Before the introduction only vehicles could have routes. Lastly, I've removed the notion of addresses, and clarified the formulation of some goals.

# Update 1

This is my first update in this "transport company" project. The project is a spin-off of my "SQL and PostgreSQL learning" project (also available on GitHub at https://github.com/decision-making-mike/sql-postgresql-learning). You can find more details about the spin-off itself there, in update 50.

The goals of this new project are to showcase and to develop my business analysis and databases skills. I hope that the separation of it will let me present the skills more clearly than if it still was a part of the "SQL and PostgreSQL learning" project.

This README shall serve as a blog, similarly to the README of the source project. But differently to there, here I decided not to emphasize this fact, thus not give the blog a separate URL address. For the record, the README is available either at https://github.com/decision-making-mike/transport-company/blob/main/README.md or https://github.com/decision-making-mike/transport-company.

In this initial commit I'm including two files that have been created in, and committed to the source project. They are `business/archive/stakeholders.odg` and `business/stakeholders.jpg`. Information about them, if any, can be found in the README of the source project. Markworthy I don't include yet any of the database-related files I have created so far. I'll do this in one of the next updates, when I'll make sure they are up-to-date.

I'm also including new files. They are `business/goals.dot` and the related `business/archive/goals-2025-02-13.dot.png`, `business/visualize-graphs.bash`, and `business/split-labels-contents.awk`.

`business/goals.dot` is the result of my thoughts about the model of the business of the company. It contains the goals of the company. You can think about it as a "goal model" of it. "How do you define a goal?", you can ask. I believe a good basis for the definition is the common, intuitive understanding of a business goal. This understanding is clearly visible in the case of "strategic goals", e.g. the goal "to be profitable". Then, the less strategic, and the more operational the goal is, the less it resembles a business goal, and the more a kind of "requirement".

I don't think the goal model is complete, but satisfies me enough to publish it. (I keep in mind that I'm rushed by the primary reason I am on GitHub whatsoever, that is, to get a job. The more agile I develop my portfolio, the better.)

The goal model is written in the DOT language, that is, in plain text. To make it better advertise the project, I should present it in a visual form. So I'm including the file `business/archive/goals-2025-02-13.dot.png`, and I've embedded in this README below. It is archived from the start, and has been given a date because it visualizes only the current state of the DOT file. The goal model, thus the DOT file, is going to be updated.

![the goals of the company](business/archive/goals-2025-02-13.dot.png)

It can be seen that I visually grouped, thus emphasized two kinds of goals. One, "strategic goals", and two, "information storage" goals. The emphasis of the "strategic goals" should correspond to the fact they are the foundation for all the business models, as I've described in the README of the source project. The emphasis of the "information storage" goals should reflect the fact that the main goal of the project, as I currently see it, is to have created a database.

The `business/visualize-graphs.bash` script serves two purposes now, and I see two more uses of it in the future. One, it inserts newlines in appropriate places within the contents of the labels in said DOT file. This way I can write the contents without embedding the sequence `\n` by hand. I can then focus more on the semantics, and less on the presentation. Two, the script displays the PNG file. I am then freed from typing the command to display it. As for future uses of the script, it, three, could translate my custom "presentation statements", embedded within the contents of the labels in the DOT file. The reader can see them in the DOT file. They are now commented out as I'm not sure whether they serve any purpose. Four, the script could convert multiple DOT files at once. There is now only one, but I plan to include more.

Should it be worth noting, the script's extension is `bash`. I tend to give my scripts the `sh` extension, but now I thought to try something different. I think `bash` suits since the script is written in Bash, and additionally the shebang is `#!/bin/bash`. I don't know how many scripts out there have the `bash` extension. I may change it if I discover someday it doesn't have its uses.

The `business/split-labels-contents.awk` script performs the actual insertion of newlines that I've mentioned above. Remarkably, as far as I remember, it is my first AWK script of more than one line, if not the first ever. Specifically for that reason it may contain bugs. If the reader will find a bug, I'd be glad to be told about it in an issue.
