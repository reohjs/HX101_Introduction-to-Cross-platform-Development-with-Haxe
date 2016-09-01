# Development Info

The course is built using a combination of Git, GitLab, GitBook, and YouTube.
The course website and most textual materials are written in Markdown, turned into HTML using GitBook.

The development repository is located at https://gitlab.com/HaxeFoundation/HX101_Introduction-to-Cross-platform-Developemnt-with-Haxe.
It is a private repository. If you're interested in contributing to the course, contact Andy (andy@onthewings.net).

## Platform Choice

Before settling on hacking GitLab and GitBook for building online courses, we've looked into several alternative platforms:

 * [Open edX](https://open.edx.org/) is initially what I planned to use. It is the software behind the popular MOOC web site [edX](https://www.edx.org/). Sadly, its code base is quite complicated and hard to deploy. We cannot find a free hosted Open edX provider either.

 * [Udemy](https://www.udemy.com/) is an online learning marketplace. It let users to create courses on their web site, and it handles all the hosting, registration, and stuff. However, it does not support the selling strategy we would like to use - offer courses for free and sell optional completion certificates.

 * [Moodle](https://moodle.org/) is an open source software that can run online courses. It is again quite a complex platform, so it would take some effort to customize for our need. It is easier to set up than Open edX though.

 * [Coursera](https://www.coursera.org/) and [Udacity](https://www.udacity.com/) are two popular MOOC web sites beside edX. They only allow their partner institutions and organizations to create courses on their platforms. We're probably still too small to join them, but hopefully we will be able to offer courses there in the future ;)

The best thing about using GitLab and GitBook is that we can use the familiar git workflow and automatically obtain content modification history, team management, coding exercise grading etc. Students can also get an off-line copy of the whole course by cloning their student repository.

## Student Sign Up

A student sign up for the course via the course web site by logging into GitLab.
After receiving the student's GitLab ID, the web server will:

 1. Use the GitLab API to fork the development repository using a Haxe course bot account. The forked student repository will be privately hosted in the GitLab group, https://gitlab.com/groups/HaxeFoundation_HX101_2016T1. It has to be private since the student will commit quiz answers and coding exercises into the repository.

 2. Set the `student` branch as main branch and remove all other branches in order to prevent leaking quiz answers and coding exercise test cases.

 3. Commit a file that contains student's registration info, including name and email. They will be used for contact and generating certificates. Since both the development and student repositories are private, only the student and the teaching team will have access to the info.

 4. Make a merge request to the `submission` branch in the development repository.

 5. Add the student as a member to the forked student repository.

 6. Display a page of welcoming new student.

After signing up, the student will gain access to the course material in the course web site.
She can start learning from section 1.

## Graded Assignments

At the end of section 1, the graded assignments of this course will be explained.
Instruction will be given to the student to set up git and clone the repository to its computer.
The repository contains quiz and coding exercises that student has to complete by committing the answers using git.
To submit the completed assignments, the student pushes to her student repository,
which will trigger a CI build of the merge request set up in the student sign up stage.

The CI build will perform a number of things in separated stages (builds):

 1. Check that the CI configuration, `.gitlab-ci.yml`, is unmodified. Theoretically, adding a custom CI configuration will result in a merge conflict, but we will double check it is unmodified.

 2. Merge the `answers` branch, which contains quiz answers. Grade the quiz, and store the grading result as build artifacts. The answers are not possible to be displayed by the student since no student code is executed at this stage. The answers will not be carried over to the next stage.

 3. Compile the coding exercise. Save the compilation output as build artifacts. It is in a separated stage to make sure no macro can do funny things in the actual test stage.

 4. Merge the `tests` branch, which contains the coding exercise test runner. Compile the test runner, and use it to grade the coding exercises. Store the grading result as build artifacts. The test cases may be leaked to the student, but we will display test failure details anyway so that's fine. We make sure it is not possible for the student to change the test cases by compiling the test runner before running the student's code.

 5. Calculate the final grade, and store the grading result as build artifacts. The calculation should make sure individual grades are valid, e.g. Total number of questions in a quiz is correct. Earned points is less than or equals to maximum points.

## Publishing Contents

Contents of each section is prepared in separated sub-folders in the `content` directory,
committed in the `master` branch of the development repository.

To publish a section, push the relevant section contents to each of `student`, `submission`, `answers`, and `tests` branches.
A command line tool will be developed to smooth the process.

Contents of each branches:

 * `student` branch: Detached from `master` branch. Contains handouts, reading materials, quiz questions, and coding exercise instruction with templates. **No** `.gitlab-ci.yml` file.

 * `submission` branch: Branched from `student`. Additionally contains `.gitlab-ci.yml` and CI related files.

 * `answers` branch: Branched from `submission`. Additionally contains quiz answers.

 * `tests` branch: Branched from `submission`. Additionally contains coding exercise test runner.
