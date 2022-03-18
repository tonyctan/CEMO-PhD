for i in *.txt; do
    mv "$i" "${i%.*}_B1.txt";
done
