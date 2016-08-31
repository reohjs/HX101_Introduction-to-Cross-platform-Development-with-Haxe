# Development Guide

The course is built using a combination of Git, GitLab, GitBook, and YouTube.
The course website and most textual materials are written in Markdown, turned into HTML using GitBook.

The development repository is located at https://gitlab.com/HaxeFoundation/HX101_Introduction-to-Cross-platform-Developemnt-with-Haxe.
It is a private repository. If you're interested in contributing to the course, contact Andy (andy@onthewings.net).

## Student Sign Up

A student sign up for the course via the course web site by logging into GitLab.
After receiving the student's GitLab ID, the web server will:

 1. Use the GitLab API to fork the development repository using a Haxe course bot account. The forked student repository will be privately hosted in the GitLab group, https://gitlab.com/groups/HaxeFoundation_HX101_2016T1. It has to be private since the student will commit quiz answers and coding exercises into the repository.

 2. Remove all branches except for the `master` branch in order to prevent leaking quiz answers and coding exercise test cases.

 3. Commit a file that contains student's info.

 4. Make a merge request to the `submission` branch in the development repository.

 5. Add the user as a member to the forked student repository.

 6. Display a page of welcoming new student.

After the sign up procedure, the student gain access to the course material in the course web site.
She can start learning from section 1.

## Graded Assignments

At the end of section 1, the graded assignments of this course will be explained.
Instruction will be given to the student to set up git and clone the repository to its computer.
The repository contains quiz and coding exercises that student has to complete by committing the answers using git.
To submit the completed assignments, the student pushes to her student repository,
which will trigger a CI build of the merge request set up in the student sign up stage.

The CI build will perform a number of things in separated stages (builds):

 1. Check that the CI configuration is unmodified. Theoretically, any modification to the CI configuration will result in a merge conflict, but we will double check it is unmodified.

 2. Merge the `answers` branch, which contains quiz answers. Grade the quiz, and store the grading result as build artifacts. The answers are not possible to be displayed by the student since no student code is executed at this stage. The answers will not be carried over to the next stage.

 3. Merge the `test` branch, which contains the coding exercise test cases. Grade the coding exercises by running the test cases, and store the grading result as build artifacts. The test cases may be leaked to the student, but we will display test failure details anyway so that's fine. Just make sure it is not possible for the student to change the test cases.

 4. Calculate the final grade, and store the grading result as build artifacts.

