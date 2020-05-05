#nop sled
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
#word to be autocorrected: "b"
#should be autocorrected to: "a"
#which is at memory location: 2048
addi $1, $0, 1
addi $2, $0, 0
jal autocorrect
addi $0, $3, 0
#add this so we can inspect the value returned by autocorrect method
#add nops because I bypass $0, which should not happen
nop
nop
nop
nop
nop
nop
nop

#word to be autocorrected: "ana"
#should be autocorrected to: "and"
#which is at memory location: 2136
addi $1, $0, 2
addi $2, $0, 2
jal autocorrect
addi $0, $3, 0
#add this so we can inspect the value returned by autocorrect method
#add nops because I bypass $0, which should not happen
nop
nop
nop
nop
nop
nop
nop

#word to be autocorrected: "aaaa"
#should be autocorrected to: n\a
#which is at memory location: 0
addi $1, $0, 3
addi $2, $0, 2
jal autocorrect
addi $0, $3, 0
#add this so we can inspect the value returned by autocorrect method
#add nops because I bypass $0, which should not happen
nop
nop
nop
nop
nop
nop
nop

j done
#autocorrect method
#assumptions:
#	both words end in a null character
#parameters: 
#	$1: address of word to be autocorrected
#	$2: sub-address (0, 1, 2, or 3) - the character of the memory word that contains the first letter of the English word
#registers used:
#	$1-12
#return value:
#	$3: address of autocorrected word, 0 if no autocorrect found/required
autocorrect:
#save $ra to memory
sw $ra, 4088($0)
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
#load $ra from memory and return
lw $ra, 4088($0)
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
lw $5, 0($10)
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
lw $7, 0($1)
addi $8, $0, 1
blt $2, $8, aStartsAt0
addi $8, $0, 2
blt $2, $8, aStartsAt1
addi $8, $0, 3
blt $2, $8, aStartsAt2
addi $8, $0, 4
blt $2, $8, aStartsAt3
aStartsAt0:
#shift the mask, then and the mask with the loaded word, then shift it all the way to the left
sll $6, $6, 24
and $6, $6, $7
#increment letter address
addi $2, $2, 1
j doneLoadingA
aStartsAt1:
#shift the mask, then and the mask with the loaded word, then shift it all the way to the left
sll $6, $6, 16
and $6, $6, $7
sll $6, $6, 8
#increment letter address
addi $2, $2, 1
j doneLoadingA
aStartsAt2:
#shift the mask, then and the mask with the loaded word, then shift it all the way to the left
sll $6, $6, 8
and $6, $6, $7
sll $6, $6, 16
#increment letter address
addi $2, $2, 1
j doneLoadingA
aStartsAt3:
#shift the mask, then and the mask with the loaded word, then shift it all the way to the left
and $6, $6, $7
sll $6, $6, 24
#increment letter sub-address and dmem address
addi $2, $0, 0
addi $1, $1, 1
doneLoadingA:
#now the character of A is in $6

addi $7, $0, 255
#create mask
lw $8, 0($3)
addi $9, $0, 1
blt $4, $9, bStartsAt0
addi $9, $0, 2
blt $4, $9, bStartsAt1
addi $9, $0, 3
blt $4, $9, bStartsAt2
addi $9, $0, 4
blt $4, $9, bStartsAt3
bStartsAt0:
#shift the mask, then and the mask with the loaded word, then shift it all the way to the left
sll $7, $7, 24
and $7, $7, $8
#increment letter address
addi $4, $4, 1
j doneLoadingB
bStartsAt1:
#shift the mask, then and the mask with the loaded word, then shift it all the way to the left
sll $7, $7, 16
and $7, $7, $8
sll $7, $7, 8
#increment letter address
addi $4, $4, 1
j doneLoadingB
bStartsAt2:
#shift the mask, then and the mask with the loaded word, then shift it all the way to the left
sll $7, $7, 8
and $7, $7, $8
sll $7, $7, 16
#increment letter address
addi $4, $4, 1
j doneLoadingB
bStartsAt3:
#shift the mask, then and the mask with the loaded word, then shift it all the way to the left
and $7, $7, $8
sll $7, $7, 24
#increment letter sub-address and dmem address
addi $4, $0, 0
addi $3, $3, 1
doneLoadingB:
#now the character of B is in $7

bne $6, $7, aNotEqualB

aEqualB:
bne $6, $0, equalAndNonNull
equalAndNull:
#end of both. numDiffs is already in $5. Just return
jr $ra
equalAndNonNull:
#do not increment numDiffs. Increment letter locations and recurse
j incrementLetterLocsAndRecurse


aNotEqualB:
bne $6, $0, aNotNull
#A is null
j diffAndOneNull
aNotNull:
bne $7, $0, bNotNull
#B is null
j diffAndOneNull
bNotNull:
diffAndNoNull: 
#increment numDiffs. Increment letter locations and recurse
addi $5, $5, 1

#if the numDiffs is not 1 at this point, it is greater than 1, so we should just set $5 to 255 and jr
addi $6, $0, 1
bne $5, $6, numDiffsNot1

j incrementLetterLocsAndRecurse
diffAndOneNull:
#lengths are different. Set numDiffs to max value and return
addi $5, $0, 255
jr $ra

incrementLetterLocsAndRecurse:
#locs have already been incremented. Just recurse
j numDifferences

numDiffsNot1:
addi $5, $0, 255
jr $ra

done: