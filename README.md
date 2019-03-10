# Palermo: un meraviglioso viaggio nel tempo grazie alla Biblioteca Comunale di Palermo

La **Biblioteca Comunale di Palermo** dal 26 ottobre del 2017 ha iniziato a pubblicare su **Flickr** alcune foto della Collezione fotografica di **Enrico Di Benedetto**, scattate a **Palermo** tra il **XIX** ed il **XX** **secolo**, tutte pubblicate con una **licenza aperta** che ne consente il **riuso**.

Da quel giorno ne sono state pubblicate **poco più di 800** e questa collezione oggi è un **archivio** a suo modo **unico**, dal grande **valore** **simbolico** e **culturale**.

A me lascia senza fiato vedere ad esempio la [galleria dedicata alla "Cala"](https://www.flickr.com/photos/biblioteca-comunale-palermo/albums/72157688389942214), l'attuale porto turistico della città, nonché il più antico porto di Palermo. E questa foto denominata "**Imbarco-Emigranti**", di circa 100 anni fa, merita di essere guardata e riguardata.

![](https://farm5.staticflickr.com/4468/26260490989_dc9bf10f49_h.jpg)

## Note sull'archivio

L'archivio è composto da queste 20 gallerie:

- [Palermo, la Marina](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157663333525298)
- [Palermo, le Piazze](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157666391675469)
- [Palermo, il Palazzo Reale](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157668271638498)
- [Palermo, le Vie](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157687154069622)
- [Palermo, le Porte](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157687308321742)
- [Palermo, il Porto](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157687801943471)
- [Palermo, la Cala](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157688389942214)
- [Palermo, la Zisa](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157689677139110)
- [Palermo, Sant'Erasmo](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157690260513735)
- [Palermo, le vie dell'Acqua](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157691908983201)
- [Palermo, disastro via Lattarini](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157691909423261)
- [Palermo, lo Statuto](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157691910775161)
- [Palermo, la Kalsa](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157692911450514)
- [Palermo, la Cuba](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157695748130741)
- [Palermo, i Palazzi](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157696025498881)
- [Palermo, i Teatri](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157696738809002)
- [Palermo, i Caffè e i ristoranti](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157696870242730)
- [Palermo, gli Alberghi](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157697070534502)
- [Palermo, Ville e dimore storiche](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157698240123224)
- [Palermo, Parchi e Ville](https://www.flickr.com/photos/biblioteca-comunale-palermo/sets/72157704964923074)

Ogni foto è associata a un "corredo informativo" costituito da: titolo, posizione geografica, gallerie di appartenenza, _tag_, licenza e metadati (non sono dati presenti in tutte le foto, ma nella grandissima parte).

La **posizione geografica** viene inserita sfruttando una delle caratteristiche native di Flickr che consente di associare una foto a una posizione su mappa. Una volta fatto, all'elemento viene associata una struttura dati di questo tipo, in cui oltre alla coppia di coordinate è presente un'informazione geografica gerarchica (`Italia > Sicilia > Palermo`).

```json
"location": {
      "latitude": "38.119297",
      "longitude": "13.369009",
      "accuracy": "15",
      "context": "0",
      "locality": {
        "_content": "Palermo",
        "place_id": "PbK4XUNWU7MEzP8",
        "woeid": "719846"
      },
      "county": {
        "_content": "Palermo",
        "place_id": "0EWJ0T9QUL93x0JxkQ",
        "woeid": "12591846"
      },
      "region": {
        "_content": "Sicilia",
        "place_id": "e_a_hC9WU78dOVeI",
        "woeid": "7153344"
      },
      "country": {
        "_content": "Italia",
        "place_id": "5QqgvRVTUb7tSzaDpQ",
        "woeid": "23424853"
      },
      "place_id": "PbK4XUNWU7MEzP8",
      "woeid": "719846"
    },
    "geoperms": {
      "ispublic": 1,
      "iscontact": 0,
      "isfriend": 0,
      "isfamily": 0
    }
```

Per i **metadati** lo staff della Biblioteca ha accettato una nostra proposta (vedi paragrafo successivo). Flickr infatti non consente di metadatare in modo strutturato una foto, associargli un identificativo, un autore, un editore, la pagina, ecc. e l'unica possibilità per inserire informazioni di questo tipo è quella di sfruttare lo spazio per le note testuali. <br>
E questo è il modo scelto (immagine di sotto) per il meraviglioso [**archivio della British Library**](https://www.flickr.com/photos/britishlibrary/).

![](https://i.imgur.com/IRuGPQ3.png)

Abbiamo aggiunto un elemento: inserire il testo della nota in una modalità che fosse nativamente **non soltanto** una nota **da leggere** a video, ma anche un **testo strutturato _machine readable_**, trasformabile in una banca dati da interrogare, analizzare e trasformare.<br>
E allora le note sono in [`YAML`](https://yaml.org/), un formato che è sia _human_ che _machine readable_.

Ad ogni foto sono quindi associate informazioni con questa struttura tipo:

```yaml
### inizio descrizione ###
- Title: "Palermo - Alla Cala"
- Editor: ""
- Author: "Di Benedetto, Enrico"
- Contributor: "Collezione del Fondo Di Benedetto"
- shelfmark: "Biblioteca comunale di Palermo - Sezione manoscritti e rari"
- page: "9"
- place of Publishing: "pp. 418. E. Di Benedetto: Palermo - varia XIX – XX secolo"
- year of Publishing: ""
- issuance: "collezione"
- identifier: "VI (9)"
- licence: "CC BY SA 4.0"
- geographic place: "La Cala, porto, porta Carbone, Palermo"
- city: "Palermo"
### fine descrizione ###
```

È leggibile chiaramente da un essere umano e contemporaneamente si può trasformare in **dati "leggibili da una macchina"**, sfruttando una qualsiasi libreria/modulo in grado di interpretare un testo `YAML`. Con [`yq`](https://yq.readthedocs.io) ad esempio trasformo la stringa di input di sopra con `<input.yaml yq '.|add'`, per avere indietro un "classica" rappresentazione ` JSON`:

```json
{
  "Title": "Palermo - Alla Cala",
  "Editor": "",
  "Author": "Di Benedetto, Enrico",
  "Contributor": "Collezione del Fondo Di Benedetto",
  "shelfmark": "Biblioteca comunale di Palermo - Sezione manoscritti e rari",
  "page": "9",
  "place of Publishing": "pp. 418. E. Di Benedetto: Palermo - varia XIX – XX secolo",
  "year of Publishing": "",
  "issuance": "collezione",
  "identifier": "VI (9)",
  "licence": "CC BY SA 4.0",
  "geographic place": "La Cala, porto, porta Carbone, Palermo",
  "city": "Palermo"
}
```

Nella struttura YAML c'è un errore (a causa di un mio suggerimento errato) - non ci dovrebbero essere i "trattini" che fanno da punto elenco - che per fortuna però non ha conseguenze sulla lettura dei dati.<br>
Flickr inoltre fa un _encoding_ dei caratteri inseriti nel campo note (gli "a capo" diventano `\n`, le virgolette `&quot;`, ecc.), ma basta saperlo e prendere le "contromisure" via _script_, per riportare il testo a una struttura `YAML` corretta.

## Come nasce

Qui in OpenDataSicilia diverse persone hanno mostrato nel tempo interesse verso il riuso del patrimonio fotografico della Biblioteca Comunale di Palermo. Tra i primi [Giulio Di Chiara](https://twitter.com/giuliodichiara) e [Ciro Spataro](https://twitter.com/cirospat), che nel tempo hanno fatto diversi tentativi per porre in essere la cosa.

Quello riuscito, che ha portato a quanto descritto sopra, parte da un'email di Ciro di settembre del 2017, che scrive a me e al [Prof. Taibi](https://twitter.com/dataibi) queste parole

> [...] poniamo che l'Archivio Storico comunale e la Biblioteca comunale si convinca a creare un profilo FLICKR per postare migliaia di immagini frutto di scansioni di carte e manufatti storici e artistici su Palermo e la Sicilia custodite dentro le due strutture. Per valorizzare pubblicamente il patrimonio custodito, insomma open data. Così come fanno a Londra, a New York le Biblioteche pubbliche [...]

Da lì parte uno scambio ricco tra Ciro, Davide, me e la Biblioteca, che ha portato in pochi giorni all'inizio della pubblicazione delle foto su Flickr.

## Dati

Flickr consente l'accesso ai suoi dati tramite delle [**ricche API**](https://www.flickr.com/services/api/). Per usarle è necessario usare una `API key`, ottenuta la quale è possibile interrogarle con semplicità.

Un esempio è [questo script `bash`](./fotoComunePalermo.sh) - "bruttino", perché molto ottimizzabile - che interroga le API per restituire:

- l'elenco [degli URL di ogni foto](./report/download.csv);
- l'elenco [delle coordinate](./report/coordinate.csv) associate alle foto;
- l'elenco [degli album](./report/album.csv) associati alle foto;
- i [metadati](./report/lista.csv) associati alle foto;
- un [file](./report/output.csv) che mette insieme coordinate e metadati.

Nota bene: da circa 10 foto non risultano estratti metadati, perché ci sono dei piccoli errori di struttura nel testo sorgente.

## Note conclusive

Quanto fatto dalla **Biblioteca Comunale di Palermo** è un esempio di valore: è facilmente **replicabile**, non costringe a **rivoluzionare procedure interne**, ha dei **costi sostenibili**, **restituisce** un **bene comune digitale** **prezioso** ed è **pronto al riuso** di persone e "macchine".

Non è perfetto e si può fare (come sempre) di più e meglio, ma il progetto merita un plauso e un passaparola.

Nei prossimi giorni ci saranno delle **sorprese** 🎉🎉, degli esempi di **riutilizzo** di questi **dati**.