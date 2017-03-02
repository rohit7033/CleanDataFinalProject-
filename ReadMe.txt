This file documents the flow of the "run_analysis.R" script.

1. Download required dataset.

2. The dataset is unzipped into curent folder.

3. All the relavent data is imported into the R environment. The data includes both test and train data, their subjects and labels. It also includes features list and activity labels.

4. The data (relevant_test data, relevent_train_data) that only provides mean and standard deviation is extracted from the imported data.

5. Test and train labels (total_labels) as well as test and train subjects (total_subjects) are merged row wise.

6. The numbered labels (Y values) are matched to their respective descriptive labels for both test and train data (total_label_names).

7. Test and train data (X values) are merged along rows (total_data).

8. A character vector (label_row) containing all the variable names is created.

9. A dataset (total_dataset) with first column of subject, second column of descriptive labels and rest of the columns representing mean and std dev data is created. The column names are assigned by the character vector from (8).

10. Another tidy dataset (summarized_data) is created with mean of each subject and activity.

