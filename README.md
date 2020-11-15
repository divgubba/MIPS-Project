# MIPS-Project
Trivia game program written in MIPS assembly language

Trivia game has five topics: 
  Movie/Tv, General Knowledge, Pop Culture, Current Events, Music 2018/2017
These will be displayed in menu to user and allow user to view the topic for their question
The topics are randomly generated for the user so the user can press '0' to switch to a different topic or to continue with the topic, press any number other than '0'

For each question displayed, user has ability to end the game with '0' or continue playing with any number other than '0'

The trivia questions will be displayed along with the three answer choices which have corresponding numbers (1,2,3)
The user should enter ‘1’, ‘2’, or ‘3’ to match the answer choices

The user will start out with 4 saves or lives
For each question the user answers correctly, they will be awarded 10 points
If the user runs out of lives and does not have atleast 30 points or more, the trivia game will end

Important Note :
When entering your answer in the trivia game, do not hit "enter" or "return" or the program will crash

# Motivation
This project was created for my computer architecture class
The goal was to create some type of creative program using MIPS assembly language

# Tech used
MIPS assembly language
MARS IDE

# Features
The program reads in different files based on the topics for the trivia game
The trivia game topic files contain the question followed by the three answer choices followed by the number of the correct answer choice

