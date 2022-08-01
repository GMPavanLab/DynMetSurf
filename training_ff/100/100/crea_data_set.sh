list="$(ls -1d 111 )"
for i in $list
do
echo $i
cd $i
mkdir all
mv *.raw all

#scegliere EV in modo da avere piu'o meno 1000 configurazioni per cartella.

EV=6

awk -v var=$EV '{if (NR%var==1) print $0}' all/coord.raw > coord.raw
awk -v var=$EV '{if (NR%var==1) print $0}' all/force.raw > force.raw
awk -v var=$EV '{if (NR%var==1) print $0}' all/energy.raw > energy.raw
awk -v var=$EV '{if (NR%var==1) print $0}' all/box.raw > box.raw

wc -l *.raw
nconf="$(cat energy.raw | wc -l)"

ntest="$(echo "0.1*$nconf" | bc -l)"
ntrain="$(echo "$nconf-$ntest" | bc -l)"

nconfset="$(echo "$ntrain/2" | bc )"
echo $nconf $ntest $ntrain $nconfset

./dpmd_create_datasets $nconfset

#creiamo due cartelle una contenente i dati per il training data_0 e una per il testing data_1 
mkdir data_0
mkdir data_1

mv set.000 set.001 data_0
mv set.002 data_1/set.000 

cp all/type.raw data_0
cp all/type.raw data_1

cd ..
done
