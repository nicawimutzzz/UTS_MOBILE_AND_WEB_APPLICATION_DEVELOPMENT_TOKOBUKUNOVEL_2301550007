import React from "react";
import { AbsoluteFill, Audio, staticFile, useCurrentFrame, interpolate } from "remotion";
import { COLORS } from "../theme";
import { SlideLayout, Card, AnimatedText } from "../components/SlideLayout";

export const Scene03Target: React.FC = () => {
  const frame = useCurrentFrame();

  return (
    <SlideLayout title="Target Pengguna & User Stories">
      <Audio src={staticFile("audio/scene03.mp3")} />

      <div style={{ display: "flex", gap: 30, marginTop: 20, flex: 1 }}>
        {/* Left panel: Persona */}
        <div style={{ flex: 1 }}>
          <div
            style={{
              fontSize: 24,
              fontWeight: 600,
              color: COLORS.primary,
              fontFamily: "sans-serif",
              marginBottom: 16,
              opacity: interpolate(frame, [10, 30], [0, 1], {
                extrapolateLeft: "clamp",
                extrapolateRight: "clamp",
              }),
            }}
          >
            Persona Pengguna
          </div>

          <Card startFrame={20}>
            <div style={{ display: "flex", alignItems: "center", gap: 12, marginBottom: 12 }}>
              <span style={{ fontSize: 40 }}>👤</span>
              <span style={{ fontSize: 22, fontWeight: 600, color: COLORS.textDark, fontFamily: "sans-serif" }}>
                Pegawai Toko Buku
              </span>
            </div>
            <div style={{ fontSize: 18, color: COLORS.textSecondary, fontFamily: "sans-serif", lineHeight: 1.6 }}>
              <div>• Melayani pembeli di counter toko</div>
              <div>• Menggunakan ponsel atau komputer</div>
              <div>• Butuh: catat transaksi cepat, cek stok</div>
            </div>
          </Card>

          <div style={{ height: 16 }} />

          <Card startFrame={50}>
            <div style={{ display: "flex", alignItems: "center", gap: 12, marginBottom: 12 }}>
              <span style={{ fontSize: 40 }}>👩‍💼</span>
              <span style={{ fontSize: 22, fontWeight: 600, color: COLORS.textDark, fontFamily: "sans-serif" }}>
                Pemilik Toko
              </span>
            </div>
            <div style={{ fontSize: 18, color: COLORS.textSecondary, fontFamily: "sans-serif", lineHeight: 1.6 }}>
              <div>• Mengelola katalog buku</div>
              <div>• Melihat laporan penjualan</div>
              <div>• Butuh: evaluasi pendapatan, stok</div>
            </div>
          </Card>
        </div>

        {/* Right panel: User Stories */}
        <div style={{ flex: 1.2 }}>
          <div
            style={{
              fontSize: 24,
              fontWeight: 600,
              color: COLORS.primary,
              fontFamily: "sans-serif",
              marginBottom: 16,
              opacity: interpolate(frame, [30, 50], [0, 1], {
                extrapolateLeft: "clamp",
                extrapolateRight: "clamp",
              }),
            }}
          >
            5 User Stories
          </div>

          <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
            {[
              { num: "1", text: "Sebagai pemilik, mengelola data buku (CRUD) agar katalog tersimpan digital", delay: 60 },
              { num: "2", text: "Sebagai pegawai, mencari buku berdasarkan judul/penulis", delay: 90 },
              { num: "3", text: "Sebagai pegawai, mencatat transaksi sehingga stok terbarui otomatis", delay: 120 },
              { num: "4", text: "Sebagai pemilik, melihat laporan penjualan", delay: 150 },
              { num: "5", text: "Sebagai pemilik, melihat jumlah stok untuk mencegah kehabisan", delay: 180 },
            ].map((story) => (
              <div
                key={story.num}
                style={{
                  display: "flex",
                  gap: 12,
                  opacity: interpolate(frame, [story.delay, story.delay + 20], [0, 1], {
                    extrapolateLeft: "clamp",
                    extrapolateRight: "clamp",
                  }),
                  transform: `translateX(${interpolate(frame, [story.delay, story.delay + 20], [30, 0], {
                    extrapolateLeft: "clamp",
                    extrapolateRight: "clamp",
                  })}px)`,
                }}
              >
                <div
                  style={{
                    width: 36,
                    height: 36,
                    borderRadius: "50%",
                    backgroundColor: COLORS.primary,
                    color: COLORS.white,
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                    fontSize: 18,
                    fontWeight: 700,
                    fontFamily: "sans-serif",
                    flexShrink: 0,
                  }}
                >
                  {story.num}
                </div>
                <div
                  style={{
                    fontSize: 18,
                    color: COLORS.textDark,
                    fontFamily: "sans-serif",
                    lineHeight: 1.5,
                    paddingTop: 4,
                  }}
                >
                  {story.text}
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </SlideLayout>
  );
};
