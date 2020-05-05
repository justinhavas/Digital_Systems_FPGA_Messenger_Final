nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop

#autocorrectWholeMessage method
#assumptions:
#	message ends in enter character
#parameters: 
#	$27: address of word to be autocorrected
#	$26: sub-address (0, 1, 2, or 3) - the character of the memory word that contains the first letter of the English word
#registers used:
#	$1-12
#return value:
#	none. Overwrites the word in memory to be correct, if a correction is found.
autocorrectWholeMessage:
#save $ra to memory
nop
nop
nop
nop
nop
nop
nop
nop
sw $ra, 4089($0)
nop
nop
nop
nop
nop
nop
nop
nop
#save $26 to memory
nop
nop
nop
nop
nop
nop
nop
nop
sw $26, 4090($0)
nop
nop
nop
nop
nop
nop
nop
nop
#save $27 to memory
nop
nop
nop
nop
nop
nop
nop
nop
sw $27, 4091($0)
nop
nop
nop
nop
nop
nop
nop
nop

beginAutoCorrectingWholeMessage:
addi $1, $27, 0 #$27 points to the address of the word to be autocorrected
addi $2, $26, 0 #26 points to the sub-address of the word to be autocorrected
jal autocorrect

#increment the letter pointer and check if it is a space or an enter.
#if it is a space, then increment one more time and jump back up to beginAutoCorrectingWholeMessage
#if it is an enter, then just j returnAutoCorrectWholeMessage
#if it is neither a space nor an enter, then jump back up to incrementLetterPointer
incrementLetterPointer:
addi $8, $0, 3
blt $26, $8, justIncrementr26
addi $26, $0, 0
addi $27, $27, 1
j doneIncrementingLetterPointer

justIncrementr26:
addi $26, $26, 1

doneIncrementingLetterPointer:

addi $4, $0, 255
bne $3, $4, reg3NotEqual255
addi $3, $0, 0
j beginAutoCorrectingWholeMessage
reg3NotEqual255:

#load the value of the character into register $3
addi $4, $0, 1
blt $26, $4, reg26IsAt0
addi $4, $0, 2
blt $26, $4, reg26IsAt1
addi $4, $0, 3
blt $26, $4, reg26IsAt2
addi $4, $0, 4
blt $26, $4, reg26IsAt3

#load the letter into reg 3
reg26IsAt0:
addi $4, $0, 255
sll $4, $4, 24
nop
nop
nop
nop
nop
lw $3, 0($27)
nop
nop
nop
nop
nop
and $3, $3, $4
sra $3, $3, 24
addi $4, $0, 255
and $3, $3, $4
j readyToCheckLetter

reg26IsAt1:
addi $4, $0, 255
sll $4, $4, 16
nop
nop
nop
nop
nop
lw $3, 0($27)
nop
nop
nop
nop
nop
and $3, $3, $4
sra $3, $3, 16
addi $4, $0, 255
and $3, $3, $4
j readyToCheckLetter

reg26IsAt2:
addi $4, $0, 255
sll $4, $4, 8
nop
nop
nop
nop
nop
lw $3, 0($27)
nop
nop
nop
nop
nop
and $3, $3, $4
sra $3, $3, 8
addi $4, $0, 255
and $3, $3, $4
j readyToCheckLetter

reg26IsAt3:
addi $4, $0, 255
nop
nop
nop
nop
nop
lw $3, 0($27)
nop
nop
nop
nop
nop
and $3, $3, $4

readyToCheckLetter:
addi $8, $0, 31
blt $3, $8, isEnter
#here it is not enter
addi $8, $0, 33
blt $3, $8, isSpace
#here it is neither space nor enter. Just jump back to incrementLetterPointer
j incrementLetterPointer

isSpace:
addi $3, $0, 255
j incrementLetterPointer

isEnter:
#here it is enter:
j returnAutoCorrectWholeMessage

returnAutoCorrectWholeMessage:
#load $26 from memory
nop
nop
nop
nop
nop
nop
nop
nop
lw $26, 4090($0)
nop
nop
nop
nop
nop
nop
nop
nop
#load $27 from memory
nop
nop
nop
nop
nop
nop
nop
nop
lw $27, 4091($0)
nop
nop
nop
nop
nop
nop
nop
nop
#load $ra from memory and return
nop
nop
nop
nop
nop
nop
nop
nop
lw $ra, 4089($0)
nop
nop
nop
nop
nop
nop
nop
nop
jr $ra



#autocorrect method
#assumptions:
#	both words end in a null character
#parameters: 
#	$1: address of word to be autocorrected
#	$2: sub-address (0, 1, 2, or 3) - the character of the memory word that contains the first letter of the English word
#registers used:
#	$1-12
#return value:
#	none. Overwrites the word in memory to be correct, if a correction is found.
autocorrect:
#save $ra to memory
nop
nop
nop
nop
nop
nop
nop
nop
sw $ra, 4088($0)
nop
nop
nop
nop
nop
nop
nop
nop
#instantiate address of dictionary in $10
#$10 will keep track of the dictionary word we are inspecting
addi $10, $0, 2048
#$11 and $12 will keep track of word A address and sub-address
addi $11, $1, 0
addi $12, $2, 0
#loop through words and find best fit
addi $3, $10, 0
addi $4, $0, 0
addi $5, $0, 0
checkWord:
jal numDifferences
bne $5, $0, nonZeroDiffs
#zero diffs. Set $3 to 0 and return
addi $3, $0, 0
j returnAutoCorrect
nonZeroDiffs:
addi $6, $0, 2
blt $5, $6, oneDiff
#multiple diffs. Move to next word and try again
j goToNextWordInDict

oneDiff:
#there is only one difference between the word in $1 and $10. Load $10 into $3 and return
addi $3, $10, 0
returnAutoCorrect:
#overwrite memory of incorrect word, if the return value is not 0
addi $1, $11, 0
addi $2, $12, 0
jal correctMemory
#load $ra from memory and return
nop
nop
nop
nop
nop
nop
nop
nop
lw $ra, 4088($0)
nop
nop
nop
nop
nop
nop
nop
nop
jr $ra

goToNextWordInDict:
addi $5, $0, 4085
bne $10, $5, nextWordExists
#We tried all the words. If we've come this far and haven't returned yet, then there was no match in the whole dictionary.
#load 0 into $3 and return
addi $3, $0, 0
j returnAutoCorrect
nextWordExists:
#load word at $10. Increment $10. If the loaded value contains a null character, return, else jump back up to nextWordExists
nop
nop
nop
nop
nop
nop
nop
nop
lw $5, 0($10)
nop
nop
nop
nop
nop
nop
nop
nop
addi $10, $10, 1
#check fourth char:
checkFourthChar:
addi $6, $0, 255
and $7, $5, $6
#if $7 is 0 after this, then the fourth char is null
bne $7, $0, checkThirdChar
j foundNullChar
#check third char:
checkThirdChar:
sll $6, $6, 8
and $7, $5, $6
#if $7 is 0 after this, then the third char is null
bne $7, $0, checkSecondChar
j foundNullChar
#check second char:
checkSecondChar:
sll $6, $6, 8
and $7, $5, $6
#if $7 is 0 after this, then the second char is null
bne $7, $0, checkFirstChar
j foundNullChar
#check first char:
checkFirstChar:
sll $6, $6, 8
and $7, $5, $6
#if $7 is 0 after this, then the first char is null
bne $7, $0, noNullChar
foundNullChar:
#$10 already has the right value in it. Set the correct values for $1-$5 and jump back up
addi $1, $11, 0
addi $2, $12, 0
addi $3, $10, 0
addi $4, $0, 0
addi $5, $0, 0
j checkWord

noNullChar:
j goToNextWordInDict


#numDifferences method
#assumptions:
#	both words end in a null character
#parameters:
#	$1: address of wordA
#	$2: sub-address (0, 1, 2, or 3) - the character of the memory word that contains the first letter of the English word
#	$3: address of wordB (the first character always starts at 0(address))
#	$4: sub-address (0, 1, 2, or 3) - the character of the memory word that contains the first letter of the English word
#	$5: number of letter differences already seen
#registers used:
#	$1-$9
#return value:
#	$5: number of letter differences
numDifferences:
addi $6, $0, 255
#create mask
nop
nop
nop
nop
nop
nop
nop
nop
lw $7, 0($1)
nop
nop
nop
nop
nop
nop
nop
nop
addi $8, $0, 1
blt $2, $8, aStartsAt0
addi $8, $0, 2
blt $2, $8, aStartsAt1
addi $8, $0, 3
blt $2, $8, aStartsAt2
addi $8, $0, 4
blt $2, $8, aStartsAt3
aStartsAt0:
#shift the mask, then and the mask with the loaded word, then shift it all the way to the right
sll $6, $6, 24
and $6, $6, $7
sra $6, $6, 24
addi $8, $0, 255
and $6, $6, $8
#increment letter address
addi $2, $2, 1
j doneLoadingA
aStartsAt1:
#shift the mask, then and the mask with the loaded word, then shift it all the way to the right
sll $6, $6, 16
and $6, $6, $7
sra $6, $6, 16
addi $8, $0, 255
and $6, $6, $8
#increment letter address
addi $2, $2, 1
j doneLoadingA
aStartsAt2:
#shift the mask, then and the mask with the loaded word, then shift it all the way to the right
sll $6, $6, 8
and $6, $6, $7
sra $6, $6, 8
addi $8, $0, 255
and $6, $6, $8
#increment letter address
addi $2, $2, 1
j doneLoadingA
aStartsAt3:
#shift the mask, then and the mask with the loaded word, then shift it all the way to the right
and $6, $6, $7
addi $8, $0, 255
and $6, $6, $8
#increment letter sub-address and dmem address
addi $2, $0, 0
addi $1, $1, 1
doneLoadingA:
#now the character of A is in $6

addi $7, $0, 255
#create mask
nop
nop
nop
nop
nop
nop
nop
nop
lw $8, 0($3)
nop
nop
nop
nop
nop
nop
nop
nop
addi $9, $0, 1
blt $4, $9, bStartsAt0
addi $9, $0, 2
blt $4, $9, bStartsAt1
addi $9, $0, 3
blt $4, $9, bStartsAt2
addi $9, $0, 4
blt $4, $9, bStartsAt3
bStartsAt0:
#shift the mask, then and the mask with the loaded word, then shift it all the way to the right
sll $7, $7, 24
and $7, $7, $8
sra $7, $7, 24
addi $9, $0, 255
and $7, $7, $9
#increment letter address
addi $4, $4, 1
j doneLoadingB
bStartsAt1:
#shift the mask, then and the mask with the loaded word, then shift it all the way to the right
sll $7, $7, 16
and $7, $7, $8
sra $7, $7, 16
addi $9, $0, 255
and $7, $7, $9
#increment letter address
addi $4, $4, 1
j doneLoadingB
bStartsAt2:
#shift the mask, then and the mask with the loaded word, then shift it all the way to the right
sll $7, $7, 8
and $7, $7, $8
sra $7, $7, 8
addi $9, $0, 255
and $7, $7, $9
#increment letter address
addi $4, $4, 1
j doneLoadingB
bStartsAt3:
#shift the mask, then and the mask with the loaded word, then shift it all the way to the right
and $7, $7, $8
addi $9, $0, 255
and $7, $7, $9
#increment letter sub-address and dmem address
addi $4, $0, 0
addi $3, $3, 1
doneLoadingB:
#now the character of B is in $7

bne $7, $0, bCharIsNotNull
#space character is d32 and enter is d10, so if $6 is less than 33, we know that this is the end of both
addi $8, $0, 33
blt $6, $8, aAndBBothEnd
#At this point, B has a null character, but A does not have a space or enter. They are different lengths,
#so load max value into $5 and return
#lengths are different. Set numDiffs to max value and return
addi $5, $0, 255
jr $ra

aAndBBothEnd:
# bne $6, $7, aAndBBothEndAndAreDifferent
# #at this point, a and b both end and are the same.
# #$5 already contains the number of differences, so just jr $ra
# jr $ra

# aAndBBothEndAndAreDifferent:
# #increment $5 and return
# addi $5, $5, 1
jr $ra

bCharIsNotNull:
#space character is d32 and enter is d10, so if $6 is less than 33, we know that this is the end of both
addi $8, $0, 33
blt $6, $8, bCharIsNotNullAndACharIsSpaceOrEnter
#at this point, b char is not null, and a char is not space or enter. Compare and increment $5 if different
bne $6, $7, aAndBAreDifferent
#here they are the same. Do not increment $5. Just j numDifferences
j numDifferences

aAndBAreDifferent:
#increment $5 and j numDifferences
addi $5, $5, 1
j numDifferences

bCharIsNotNullAndACharIsSpaceOrEnter:
#b char is not null, but A char is space or enter.
#Load max value into $5 and return
addi $5, $0, 255
jr $ra












#correctMemory method
#assumptions:
#	word B ends in a null character - always true since wordB is from the dictionary
#parameters:
#	$1: address of wordA
#	$2: sub-address (0, 1, 2, or 3) - the character of the memory word that contains the first letter of the English word
#	$3: address of wordB (the correct word). 0 if wordA is already correct
#registers used:
#	$1-$9
#return value:
#	none. Overwrites wordA with wordB, if $3 is not 0
correctMemory:
#if the $3 register is equal to 0, then we can just return because the memory is already correct
addi $4, $0, 0

needToCorrectStart:

bne $3, $0, needToCorrect
#If it reaches this line, the $3 register is 0, so we can just jr $ra
jr $ra

#submethod of correctMemory
#parameters:
#	$1: address of wordA
#	$2: sub-address of wordA
#	$3: address of wordB
#	$4: sub-address of wordB
needToCorrect:
#first load the first character from B and mask it
nop
nop
nop
nop
nop
nop
nop
nop
lw $5, 0($3)
nop
nop
nop
nop
nop
nop
nop
nop
addi $6, $0, 255

addi $9, $0, 1
blt $4, $9, needToCorrectBStartsAt0
addi $9, $0, 2
blt $4, $9, needToCorrectBStartsAt1
addi $9, $0, 3
blt $4, $9, needToCorrectBStartsAt2
addi $9, $0, 4
blt $4, $9, needToCorrectBStartsAt3

needToCorrectBStartsAt0:
sll $6, $6, 24
and $5, $5, $6
sra $5, $5, 24
addi $6, $0, 255
and $5, $5, $6
#increment $4
addi $4, $4, 1
j needToCorrectDoneLoadingB

needToCorrectBStartsAt1:
sll $6, $6, 16
and $5, $5, $6
sra $5, $5, 16
#increment $4
addi $4, $4, 1
j needToCorrectDoneLoadingB

needToCorrectBStartsAt2:
sll $6, $6, 8
and $5, $5, $6
sra $5, $5, 8
#increment $4
addi $4, $4, 1
j needToCorrectDoneLoadingB

needToCorrectBStartsAt3:
and $5, $5, $6
#increment $3 and set $4 to 0
addi $3, $1, 1
addi $4, $0, 0

needToCorrectDoneLoadingB:
#if the character from B is null, return
bne $5, $0, charFromBNotNull
jr $ra

charFromBNotNull:
#load A, mask it, shift B, and increment $1 and $2
nop
nop
nop
nop
nop
nop
nop
nop
lw $6, 0($1)
nop
nop
nop
nop
nop
nop
nop
nop
addi $7, $0, 255
addi $9, $0, 1
blt $2, $9, needToCorrectAStartsAt0
addi $9, $0, 2
blt $2, $9, needToCorrectAStartsAt1
addi $9, $0, 3
blt $2, $9, needToCorrectAStartsAt2
addi $9, $0, 4
blt $2, $9, needToCorrectAStartsAt3

needToCorrectAStartsAt0:
#mask A:
sll $7, $7, 16
addi $8, $0, 255
sll $8, $8, 8
or $7, $7, $8
sra $8, $8, 8
or $7, $7, $8
and $6, $6, $7
#shift B:
sll $5, $5, 24
#Now the shifted char for B is in $5, and the masked A is in $6
#do an OR on the masked A and the character from B
or $5, $5, $6

#store the value from the OR
nop
nop
nop
nop
nop
nop
nop
nop
sw $5, 0($1)
nop
nop
nop
nop
nop
nop
nop
nop
#increment $2
addi $2, $2, 1
j needToCorrectDoneLoadingA

needToCorrectAStartsAt1:
#mask A:
sll $7, $7, 24
addi $8, $0, 255
sll $8, $8, 8
or $7, $7, $8
sra $8, $8, 8
or $7, $7, $8
and $6, $6, $7

#shift B:
sll $5, $5, 16

#Now the shifted char for B is in $5, and the masked A is in $6
#do an OR on the masked A and the character from B
or $5, $5, $6

#store the value from the OR
nop
nop
nop
nop
nop
nop
nop
nop
sw $5, 0($1)
nop
nop
nop
nop
nop
nop
nop
nop

#increment $2
addi $2, $2, 1
j needToCorrectDoneLoadingA

needToCorrectAStartsAt2:
#mask A:
sll $7, $7, 24
addi $8, $0, 255
sll $8, $8, 16
or $7, $7, $8
sra $8, $8, 16
or $7, $7, $8
and $6, $6, $7

#shift B:
sll $5, $5, 8

#Now the shifted char for B is in $5, and the masked A is in $6
#do an OR on the masked A and the character from B
or $5, $5, $6

#store the value from the OR
nop
nop
nop
nop
nop
nop
nop
nop
sw $5, 0($1)
nop
nop
nop
nop
nop
nop
nop
nop

#increment $2
addi $2, $2, 1
j needToCorrectDoneLoadingA

needToCorrectAStartsAt3:
#mask A:
sll $7, $7, 24
addi $8, $0, 255
sll $8, $8, 16
or $7, $7, $8
sra $8, $8, 8
or $7, $7, $8
and $6, $6, $7

#shift B:
sll $5, $5, 8

#Now the shifted char for B is in $5, and the masked A is in $6
#do an OR on the masked A and the character from B
or $5, $5, $6

#store the value from the OR
nop
nop
nop
nop
nop
nop
nop
nop
sw $5, 0($1)
nop
nop
nop
nop
nop
nop
nop
nop

#increment $1 and set $2 to 0
addi $1, $1, 1
addi $2, $0, 0

needToCorrectDoneLoadingA:

#loop back up
j needToCorrectStart
