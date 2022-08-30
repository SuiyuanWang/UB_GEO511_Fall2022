# Tasks

# Create a new R script in RStudio (File->New File->R Script)

# Save this file somewhere you will find it later

# In your new script, load the iris dataset with data(iris)
data(iris)

# Read the help file for the function that calculates the mean (you can run ?mean or use the GUI).
?mean

# Calculate the mean of the Petal.Length field and save it as an object named petal_length_mean
petal_length_mean <- mean(iris[['Petal.Length']])

# Plot the distribution of the Petal.Length column as a histogram (?hist)
?hist
hist(iris[['Petal.Length']],  main = paste("Histogram of Patal length"), xlab = "Patal length",  ylim = range(0, 50), labels = TRUE)

# Save the script
# Click ‘Source’ in RStudio to run your script from beginning to end




