#!/bin/sh

letterConvs() {
  for i in A B C D E F G H I J K L M N O P Q R S T U V W X Y Z; do
    L=$(echo -n $i |\
      sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/')
    echo -n ";s/$i/[$i$L]/g"
  done
}

getReplacements() {
  #./tokenExtract <lang-spec-input.xml |\
  #grep -ve "^XML$" |\
  sed "s/ /[:space:]*/g$(letterConvs);s/^\(.*\)$/\\\|\1/"
}

echo -n "\\([\\t ]\\|^\\)\\(sdfasdf"

for i in $(getReplacements); do
  echo -n $i | sed 's/:space:/ \\t/g'
done

echo "\\)\\([\t s]\\|$\\)"
