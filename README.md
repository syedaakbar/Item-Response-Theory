# Item-Response-Theory

Item Response Theory(IRT) is a great example of the classification problem of Machine Learning. With IRT, we use a training set, which we call a calibration sample. We use it to train some models, which are then used to make decisions in future observations, primarily scoring examinees that take the test by predicting where those examinees would fall in the score distribution of the calibration sample. IRT is also applied to solve more sophisticated algorithmic problems: Computerized adaptive testing and automated test assembly are fantastic examples. We IRT more generally to learn from the data; which items are most effective, which are not, the ability range where the test provides most precision, etc.

What differs from the Classification problem is that we don’t have a “true state” of labels for our training set. That is, we don’t know what the true scores are of the examinees, or if they are truly a “pass” or a “fail” – especially because those terms can be somewhat arbitrary. It is for this reason we rely on a well-defined model with theoretical reasons for it fitting our data, rather than just letting a machine learning toolkit analyze it with any model it feels like.

In this repository you will find all the scripts, input and output datasets, reliability measures, item fits and graphs for calculating and analyzing the student response data. 
