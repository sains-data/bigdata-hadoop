# 📁 Latihan Dasar Hadoop HDFS

Latihan ini bertujuan memberi pengalaman langsung dalam mengelola file di HDFS. Setelah latihan ini, Anda diharapkan memahami:
- Struktur direktori HDFS
- Penggunaan perintah dasar HDFS
- Cara mengatur hak akses dan memindahkan file antar direktori.

Manajemen file dan direktori di HDFS menggunakan perintah dasar seperti `mkdir`, `put`, `ls`, `cat`, `get`, `rm`, `du`, `chmod`, dan `mv`.

## 🖥 A. Hadoop Cluster

### ⚙️ Persiapan
Pastikan Hadoop sudah berjalan dan HDFS dalam keadaan aktif (`jps` menunjukkan `NameNode`, `DataNode`, dll).  

## 🧪 Latihan 1: Manajemen Direktori dan Upload File

**🎯 Tujuan:** Melatih penggunaan `mkdir`, `put`, `ls`, dan `cat`.

### 📌 Langkah-langkah:

1. **Buat direktori di HDFS**
   ```bash
   hdfs dfs -mkdir /latihan1
   ```

2. **Buat file teks di lokal**
   ```bash
   echo "Ini adalah file contoh pertama" > contoh.txt
   ```

3. **Upload file ke HDFS**
   ```bash
   hdfs dfs -put contoh.txt /latihan1
   ```

4. **Lihat isi direktori di HDFS**
   ```bash
   hdfs dfs -ls /latihan1
   ```

5. **Tampilkan isi file dari HDFS**
   ```bash
   hdfs dfs -cat /latihan1/contoh.txt
   ```

## 🧪 Latihan 2: Download & Hapus File

**🎯 Tujuan:** Melatih penggunaan `get`, `rm`.

### 📌 Langkah-langkah:

1. **Unduh file dari HDFS ke lokal**
   ```bash
   hdfs dfs -get /latihan1/contoh.txt
   ```

2. **Tampilkan isi file lokal**
   ```bash
   cat contoh.txt
   ```

3. **Hapus file dari HDFS**
   ```bash
   hdfs dfs -rm /latihan1/contoh.txt
   ```

4. **Pastikan file telah dihapus**
   ```bash
   hdfs dfs -ls /latihan1
   ```

## 🧪 Latihan 3: Analisis Ukuran dan Ubah Akses

**🎯 Tujuan:** Melatih penggunaan `du`, `chmod`, dan `mv`.

### 📌 Langkah-langkah:

1. **Upload ulang file (jika sudah dihapus)**  
   (atau buat ulang seperti Latihan 1)
   ```bash
   hdfs dfs -put contoh.txt /latihan1
   ```

2. **Tampilkan penggunaan ruang file**
   ```bash
   hdfs dfs -du /latihan1/contoh.txt
   ```

3. **Ubah permission file jadi read-only**
   ```bash
   hdfs dfs -chmod 444 /latihan1/contoh.txt
   ```

4. **Pindahkan file ke direktori baru**
   ```bash
   hdfs dfs -mkdir /latihan2
   hdfs dfs -mv /latihan1/contoh.txt /latihan2/
   ```

Berikut README lengkap untuk latihan **B. Wordcount MapReduce** menggunakan Hadoop:


# 📝 Latihan WordCount MapReduce

Latihan ini bertujuan memahami proses komputasi paralel di Hadoop dengan membuat program WordCount untuk menghitung frekuensi kemunculan kata dalam teks.

## 🎯 Tujuan

Program WordCount membaca teks dan menghitung berapa kali setiap kata muncul, menggunakan paradigma MapReduce.


## ⚙️ Langkah-Langkah

### 1. 🔑 Persiapan

#### a. Masuk ke container
Jika belum berada di dalam container Hadoop:
```bash
bash login.sh
```

#### b. Buat direktori kerja
```bash
mkdir -p /wordcount && cd /wordcount
```

### 2. 📄 Buat Program WordCount.java

Buat file baru:
```bash
nano WordCount.java
```
Lalu tempelkan kode pada file WordCount.java

### 3. ⚙️ Compile Program

#### a. Buat file input:
```bash
echo "halo dunia halo hadoop" > input.txt
mkdir input
mv input.txt input/
```

#### b. Kompilasi kode:
```bash
javac -classpath `$HADOOP_HOME/bin/hadoop classpath` -d . WordCount.java
```

#### c. Buat file JAR:
```bash
jar cf wordcount.jar WordCount*.class
```

### 4. ⬆️ Upload Data ke HDFS

```bash
hdfs dfs -mkdir -p /wordcount/input
hdfs dfs -put input/input.txt /wordcount/input/
```

### 5. 🚀 Jalankan WordCount Job

```bash
hadoop jar wordcount.jar WordCount /wordcount/input /wordcount/output
```

### 6. 📤 Cek Output

```bash
hdfs dfs -cat /wordcount/output/part-r-00000
```

Contoh hasil output:
```
dunia    1  
halo     2  
hadoop   1  
```

### 7. 🧹 (Opsional) Bersihkan Output

```bash
hdfs dfs -rm -r /wordcount
```