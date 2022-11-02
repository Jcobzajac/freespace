#!/bin/bash

#Variables for flags


RECURSIVE=false
LIFETIME=2880

#Flags

while getopts ":r:t:"  OPTION
do
  case ${OPTION} in

       r) RECURSIVE=true
          ;;

       t) LIFETIME=$(($OPTION*60))
          ;;

  esac
shift $((OPTIND-1))



operations() {

FILE=$1 #Assigning file/directory to variable

if [[ $FILE == $DIR"/fc-"* && $(find $FILE-mmin +$LIFETIME) ]]  #Check whether directory has more than 48 hours
 then
  rm $FIlE
elif (file $FILE | grep -q "compress" ) #Check whether file is compressed
 then
  mv $FILE fc-"${FILE}"
elif (file $FILE | grep -v "compress") #Checking file for being uncompressed 
  zip -m fc-"${FILE}".zip $FILE
  rm $FILE
fi
        
}



traverse_recursively() { 

   #Same as traverse function, but additionaly check whether input is directory    and if is, then looping through it recursively 
    for file in $(ls $1)	
     if [[ -d $1 ]]
     then
      traverse_recursively $file
    else
      operations $file
    fi
  done
  



}


traverse() {

#Looping through subfiles/subdirectories in folder

  for file in $(ls $1)
  do
    operations $file
  done



}

#FLOW
for element in $@
do
  if [[ -f $element ]]
   then
     operations $element
  elif [[ $RECURSIVE ]]
   then
    traverse_recursively $element
  else
    traverse $element
  fi
done






