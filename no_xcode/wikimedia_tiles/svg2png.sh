#!/bin/sh

# justPrintHelp=1
outSize=96 #in px

batikHome=~/tools/batik-1.7
batikJar=$batikHome/batik-rasterizer.jar

if (( $justPrintHelp ))
then
    java -jar $batikJar | less
    exit
fi

# for svgFile in *.svg
# do
#     java -jar $batikJar -w $outSize -h $outSize $svgFile
# done

java -jar $batikJar -w $outSize -h $outSize *.svg

