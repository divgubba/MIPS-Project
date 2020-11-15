#------------------------------------------------------------------------------------------------#
#					Trivia Game - Dsg170130
#------------------------------------------------------------------------------------------------#
.data
# Files needed to be open and buffers used 
fMenu: .asciiz "MenuChoices.txt"
buffMenu: .space 500

fMovie: .asciiz "MovietvQs.txt"
BuffMovie: .space 6000

fGenKnowl: .asciiz "GenKnowlQ&A.txt"
buffGenKnowl: .space 3000

fPopCult: .asciiz "PopCultQ&A.txt"
buffPopCult: .space 3000

fCrrntEvent: .asciiz "CrrntEventQ&A.txt"
buffCrrntEvent: .space 3000

fMusic: .asciiz "MusicQ&A.txt"
buffMusic: .space 3000

# Messages displayed to player
QPlayGame: .asciiz "\nWould you like to play the trivia game? (press '0' for yes, or any other number for no)\n" 
endGame: .asciiz "\nYou chose to end trivia game"
randTopicMessage: .asciiz "\nYour randomly chosen topic is: "
QUseSave: .asciiz "\nTo use a save, enter '0', or another number if you choose to end game: "
msgSavesLeft: .asciiz "\n** Saves Left: "
crrctMsg: .asciiz "\nYou got it right!"
wrongMsg: .asciiz "\nSorry! Wrong answer"
buySaveMsg: .asciiz "\n You can buy a save! Save automatically added!"
# Messages displayed if trouble opening file
openErrorMsg: .asciiz "Error in opening file"
readErrorMsg: .asciiz "Error in reading file"

# Messages displayed to user for topic 
message1: .asciiz "Movies/Tv shows"
message2: .asciiz "General Knowledge"
message3: .asciiz "Pop Culture"
message4: .asciiz "Current Events"
message5: .asciiz "Music 2018/2017"
backMessage: .asciiz "\nBack to main"
QdifferTopic2: .asciiz "\npress '0' to choose a different topic or any other number to continue playing\n"

# Variables to display at end of game
strNumCorrect: .word 0	# a counter initialized to 0
strNumPoints: .word 0	# a counter initialized to 0 
strNumSaves: .word 0 # a counter initialized to 0

# Variables to be set 
intCounterf1: .word 0
intCounterf2: .word 0
intCounterf3: .word 0
intCounterf4: .word 0
intCounterf5: .word 0

# newline char to be compared with to find end of line
newLineChar: .byte '\n'

# Buffers to hold question and answer choices from each of five files and  used to display to user
strFileQuestf1: .space 1000	# a 1000 bytes buffer
strFileQuestf2: .space 1000	# a 1000 bytes buffer
strFileQuestf3: .space 1000	# a 1000 bytes buffer
strFileQuestf4: .space 1000	# a 1000 bytes buffer
strFileQuestf5: .space 1000	# a 1000 bytes buffer

# Buffer to hold correct answer to be used for comparison
strCrrctAns: .byte ' '		# a 2 bytes buffer

# Messages for end of program
savesLeftMsg: .asciiz "\nYou have these many saves left: "
endNumCorrectMsg: .asciiz "\nNumber of trivia question you correctly answered: "
endPointsMsg: .asciiz "\nPoints you earned: "
endGameMsg: .asciiz "\n--- END OF TRIVIA GAME ---"

.text
############# Counter for right answers, points, and saves ##############
	# counter for right answers for whole game
	addi $s3, $zero, 0
	# counter for points for whole game (10 per right answer)
	addi $s4, $zero, 0
	# counter for saves for whole game , starts out with 4 saves
	addi $s5, $zero, 4
#-----------------------------------------------------------------------------------------------#
#				Open All Files and Store Buffers	
#-----------------------------------------------------------------------------------------------#
############# Open file for Movies/Tv and STORE BUFFER all at once and close ##############
	# open corresponding file
	li $v0, 13			# open_file syscall code is 13
	la $a0, fMovie			# getting file name
	li $a1, 0			# file flag = read (0)
	syscall 
	bltz $v0, openError
	move $s6, $v0			# save file descriptor, $s0 is for file	
	
	# read in and display question from fMovie
	li $v0, 14			# read_file syscall code is 14
	move $a0, $s6			# the file descriptor to identify file being read
	# load address of corresponding buffer
	la $a1, BuffMovie	 	# buffer that holds string of whole file
	la $a2, 6000
	syscall
	bltz $v0, readError	
	
	# close file
	li $v0, 16
	move $a0, $s6
	syscall
	
############# Open file for Pop Culture and STORE BUFFER all at once and close ##############
	# open corresponding file
	li $v0, 13			# open_file syscall code is 13
	la $a0, fPopCult		# getting file name
	li $a1, 0			# file flag = read (0)
	syscall 
	bltz $v0, openError
	move $s6, $v0			# save file descriptor, $s0 is for file	
	
	# read in and display question from fPopCult
	li $v0, 14			# read_file syscall code is 14
	move $a0, $s6			# the file descriptor to identify file being read
	# load address of corresponding buffer
	la $a1, buffPopCult	 	# buffer that holds string of whole file
	la $a2, 3000
	syscall
	bltz $v0, readError	
	
	# close file
	li $v0, 16
	move $a0, $s6
	syscall
	
############# Open file for General Knowledge and STORE BUFFER all at once and close ##############
	# open corresponding file
	li $v0, 13			# open_file syscall code is 13
	la $a0, fGenKnowl		# getting file name
	li $a1, 0			# file flag = read (0)
	syscall 
	bltz $v0, openError
	move $s6, $v0			# save file descriptor, $s0 is for file	
	
	# read in and display question from fGenKnowl
	li $v0, 14			# read_file syscall code is 14
	move $a0, $s6			# the file descriptor to identify file being read
	# load address of corresponding buffer
	la $a1, buffGenKnowl	 	# buffer that holds string of whole file
	la $a2, 3000
	syscall
	bltz $v0, readError	
	
	# close file
	li $v0, 16
	move $a0, $s6
	syscall
	
############# Open file for Current Events and STORE BUFFER all at once and close ##############
	# open corresponding file
	li $v0, 13			# open_file syscall code is 13
	la $a0, fCrrntEvent		# getting file name
	li $a1, 0			# file flag = read (0)
	syscall 
	bltz $v0, openError
	move $s6, $v0			# save file descriptor, $s0 is for file	
	
	# read in and display question from fCrrntEvent
	li $v0, 14			# read_file syscall code is 14
	move $a0, $s6			# the file descriptor to identify file being read
	# load address of corresponding buffer
	la $a1, buffCrrntEvent	 	# buffer that holds string of whole file
	la $a2, 3000
	syscall
	bltz $v0, readError	
	
	# close file
	li $v0, 16
	move $a0, $s6
	syscall
	
############# Open file for Music and STORE BUFFER all at once and close ##############
	# open corresponding file
	li $v0, 13			# open_file syscall code is 13
	la $a0, fMusic			# getting file name
	li $a1, 0			# file flag = read (0)
	syscall 
	bltz $v0, openError
	move $s6, $v0			# save file descriptor, $s0 is for file	
	
	# read in and display question from fMusic
	li $v0, 14			# read_file syscall code is 14
	move $a0, $s6			# the file descriptor to identify file being read
	# load address of corresponding buffer
	la $a1, buffMusic	 	# buffer that holds string of whole file
	la $a2, 3000
	syscall
	bltz $v0, readError	
	
	# close file
	li $v0, 16
	move $a0, $s6
	syscall

#-----------------------------------------------------------------------------------------------#
#				Display Menu Choices	
#-----------------------------------------------------------------------------------------------#
	li $v0, 13			# open_file syscall code is 13
	la $a0, fMenu			# getting file name
	li $a1, 0			# file flag = read(0)
	syscall
	bltz $v0, openError
	move $s6, $v0			# save file descriptor, $s0 is for file			
	# read in and display Menu from fMenu
	li $v0, 14			# read_file syscall code is 14
	move $a0, $s6			# the file descriptor to identify file being read
	la $a1, buffMenu	 	# buffer that holds string of whole file
	la $a2, 500
	syscall
	bltz $v0, readError
	# print whats in file
	li $v0, 4			# read_string syscall code is 4
	la $a0, buffMenu
	syscall	
	
	li $t4, '\n'			# null character stored in $t4 to be compared against to find
#-----------------------------------------------------------------------------------------------#
#			Ask user if they want to play the trivia game or not	
#-----------------------------------------------------------------------------------------------#
QuestionNextQ:
	# Ask question
	li $v0, 4
	la $a0, QPlayGame
	syscall
	# allow for answer from user to play or to not 
	li $v0, 5			# read int from user
	syscall
	move $t0, $v0			# store value from $v0 input into $t0	

	# If user enters 0, continue game
	# if user does not enter 0, end program
	bne $t0, 0, endGameMessage
	
############# Else Get topic from random number generator and make decision based on that ##############		
	# Go to random number generator to get menu choice option 
	jal randNumGenFunct
	
	# branch to question topic if option from randNumGenFunct is equal to 1,2,3,4,5
	beq $t7, 1, L1
	beq $t7, 2, L2
	beq $t7, 3, L3
	beq $t7, 4, L4
	beq $t7, 5, L5
#-----------------------------------------------------------------------------------------------#
#			Based on topic, will choose questions to ask 	
#-----------------------------------------------------------------------------------------------#
############# For Movies/Tv shows topic ##############
L1: 
	# "Menu choice option is" message
	li $v0, 4
	la $a0, randTopicMessage
	syscall
	li $v0, 4
	la $a0, message1
	syscall
	# ask whether they want differ question and returned value will be in $t2
	jal FunctDifTopicYorNo
	# if user chose 0 for no then choose differ number again (RandTopic function)
	beq $t2, 0, RandTopic
	# if user chose any other number then continue and need to open question file corresp to Movies/Tv shows
	bne $t2, 0, goToFileMoviesTvShows
	
############# For General Knowledge topic ##############
L2:
	# "Menu choice option is" message
	li $v0, 4
	la $a0, randTopicMessage
	syscall
	li $v0, 4
	la $a0, message2
	syscall
	# ask whether they want differ question
	jal FunctDifTopicYorNo
	# if not equal to 0, continue. if 0, then choose differ number again (RandTopic function)
	beq $t2, 0, RandTopic
	# if user chose any other number then continue and need to open question file corresp to General Knowledge
	bne $t2, 0, goToFileGenKnowledge

############# For Pop Culture topic ##############	
L3:
	# "Menu choice option is" message
	li $v0, 4
	la $a0, randTopicMessage
	syscall
	li $v0, 4
	la $a0, message3
	syscall
	# ask whether they want differ question
	jal FunctDifTopicYorNo
	# If 0, then choose differ number again (RandTopic function)
	beq $t2, 0, RandTopic
	# if user chose any other number then continue and need to open question file corresp to Pop Culture
	bne $t2, 0, goToFilePopCulture
	
############# For Current Events topic ##############
L4:
	# "Menu choice option is" message
	li $v0, 4
	la $a0, randTopicMessage
	syscall
	li $v0, 4
	la $a0, message4
	syscall
	# ask whether they want differ question
	jal FunctDifTopicYorNo	
	# if not equal to 0, continue. if 0, then choose differ number again (RandTopic function)
	beq $t2, 0, RandTopic
	# if user chose any other number then continue and need to open question file corresp to Current Events
	bne $t2, 0, goToFileCurrentEvents

############# For Music topic 2018/2017/2000s ##############
L5:
	# "Menu choice option is" message
	li $v0, 4
	la $a0, randTopicMessage
	syscall
	li $v0, 4
	la $a0, message5
	syscall
	# ask whether they want differ question
	jal FunctDifTopicYorNo
	# if not equal to 0, continue. if 0, then choose differ number again (RandTopic function)
	beq $t2, 0, RandTopic
	# if user chose any other number then continue and need to open question file corresp to Music 2018/2017/2000s
	bne $t2, 0, goToFileMusic
#-----------------------------------------------------------------------------------------------#
#			Display Questions and Answers For Each Topic 	
#-----------------------------------------------------------------------------------------------#
# opens file for topic 1
# displays question and ans choices	
goToFileMoviesTvShows:		
	# variables to store strings into to print	
	la $s1, strFileQuestf1
	
	# variable to store string to not print but to compare user inputted choice to 
	la $s2, strCrrctAns
	
	#access globalvariable	
	lw $a0, intCounterf1	
	
	# To make sure pointer only goes to start of buffer once so it can go to new set of lines 
	# each time 	
	beq $a0, $zero, bufferBegf1
	# return back from bufferBegf1 and save value of $a0 to be 1 so it never returns to bufferBegf1
	backTogoToFileMoviesTvShows:
	addi $t2, $zero, 0		# set counter $t2 to 0, i=0
	addi $t3, $zero, 0		# set counter for line num to 0	
	b LoopChar
	
#################################################################	
# opens file for topic 2
# displays question and ans choices	
goToFileGenKnowledge:
	# variables to store strings into to print	
	la $s1, strFileQuestf2
	
	# variable to store string to not print but to compare user inputted choice to 
	la $s2, strCrrctAns
	
	#access globalvariable	
	lw $a0, intCounterf2
	
	# To make sure pointer only goes to start of buffer once so it can go to new set of lines 
	# each time 	
	beq $a0, $zero, bufferBegf2
	# return back from bufferBegf2 and save value of $a0 to be 1 so it never returns to bufferBegf2
	backTogoToFileGenKnowledge:
	# To keep track of going through characters in Buffer 	
	addi $t2, $zero, 0		# set counter $t2 to 0, i=0
	addi $t3, $zero, 0		# set counter for line num to 0
	b LoopChar	
		
#################################################################
# opens file for topic 3
# displays question and ans choices	
goToFilePopCulture:
	# variables to store strings into to print	
	la $s1, strFileQuestf3
	# variable to store string to not print but to compare user inputted choice to 
	la $s2, strCrrctAns
	
	#access globalvariable	
	lw $a0, intCounterf3
	
	# To make sure pointer only goes to start of buffer once so it can go to new set of lines 
	# each time 	
	beq $a0, $zero, bufferBegf3
	# return back from bufferBegf3 and save value of $a0 to be 1 so it never returns to bufferBegf3
	backTogoToFilePopCulture:
	# To keep track of going through characters in Buffer 	
	addi $t2, $zero, 0		# set counter $t2 to 0, i=0
	addi $t3, $zero, 0		# set counter for line num to 0
	b LoopChar	

#################################################################	
# opens file for topic 4
# displays question and ans choices	
goToFileCurrentEvents:
	# variables to store strings into to print	
	la $s1, strFileQuestf4
	# variable to store string to not print but to compare user inputted choice to 
	la $s2, strCrrctAns
	
	#access globalvariable	
	lw $a0, intCounterf4
	
	# To make sure pointer only goes to start of buffer once so it can go to new set of lines 
	# each time 	
	beq $a0, $zero, bufferBegf4
	# return back from bufferBegf4 and save value of $a0 to be 1 so it never returns to bufferBegf4
	backTogoToFileCurrentEvents:
	# To keep track of going through characters in Buffer 	
	addi $t2, $zero, 0		# set counter $t2 to 0, i=0
	addi $t3, $zero, 0		# set counter for line num to 0
	b LoopChar	

#################################################################	
# opens file for topic 5
# displays question and ans choices	
goToFileMusic:
	# variables to store strings into to print	
	la $s1, strFileQuestf5
	# variable to store string to not print but to compare user inputted choice to 
	la $s2, strCrrctAns
	
	#access globalvariable	
	lw $a0, intCounterf5
	
	# To make sure pointer only goes to start of buffer once so it can go to new set of lines 
	# each time 	
	beq $a0, $zero, bufferBegf5
	# return back from bufferBegf5 and save value of $a0 to be 1 so it never returns to bufferBegf5
	backTogoToFileMusic:
	# To keep track of going through characters in Buffer 	
	addi $t2, $zero, 0		# set counter $t2 to 0, i=0
	addi $t3, $zero, 0		# set counter for line num to 0
	b LoopChar	

#-----------------------------------------------------------------------------------------------#
#			Makes sure pointer goes to starting point of Buffer
# 			only when asking first question from each file.
# 	So, bufferBegX sets pointer at starting of buffer only once and then changes value
#	to 1 of intCounterX and saves new value.
#-----------------------------------------------------------------------------------------------#

bufferBegf1:
	la $t1, BuffMovie		# pointer at beginning for string, x[i]
	
	#modify globalvariable
   	la $a0, intCounterf1 		#get address
   	li $a1, 1 			#new value
   	sw $a1 0($a0) 			#save new value
   	
	j backTogoToFileMoviesTvShows
bufferBegf2:
	la $t1, buffGenKnowl		# pointer at beginning for string, x[i]
	
	#modify globalvariable
   	la $a0, intCounterf2 #get address
   	li $a1, 1 #new value
   	sw $a1 0($a0) #save new value

	j backTogoToFileGenKnowledge
bufferBegf3:
	la $t1, buffPopCult		# pointer at beginning for string, x[i]
	
	#modify globalvariable
   	la $a0, intCounterf3 #get address
   	li $a1, 1 #new value
   	sw $a1 0($a0) #save new value

	j backTogoToFilePopCulture
bufferBegf4:
	la $t1, buffCrrntEvent		# pointer at beginning for string, x[i]
	
	#modify globalvariable
   	la $a0, intCounterf4 #get address
   	li $a1, 1 #new value
   	sw $a1 0($a0) #save new value

	j backTogoToFileCurrentEvents
bufferBegf5:
	la $t1, buffMusic		# pointer at beginning for string, x[i]
	
	#modify globalvariable
   	la $a0, intCounterf5 #get address
   	li $a1, 1 #new value
   	sw $a1 0($a0) #save new value

	j backTogoToFileMusic
	
#-----------------------------------------------------------------------------------------------#
# 			Functions that will load bytes for each of the 4 lines
#			and Store the correct answer to compare
#-----------------------------------------------------------------------------------------------#
LoopChar:
	lb $t2, 0($t1)			# load value of character
	beq $t2, $t4, LineEnd		# if $t2 = null char, reached null terminator, so branch
	# else jump to LineNotEnd to keep looping through until reach null terminator	
	j LineNotEnd			# if the line has not reached end, will jump to function to store byte and increment and return to 
					# start of loop until it reaches null terminator
	j LoopChar			# repeat loop
	
# for line 0, stores question; line 1,2,3, stores ans choice; line 4, stores correct ans num
LineEnd:
	beq $t3, 0, QandAnsEnd		# at line 0 (question), go to QandAnsEnd
	beq $t3, 1, QandAnsEnd		# at line 1 (ans choice), go to QandAnsEnd
	beq $t3, 2, QandAnsEnd		# at line 2 (ans choice), go to QandAnsEnd
	beq $t3, 3, QandAnsEnd		# at line 3 (ans choice), go to QandAnsEnd
	beq $t3, 4, CrrctAnsEnd		# at line 4 (correct ans), go to CrrctAnsEnd
	
# function to continue looping by jumping to NotEnd functions bc line has not reached end for 0th, 1st, 2nd, 3rd, 4th line
LineNotEnd:
	beq $t3, 0, QandAnsNotEnd	
	beq $t3, 1, QandAnsNotEnd
	beq $t3, 2, QandAnsNotEnd
	beq $t3, 3, QandAnsNotEnd	
	beq $t3, 4, CrrctAnsNotEnd
	j LoopChar

# Function to store byte into line until line has reached null terminator for specific line from file
QandAnsNotEnd:
	sb $t2, ($s1)			# else, store into question for 0th line
	addi $t1, $t1, 1		# increment character
	addi $s1, $s1, 1		# increment character
	j LoopChar			# go back to Loop to keep grabbing characters to append to next line

# Function to store correct answer (character) stored in file 		
CrrctAnsNotEnd: 			# s2 used to compare to user input answer num
	sb $t2, ($s2)			# else, store into answer for 4th line
	addi $t1, $t1, 1		# increment character
	#addi $s2, $s2, 1		# increment character
	j LoopChar			

# Function where once line 1, then line 2, then line 3 end, it stores new line and goes to next character and increments line num
QandAnsEnd:
	sb $t2, ($s1)			# stores newline char after having stored previous line and need to ...
	# to go to next character
	addi $t1, $t1, 1		# count character to pass newline char to go to char in new line
	addi $s1, $s1, 1		# count character to pass newline char to go to char in new line
	
	li $t8, '\0'
	sb $t8, ($s1)

	addi $t3, $t3, 1		# increment counter for num lines
	j LoopChar
	
# Function to display question from file and answer choices and compare answer from user to correct answer	
CrrctAnsEnd:
	# call print question and answer choices
	# branch to right file based on option from randNumGenFunct which is in $t7 and equal to 1,2,3,4, or 5
	beq $t7, 1, prntQandAf1
	beq $t7, 2, prntQandAf2
	beq $t7, 3, prntQandAf3
	beq $t7, 4, prntQandAf4
	beq $t7, 5, prntQandAf5
	
	# to return back from previous functions
	BackToCrrctAnsEnd:

	# ASK USER INPUT for Answer to the question
	li $v0, 12			# read character from user
	syscall
	move $t5, $v0			# store value from $v0 input into $t5 for comparison purpose
	
	lb $t6, ($s2)			# load byte character (correct answer in file) to $t6 for comparison purpose
	
	# compare user answer to actual correct number answer	
	beq $t5, $t6, correctFunc	# if correct ans, jump to correctFunc
	bne $t5, $t6, wrongFunc		# if wrong ans, jump to wrongFunc
	
	# to return back from previous functions
	BackToCrrctAnsEnd1:
	# to go to next character
	addi $t1, $t1, 1		# count character
	addi $s2, $s2, 2		# count character
	
	# set stored register pointer to start of next question (b/c pointer to end of answer choices and pointer to end of 
	# correct answer in the file are different)
	move $s1, $s2	
	
	# set file pointer to start of next question for each file
	beq $t7, 1, setPointerf1
	beq $t7, 2, setPointerf2
	beq $t7, 3, setPointerf3
	beq $t7, 4, setPointerf4
	beq $t7, 5, setPointerf5
	
	# to return back from previous functions
	BackToCrrctAnsEnd2:

	addi $t3, $zero, 0		# set num line back to 0 so when its called again it will count 4 lines correctly
	
	# Need to jump to next question from randomly generated file
	j QuestionNextQ
	
#-----------------------------------------------------------------------------------------------#
# 			set pointer to correct place for next question			
#-----------------------------------------------------------------------------------------------#
setPointerf1:
	la $s2, strFileQuestf1
	j BackToCrrctAnsEnd2	
setPointerf2:
	la $s2, strFileQuestf2
	j BackToCrrctAnsEnd2	
setPointerf3:
	la $s2, strFileQuestf3
	j BackToCrrctAnsEnd2	
setPointerf4:
	la $s2, strFileQuestf4
	j BackToCrrctAnsEnd2	
setPointerf5:
	la $s2, strFileQuestf5
	j BackToCrrctAnsEnd2	
				
								
prntQandAf1:
	# Print Question and Answer Choices
	li $v0, 4			
	la $a0, strFileQuestf1
	syscall
	j BackToCrrctAnsEnd

prntQandAf2:
	# Print Question and Answer Choices
	li $v0, 4			
	la $a0, strFileQuestf2
	syscall
	j BackToCrrctAnsEnd	
	
prntQandAf3:
	# Print Question and Answer Choices
	li $v0, 4			
	la $a0, strFileQuestf3
	syscall
	j BackToCrrctAnsEnd
	
prntQandAf4:
	# Print Question and Answer Choices
	li $v0, 4			
	la $a0, strFileQuestf4
	syscall
	j BackToCrrctAnsEnd
	
prntQandAf5:
	# Print Question and Answer Choices
	li $v0, 4			
	la $a0, strFileQuestf5
	syscall
	j BackToCrrctAnsEnd
# function for keeping track of how many questions are right
correctFunc:
	# Display that user got the answer correct 
	li $v0, 4
	la $a0, crrctMsg
	syscall
	
	addi $s3, $s3, 1		# add one to num of correct ans
	addi $s4, $s4, 10		# add ten points for each correct ans
	# then go back to new question topic
	j BackToCrrctAnsEnd1
	
# Function to jump to when answer is wrong
wrongFunc:
	# immediately tell user they got answer wrong
	li $v0, 4
	la $a0, wrongMsg
	syscall
	# if user has less than one save can possibly get a save	
	blt $s5, 1, possibleBuySave
	returnFromSave:
	# If number of saves for whole game < 1, prompt question below:
	#blt $s5, 1, showStats
	# display how many saves user has left
	li $v0, 4
	la $a0, msgSavesLeft
	syscall
	# displays actual num of saves left
	li $v0, 1
	sw $s5, strNumSaves
	lw $a0, strNumSaves
	syscall
	# ask user whether they want to use a save or not
	li $v0, 4			
	la $a0, QUseSave
	syscall
	# allow user to enter choice of ending game or using save to continue
	li $v0, 5			# read int from user
	syscall
	move $t6, $v0			# store value from $v0 input into $t6	
	# $t6 now holds user choice	
	# if 0, use save
	# if user enters any other # than 0, 
	beq $t6, 0, subSaves			# if user uses save, subtract 1 from saves	
	bne $t6, 0, showStats
	returnFromSubSave:
	# else user chooses a save, and continues asking next question
	j BackToCrrctAnsEnd1
	
possibleBuySave:
	# allow to buy save if they have more than 30 points
	bgt $s4, 30, buySave
	# if they have less than 30, showStats
	blt $s4, 30, showStats
buySave:
	# display you can buy a save!
	li $v0, 4
	la $a0, buySaveMsg
	syscall
	# subtract 30 points from $s4
	sub $s4, $s4, 30
	# add a life to $s5
	addi $s5, $s5, 1
	# return to function
	j returnFromSave
# Function to subtract from lives/saves the user has
subSaves:
	# subtract one save from $s5
	sub $s5, $s5, 1	
	j returnFromSubSave	
		
############# Function for choosing random topic when called to choose differ topic ##############						
RandTopic:
	# "Menu choice option is" message
	li $v0, 4
	la $a0, randTopicMessage
	syscall
	
	# Go to random number generator to get menu choice option 
	jal randNumGenFunct
	
	# branch if option from randNumGenFunct is equal to 1,2,3,4,5
	beq $t7, 1, L1
	beq $t7, 2, L2
	beq $t7, 3, L3
	beq $t7, 4, L4
	beq $t7, 5, L5 	
	
############# Function for whether to choose different topic or not ##############
FunctDifTopicYorNo:
	# print out extra info about changing topic
	li $v0, 4
	la $a0, QdifferTopic2
	syscall	
	
	# allow user to enter input choice 0 or other number
	li $v0, 5			# read int from user
	syscall
	move $t2, $v0			# store value from $v0 input into $t2	
	jr $ra 				# return 0 or other number

# display stats of game, before ending
showStats:
	# display how many points
	li $v0, 4
	la $a0, endPointsMsg
	syscall
	# print out points
	#lw $a0, strNumPoints
	li $v0, 1
	sw $s4, strNumPoints
	lw $a0, strNumPoints
	syscall
		
	# display how many right
	li $v0, 4
	la $a0, endNumCorrectMsg
	syscall
	# print out right num
	#lw $a0, strNumCorrect
	li $v0, 1
	sw $s3, strNumCorrect
	lw $a0, strNumCorrect
	syscall
	
	# display game ended				
	li $v0, 4
	la $a0, endGameMsg
	syscall
	b endProgram
# function that has message for error opening of file
openError:
	la $a0, openErrorMsg
	li $v0, 4
	syscall
	b endProgram
# function that has message for reading error of file
readError:
	la $a0, readErrorMsg
	li $v0, 4
	syscall
	b endProgram
# function that contains what needs to be displayed when game is ended manually
endGameMessage:
	li $v0, 4
	la $a0, endGame	
	syscall
	j showStats
	b endProgram
# function that creates random number so trivia topics can be chosen this way	
randNumGenFunct:
	# $a0 will hold the random num
	# need to seed random number generator
	# get time
	li	$v0, 30			# syscall to get system time 
	syscall
	move	$t0, $a0		# a0 saves lower order 32-bits of system time
	# seed the random generator 
	move 	$a1, $t0		# seed from time
	li	$v0, 40			# set seed syscall
	syscall
	# set range of numbers as 0 to 4
	li	$a1, 5			# sets range, w/ $a1 as upper bound of 5
	li	$v0, 42			# random int range
	syscall
	
	# move numbeer to $t7
	move	$t7, $a0		# print integer syscall
	#li $t7, 1
	addi 	$t7, $t7, 1		# add 1 to it, to go with menu choices
	jr $ra
	
############# Function to end game ##############
endProgram:
	li $v0, 10
	syscall

		
	
	
