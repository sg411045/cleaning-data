run_analysis <- function() {
  
  ## Step 1
  ################################## 
  
  # load training data
  training_data <- load_training()
  # load the test data
  test_data <- load_test()

  # merge the data sets together
  merged_data_set <- rbind(training_data, test_data)
  
  # assign column feature names to the merged data set
  colnames(merged_data_set) <- generate_feature_names()[, 1]
  ##################################
  
  ## Step 2
  ################################## 
  # filter the merged set to only retrieve columns with mean and std deviation
  filtered_data_set <- merged_data_set[, get_tiny_dataset_columns(merged_data_set)]
  ##################################
  
  ## Step 3
  ##################################
  # Assign descriptive activity names
  filtered_data_set$activity <- with(generate_activity_names(), V2[match(filtered_data_set$activity, V1)])
  ##################################
  
  ## Step 4
  ##################################
  ## Label the data set with descriptive variable names
  variable_names <- colnames(filtered_data_set)
  colnames(filtered_data_set) <- set_descriptive_column_names(variable_names)
  
  ## Step 5
  #################################
  ## create a tiny data set with the avg of values by subject and activity
  tiny_data_set <- avg_by_subject_and_activity(filtered_data)
  
  ## write to file
  write.table(tiny_d, "tiny_data_set.txt", row.names = FALSE)
  
}

load_training <- function() {
  # Load the training  data set
  X_train <- read.table("train\\X_train.txt", 
                        header = FALSE, 
                        sep ="", 
                        comment.char = "", 
                        strip.white = TRUE, 
                        stringsAsFactors = FALSE, 
                        skipNul = TRUE, 
                        dec = ".", 
                        check.names = FALSE)

  
  # Load the training  data set
  y_train <- read.table("train\\y_train.txt", 
                        header = FALSE, 
                        sep ="", 
                        comment.char = "", 
                        strip.white = TRUE, 
                        stringsAsFactors = FALSE, 
                        skipNul = TRUE, 
                        dec = ".", 
                        check.names = FALSE)
  
  # Load the train subjects
  subject_train <- read.table("train\\subject_train.txt", 
                              header = FALSE, 
                              sep ="", 
                              comment.char = "", 
                              strip.white = TRUE, 
                              stringsAsFactors = FALSE, 
                              skipNul = TRUE, 
                              dec = ".", 
                              check.names = FALSE)
  
  cbind(subject_train, y_train, X_train)
}

load_test <- function() {
  # Load the testing  data set
  X_test <- read.table("test\\X_test.txt", 
                        header = FALSE, 
                        sep ="", 
                        comment.char = "", 
                        strip.white = TRUE, 
                        stringsAsFactors = FALSE, 
                        skipNul = TRUE, 
                        dec = ".", 
                        check.names = FALSE)
  
  
  # Load the testing  data set
  y_test <- read.table("test\\y_test.txt", 
                        header = FALSE, 
                        sep ="", 
                        comment.char = "", 
                        strip.white = TRUE, 
                        stringsAsFactors = FALSE, 
                        skipNul = TRUE, 
                        dec = ".", 
                        check.names = FALSE)
  
  subject_test <- read.table("test\\subject_test.txt", 
                             header = FALSE, 
                             sep ="", 
                             comment.char = "", 
                             strip.white = TRUE, 
                             stringsAsFactors = FALSE, 
                             skipNul = TRUE, 
                             dec = ".", 
                             check.names = FALSE)
  
  cbind(subject_test, y_test, X_test)
}

generate_feature_names <- function() {
  
  # load the features
  features <- read.table("features.txt", sep = "", stringsAsFactors = FALSE, check.names = FALSE)
  features$V1 <- NULL
  
  # add the feature names for subject and activity
  features <- rbind("subject", "activity", features)
}

get_tiny_dataset_columns <- function(data_set) {
  # pick only columns with mean and std in the name
  # also pick the first 2 columns which indicate the subject and the class
  
  # columns with mean values
  mean_idx <- grep("mean", names(data_set))
  
  # columns with std deviation values
  std_idx <- grep("std", names(data_set))
  
  # merge the sets and order
  tiny_idx <- sort(c(1,2, mean_idx, std_idx))
}


generate_activity_names <- function() {
  # load the activity labels
  activities <- read.table("activity_labels.txt", sep = "", stringsAsFactors = FALSE, check.names = FALSE)
  
}

set_descriptive_column_names <- function(X) {
  
  X <- gsub('([[:upper:]])', ' \\1', X)
  X <- gsub("\\()-" , "\\ " , X)
  X <- gsub("\\()" , "\\" , X)
  X <- gsub("-" , " " , X)
  X <- gsub("t " , "Time " , X)
  X <- gsub("f " , "Freq " , X)
  
}

avg_by_subject_and_activity <- function(filtered_data) {
  avg_by_subject_and_activity <- filtered_data %>% group_by(subject, activity) %>% summarise_all(funs(mean))
}