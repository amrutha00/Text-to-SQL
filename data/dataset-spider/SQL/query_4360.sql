SELECT project_details FROM Projects WHERE project_id NOT IN ( SELECT project_id FROM Project_outcomes )