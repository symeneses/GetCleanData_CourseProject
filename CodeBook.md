---
title: "CodeBook"
author: "Sandra Meneses"
date: "Saturday, February 27, 2016"
output: html_document
---

##Variable list and descriptions

Variable name    | Description
-----------------|------------
subject          | ID the subject who performed the activity.
activity         | Activity name
signal           | Signal used to estimate variables
variable         | Variable estimated from the signal (mean,std)
axis             | Axis only for 3-axial signals (X,Y,Z)
magnitud         | Value of the signals

##Preview of the tidy data

```{r}
head(dt_sub_separate)
```
```
#   subject activity   signal variable axis  Magnitud
# 1       1 STANDING tBodyAcc     mean    X 0.2885845
# 2       1 STANDING tBodyAcc     mean    X 0.2784188
# 3       1 STANDING tBodyAcc     mean    X 0.2796531
# 4       1 STANDING tBodyAcc     mean    X 0.2791739
# 5       1 STANDING tBodyAcc     mean    X 0.2766288
# 6       1 STANDING tBodyAcc     mean    X 0.2771988
```

