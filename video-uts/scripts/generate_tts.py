"""
Generate TTS audio for UTS video - Toko Buku Novel
Uses edge-tts (free Microsoft Edge TTS, no API key needed)
Voice: id-ID-GadisNeural (Indonesian female)
"""
import asyncio
import edge_tts
import os
import json

VOICE = "id-ID-GadisNeural"
OUTPUT_DIR = os.path.join(os.path.dirname(__file__), "..", "public", "audio")
OUTPUT_DIR = os.path.normpath(OUTPUT_DIR)

# Narration script for 7 scenes
# Each scene text is designed to fit the target duration when spoken at normal speed
SCENES = [
    {
        "id": "scene01",
        "title": "Pembuka",
        "text": """Selamat siang. Perkenalkan, nama saya Annisa Asti Indriyani, NIM dua tiga nol satu lima lima nol nol nol tujuh, dari Kelas A satu. Pada presentasi Ujian Tengah Semester mata kuliah Mobile and Web Application Development ini, saya akan memperkenalkan prototype aplikasi yang saya bangun, yaitu Toko Buku Novel. Aplikasi ini adalah kasir dan katalog untuk toko buku novel yang dibangun menggunakan Flutter.""",
    },
    {
        "id": "scene02",
        "title": "Masalah",
        "text": """Masalah yang saya identifikasi adalah pemilik dan pegawai toko buku novel mengalami kesulitan dalam mencatat transaksi penjualan, memperbarui stok, dan membuat laporan ketika toko melayani pembeli secara langsung. Pencatatan yang masih dilakukan menggunakan buku manual membutuhkan waktu lama, rentan kesalahan, dan data mudah hilang. Laporan penjualan juga sulit dibuat dengan cepat karena harus menyalin data dari catatan manual. Pegawai toko kesulitan melayani pembeli dengan cepat karena harus memeriksa stok secara manual. Masalah ini menyebabkan data penjualan mudah salah, stok tidak terbarui, dan laporan membutuhkan waktu lama untuk dibuat.""",
    },
    {
        "id": "scene03",
        "title": "Target dan Pengguna",
        "text": """Pengguna utama aplikasi ini adalah pegawai toko buku yang menggunakan aplikasi saat melayani pembeli di counter, serta pemilik toko yang ingin melihat laporan dan mengelola katalog. Pegawai membutuhkan aplikasi yang dapat mencatat transaksi dengan cepat dan memeriksa stok. Pemilik membutuhkan laporan penjualan untuk evaluasi usaha. Saya membuat lima user story yang menjadi dasar pengembangan. Pertama, sebagai pemilik, saya ingin mengelola data buku agar katalog tersimpan digital. Kedua, sebagai pegawai, mencari buku dengan cepat. Ketiga, mencatat transaksi sehingga stok terbarui otomatis. Keempat, melihat laporan penjualan. Kelima, melihat jumlah stok untuk mencegah kehabisan.""",
    },
    {
        "id": "scene04",
        "title": "Scope dan Prioritas",
        "text": """Berdasarkan masalah tersebut, saya menentukan kebutuhan fungsional dengan metode MoSCoW. Untuk prioritas Must, yaitu kelola data buku, catat transaksi penjualan, perbarui stok otomatis, dan tampilan responsif untuk mobile dan web. Untuk prioritas Should, yaitu laporan penjualan dengan filter tanggal dan login email password. Untuk prioritas Could yang belum diimplementasi sekarang, yaitu pre-order dan wishlist. Semua fitur Must telah diimplementasikan di prototype ini. Aplikasi memiliki sembilan halaman dengan navigasi Bottom Navigation Bar empat tab, yaitu Beranda, Buku, Transaksi, dan Laporan. Fitur Must diprioritaskan karena merupakan alur bisnis inti toko buku. Tanpa ketiga fitur ini, aplikasi tidak dapat menyelesaikan masalah utama yaitu pencatatan transaksi yang akurat dan cepat.""",
    },
    {
        "id": "scene05",
        "title": "Rancangan",
        "text": """Untuk rancangan, wireframe saya buat di Figma dengan tujuh frame mobile, dua keadaan alternatif yaitu galat dan kosong, serta dua frame web. Saya menerapkan style guide mini dengan warna primer hijau, tipografi Poppins, tombol minimum empat puluh delapan pixel tinggi. Penilaian Figma dari dosen mendapat skor sembilan puluh delapan dari seratus, tertinggi sekelas. Untuk rancangan database Firestore, saya menggunakan empat collection. Pertama, books untuk data buku dengan field judul, penulis, kategori, harga, stok. Kedua, transactions untuk transaksi dengan array items, total, dan tanggal. Ketiga, users untuk data pengguna. Keempat, categories untuk kategori buku. Saat ini data masih di memori atau local-first, tetapi arsitektur Repository Pattern sudah memungkinkan migrasi ke Firestore tanpa mengubah UI. Tech stack yang digunakan adalah Flutter dan Dart untuk aplikasi, Provider untuk state management, Firebase untuk autentikasi dan database, serta GitHub untuk version control.""",
    },
    {
        "id": "scene06",
        "title": "Demo Prototype",
        "text": """Berikut demo prototype aplikasi Toko Buku Novel. Dimulai dari halaman Login, pengguna memasukkan email dan kata sandi. Setelah login, tampil halaman Beranda yang menampilkan ringkasan jumlah buku, jumlah transaksi, dan total pendapatan. Tab Buku menampilkan daftar buku dengan fitur pencarian berdasarkan judul atau penulis. Klik salah satu buku untuk melihat detail lengkap. Form Tambah Buku memiliki validasi untuk kolom judul, penulis, kategori, harga, dan stok. Jika kolom kosong, muncul pesan kesalahan. Tab Transaksi memungkinkan memilih buku, atur jumlah, dan checkout. Jika stok tidak mencukupi, sistem menampilkan pesan. Setelah transaksi disimpan, stok berkurang otomatis. Tab Laporan menampilkan rekap transaksi dengan filter rentang tanggal.""",
    },
    {
        "id": "scene07",
        "title": "Penutup",
        "text":"""Untuk rencana pengembangan lanjutan, pada pertemuan kesembilan akan dilakukan migrasi data ke Firebase Firestore. Pertemuan kesepuluh, Firebase Authentication untuk login yang sebenarnya. Pertemuan kesebelas, menambah fitur Should yaitu Lupa Sandi dan Profil. Pertemuan keduabelas, optimasi responsif web. Pertemuan kelimabelas, deploy ke Firebase Hosting. Demikian presentasi UTS dari saya. Terima kasih.""",
    },
]

async def generate_audio(scene, output_dir):
    text = scene["text"].strip()
    output_file = os.path.join(output_dir, f"{scene['id']}.mp3")
    
    communicate = edge_tts.Communicate(text, VOICE)
    await communicate.save(output_file)
    
    # Get duration using edge-tts (we'll estimate from file)
    file_size = os.path.getsize(output_file)
    print(f"  Generated: {scene['id']}.mp3 ({file_size:,} bytes)")
    return output_file

async def main():
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    print(f"Generating TTS audio with voice: {VOICE}")
    print(f"Output directory: {OUTPUT_DIR}")
    print(f"Total scenes: {len(SCENES)}\n")
    
    durations = {}
    
    for scene in SCENES:
        print(f"Scene: {scene['title']}")
        filepath = await generate_audio(scene, OUTPUT_DIR)
        durations[scene["id"]] = {
            "title": scene["title"],
            "file": f"audio/{scene['id']}.mp3",
        }
    
    # Save metadata
    meta_path = os.path.join(OUTPUT_DIR, "metadata.json")
    with open(meta_path, "w", encoding="utf-8") as f:
        json.dump(durations, f, indent=2, ensure_ascii=False)
    
    print(f"\nMetadata saved to: {meta_path}")
    print(f"All {len(SCENES)} audio files generated successfully!")

if __name__ == "__main__":
    asyncio.run(main())
