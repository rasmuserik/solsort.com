phantomjs imcapture.js
for im in phantom-*.png;
do
    convert $im -geometry 300x200 `echo $im | sed -e s/phantom/app/`
    rm $im
done
