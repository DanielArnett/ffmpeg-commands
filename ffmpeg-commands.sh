#!/bin/bash

HVENC_ORIG_EXTENSION=.mp4 # Original Extension
HVENC_EXTENSION=.h265.mp4 # Extension of Output files
hvenc () {
        #ORIG_SIZE="$(find . -type f -name "*$HVENC_EXTENSION" -exec du -ch {} + | grep total$)"
        #NEW_SIZE="$(find . -type f -name "*$HVENC_EXTENSION" -not -name '*.h265.mp4' -exec du -ch {} + | grep total$)"
        #echo "This operation will reduce storage space used from $ORIG_SIZE down to $NEW_SIZE."
        if [ -z $1 ]; then
                FILELIST=*$HVENC_ORIG_EXTENSION
        else
                FILELIST=$1
        fi
        for i in $FILELIST ; do
                # If it contains the new extension skip it
                if [[ $i == *"$HVENC_EXTENSION" ]]; then
                        echo "Skipping $i"
                        continue
                fi
                # If it contains the old extension skip it
                if [[ -f "./$i$HVENC_EXTENSION" ]]; then
                        echo "./$i$HVENC_EXTENSION already exists. Skipping."
                        continue
                fi
                echo Converting $i
                # Perform the conversion
                ffmpeg.exe -i "./$i" -c:v hevc_nvenc -preset hq "./$i$HVENC_EXTENSION"
                # Copy the date created/date modified
                exiftool.exe -overwrite_original -tagsFromFile "./$i" -All:All "-FileCreateDate<FileCreateDate" "-FileModifyDate<FileModifyDate" "./$i$HVENC_EXTENSION"
        done
}

hvenc_delete_originals () {
        echo "The following files will be deleted:"
        for i in *$HVENC_ORIG_EXTENSION ; do
                # If it contains the new extension skip it
                if [[ $i == *"$HVENC_EXTENSION" ]]; then
                        continue
                fi
                # If it contains the old extension print it
                if [[ -f "./$i$HVENC_EXTENSION" ]]; then
                        echo $i
                        continue
                fi
        done
^__
        read -p "Are you sure you want to delete the above? " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
                for i in *$HVENC_ORIG_EXTENSION ; do
                        if [[ $i == *"$HVENC_EXTENSION" ]]; then
                                continue
                        fi
                        if [[ -f "./$i$HVENC_EXTENSION" ]]; then
                                echo Deleting $i
                                rm "$i"
                                continue
                        fi
                done
        fi
}

