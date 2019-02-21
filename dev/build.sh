#!/bin/bash
STORAGE_ENGINES=("fizzbuzz")
for engine in ${STORAGE_ENGINES[@]}; do
    make -j4 ${engine}
done
cp plugin_output_directory/ha_*.so /usr/lib/mysql/plugin/
