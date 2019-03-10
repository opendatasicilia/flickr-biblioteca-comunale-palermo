#!/bin/bash

set -x

cartella="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# leggi flickr API key
source "$cartella"/config

input="$cartella"/lista.txt

# cancella dati raccolti
rm "$cartella"/lista.txt
rm "$cartella"/dati/*
rm "$cartella"/dati/album/*
rm "$cartella"/dati/foto/*

urlbase="https://api.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=$flickrAPI&user_id=140129279@N05&format=json&nojsoncallback=1"

# calcola il numero di richieste "pagina" da fare (si possono chiedere 500 foto alla volta)
pagine=$(echo "($(echo "$(curl $urlbase | jq -r '.photos.total')/500" | bc -l)+0.5)/1" | bc)

# scarica di 500 in 500 la lista delle foto
for i in $(seq 1 $pagine); do
  curl "https://api.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=$flickrAPI&user_id=140129279@N05&format=json&nojsoncallback=1&per_page=500&page=$i" >"$cartella"/dati/tmp_p"$i".json
done

# crea l'indice con gli ID di tutte le foto
for i in "$cartella"/dati/*.json; do
    <"$i" jq -r ".photos.photo[].id" >>./lista.txt
done

# cancella file temporanei
rm "$cartella"/dati/tmp_*.json

mkdir -p "$cartella"/dati
mkdir -p "$cartella"/dati/album
mkdir -p "$cartella"/dati/foto

# scarica il JSON con i dettagli di ogni foto
while IFS= read -r var
do
  curl "https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=$flickrAPI&photo_id=$var&format=json&nojsoncallback=1" | jq . >"$cartella"/dati/foto/"$var".json
done < "$input"

### download delle foto ###

rm "$cartella"/dati/foto/download.txt

# per ogni foto recupera l'URL di download
while IFS= read -r var
do
  curl "https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=$flickrAPI&photo_id=$var&format=json&nojsoncallback=1" | jq '.sizes.size[]|select(.label | contains("Original")) | {nome:'"$var"',url:.source}' >>"$cartella"/dati/foto/download.txt
done < "$input"

# converti in CSV la lista degli URL di download
mlr --j2c cat "$cartella"/dati/foto/download.txt >"$cartella"/dati/foto/download.csv
# rimuovi riga intestazione
tail -n +2 "$cartella"/dati/foto/download.csv >"$cartella"/dati/foto/download_raw.csv

# fai il download delle foto

while IFS=, read -r col1 col2
do
    wget -O "$cartella"/dati/foto/"$col1".jpg "$col2"
done < "$cartella"/dati/foto/download_raw.csv

### info sugli album ###

# recupera per ogni foto gli le info sugli album a cui è eventualmente associata

rm "$cartella"/dati/album/*.json
while IFS= read -r var
do
  curl "https://api.flickr.com/services/rest/?method=flickr.photos.getAllContexts&api_key=$flickrAPI&photo_id=$var&format=json&nojsoncallback=1" | jq '.set[]|.+{risorsa:"'"$var"'"}' >"$cartella"/dati/album/"$var"_album.json
done < "$input"


# fai il merge dei file con le info sugli album a cui è eventualmente associata ogni foto
cat "$cartella"/dati/album/*.json >"$cartella"/dati/album.json

# trasforma in CSV il file con le info sugli album a cui è eventualmente associata ogni foto
mlr --j2c unsparsify --fill-with "" "$cartella"/dati/album.json >"$cartella"/dati/album.csv


# recupera info dettaglio di ogni album
for i in "$cartella"/dati/*album.json; do grep -P '"id"' "$i" | grep -oP '[0-9]{17}'; done | sort | uniq >"$cartella"/dati/album.txt

while IFS= read -r var
do
  curl "https://api.flickr.com/services/rest/?method=flickr.photosets.getInfo&api_key=$flickrAPI&photoset_id=$var&user_id=140129279@N05&format=json&nojsoncallback=1" | jq . >"$cartella"/dati/"$var"_albumInfo.json
done < "$cartella"/dati/album.txt

# recupera lista foto per album
while IFS= read -r var
do
  curl "https://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=$flickrAPI&photoset_id=$var&user_id=140129279@N05&per_page=500&extras=license,date_upload,date_taken,owner_name,icon_server,original_format,last_update,geo,tags,machine_tags,o_dims,views,media,path_alias,url_sq,url_t,url_s,url_m,url_o&format=json&nojsoncallback=1" | jq . >"$cartella"/dati/"$var"_albumLista.json
done < "$cartella"/dati/album.txt

# estrai metadati foto
rm "$cartella"/dati/foto/lista.json
cd "$cartella"/dati/foto
for i in ./[0-9]*.json;do 
    <"$i" jq '.photo.description._content' | perl -pe 's/\\n/\n/g' | sed 's/&quot;/"/g;s/”/"/g' | sed -r 's/^ +-/-/g'  | grep -E '^-' | yq '.|add|.+ {"risorsa":"'"$i"'"}' >>"$cartella"/dati/foto/lista.json
done

# converti i metadati in CSV
cd "$cartella"/dati/foto
mlr --j2c put -S 'for (key,value in $*) {$[tolower(key)]=value}' then unsparsify --fill-with "" then cut -r -x -f ".*[A-Z].*" ./lista.json  >./lista.csv

sed -i 's|\./||g;s|\.json||g' "$cartella"/dati/foto/lista.csv

# estrai coordinate da info file
rm "$cartella"/dati/foto/coordinate.json
cd "$cartella"/dati/foto
for i in ./[0-9]*.json;do 
   jq '.photo.location|{latitude:.latitude,longitude:.longitude,risorsa:"'"$i"'"}' "$i" >>"$cartella"/dati/foto/coordinate.json
done

# converti file con info coordinate in CSV
mlr --j2c filter -S -x '$latitude==""' "$cartella"/dati/foto/coordinate.json >"$cartella"/dati/foto/coordinate.csv
sed -i 's|\./||g;s|\.json||g' "$cartella"/dati/foto/coordinate.csv

# sposta dati album in cartella album
cd "$cartella"/dati
mv ./*album* "$cartella"/dati/album

cd "$cartella"
mv ./lista* "$cartella"/dati/

# crea cartella report
mkdir -p "$cartella"/report
cp "$cartella"/dati/album/album.csv "$cartella"/report/
cp "$cartella"/dati/foto/coordinate.csv "$cartella"/report/
cp "$cartella"/dati/foto/download.csv "$cartella"/report/
cp "$cartella"/dati/foto/lista.csv "$cartella"/report/

sed -i 's/nome/risorsa/g' "$cartella"/report/download.csv

mlr --csv join --ul -j risorsa  -f "$cartella"/report/download.csv then unsparsify --fill-with "" "$cartella"/report/lista.csv >./"$cartella"/report/tmp_01.csv
mlr --csv join --ul -j risorsa  -f "$cartella"/report/tmp_01.csv then unsparsify --fill-with "" "$cartella"/report/coordinate.csv >"$cartella"/report/output.csv

rm "$cartella"/report/tmp*

# aggiungi URL pagina foto
mlr -I --csv put '$href="https://www.flickr.com/photos/biblioteca-comunale-palermo/" . $risorsa' "$cartella"/report/output.csv
mlr -I --csv clean-whitespace "$cartella"/report/output.csv
