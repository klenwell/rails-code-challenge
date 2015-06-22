# Challenge for Software Engineer
To better assess a candidates development skills, we would like to provide the following challenge. Use your own judgment on deciding how long to spend on this. We want you to feel comfortable and not rushed without feeling obligated to burn a lot of your personal time on it. Feel free to add comments in the README for things you would do given more time.

If you are applying for a software engineer position, the email address you should use for submission is [dev.challenges@livingsocial.com](mailto:dev.challenges@livingsocial.com).  Please use either Ruby or Clojure.

Feel free to email the appropriate address above if you have any questions.

## Submission Instructions
1. First, fork this project on github.  You will need to create an account if you don't already have one.
2. Next, complete the project as described below within your fork.
3. Finally, push all of your changes to your fork on github and submit a pull request.  You should also email the appropriate address listed in the first section and your recruiter to let them know you have submitted a solution.  Make sure to include your github username in your email (so we can match people with pull requests).

## Alternate Submission Instructions (if you don't want to publicize completing the challenge)
1. Clone the repository
2. Next, complete your project as described below within your local repository
3. Email a patch file to the appropriate address listed above: [dev.challenges@livingsocial.com](dev.challenges@livingsocial.com)

## Project Description
Imagine that LivingSocial has just acquired a new company.  Unfortunately, the company has never stored their data in a database and instead uses a plain text file.  We need to create a way for the new subsidiary to import their data into a database.

Here's what your web-based application must do:

1. Your app must accept (via a form) a tab delimited file with the following columns: purchaser name, item description, item price, purchase count, merchant address, and merchant name.  You can assume the columns will always be in that order, that there will always be data in each column, and that there will always be a header line.  An example input file named example_input.tab is included in this repo.
2. Your app must parse the given file, normalize the data, and store the information in a relational database.
3. After upload, your application should display the total amount gross revenue represented by the uploaded file.

Your application does not need to:

1. handle authentication or authorization (bonus points if it does, extra bonus points if authentication is via OpenID)
2. be aesthetically pleasing

Your application should be easy to set up and should run on either Linux or Mac OS X.  It should not require any for-pay software.

## Evaluation
Evaluation of your submission will be based on the following criteria. Additionally, reviewers will attempt to assess your familiarity with standard libraries. If your code submission is in Ruby, reviewers will attempt to assess your experience with object-oriented programming based on how you've structured your submission.

1. Did your application fulfill the basic requirements?
2. Did you document the method for setting up and running your application?
3. Did you follow the instructions for submission?
4. Did you consider what changes would need to be made for a true production-ready solution? You can include your thoughts in the README.
