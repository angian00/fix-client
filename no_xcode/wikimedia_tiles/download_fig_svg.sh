#!/bin/sh

baseUrl="http://commons.wikimedia.org/wiki"
tmpFileName="tmp.html"

#DEBUG
xpathExpr="string(//*[@class='fullMedia']/*[local-name()='a']/@href)"
#

for piece in 'p' 'n' 'b' 'q' 'k'
do
    for col in 'd' 'l'
    do
        for bg in '' '-whitebg'
        do
            fileName="Chess_tile_${piece}${col}${bg}.svg"
            echo "Searching for [$fileName]"

            #only white pieces have different tiles for white background
            if test "$col" != "l" -a "$bg" != ""
            then
                echo "Skipping file (invalid combination)"
                echo
                continue
            fi

            #download human readable "File:..." resource redirecting to actual data
            htmlUrl="$baseUrl/File:$fileName"
            echo "Downloading html from url: $htmlUrl"
            curl $htmlUrl -o $tmpFileName

            #extract pointer to actual media
            #href="//upload.wikimedia.org/wikipedia/commons/6/6e/Chess_tile_pd.svg"
            mediaUrl="http:`xmllint $tmpFileName --xpath $xpathExpr`"
            echo "Downloading media from url: $mediaUrl"
            curl $mediaUrl -o $fileName

            echo
        done
    done
done

rm $tmpFileName

