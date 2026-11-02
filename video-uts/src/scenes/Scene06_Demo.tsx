import React from "react";
import { AbsoluteFill, Audio, staticFile, useCurrentFrame, interpolate, Easing } from "remotion";
import { COLORS } from "../theme";
import { SlideLayout } from "../components/SlideLayout";

export const Scene06Demo: React.FC = () => {
  const frame = useCurrentFrame();

  // 7 demo screenshots cycle through
  const demos = [
    { title: "1. Halaman Login", desc: "Input email & kata sandi", startFrame: 15, duration: 270 },
    { title: "2. Beranda Dashboard", desc: "Ringkasan: jumlah buku, transaksi, pendapatan", startFrame: 285, duration: 270 },
    { title: "3. Daftar Buku + Pencarian", desc: "Cari berdasarkan judul/penulis", startFrame: 555, duration: 270 },
    { title: "4. Detail Buku", desc: "Sampul, judul, harga, stok, deskripsi", startFrame: 825, duration: 270 },
    { title: "5. Form Tambah Buku", desc: "Validasi: judul, penulis, kategori, harga, stok", startFrame: 1095, duration: 270 },
    { title: "6. Transaksi Penjualan", desc: "Keranjang + checkout, stok berkurang otomatis", startFrame: 1365, duration: 270 },
    { title: "7. Laporan Penjualan", desc: "Rekap + filter rentang tanggal", startFrame: 1635, duration: 270 },
  ];

  // Determine which demo is currently showing
  const currentDemoIndex = demos.findIndex((d) => {
    const end = d.startFrame + d.duration;
    return frame >= d.startFrame && frame < end;
  });

  return (
    <SlideLayout title="Demo Prototype">
      <Audio src={staticFile("audio/scene06.mp3")} />

      <div
        style={{
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
          justifyContent: "center",
          flex: 1,
          gap: 20,
        }}
      >
        {currentDemoIndex >= 0 && (
          <DemoCard demo={demos[currentDemoIndex]} frame={frame} />
        )}

        {/* Demo progress indicators */}
        <div style={{ display: "flex", gap: 8, marginTop: 20 }}>
          {demos.map((demo, i) => {
            const isActive = i === currentDemoIndex;
            const isDone = frame >= demo.startFrame + demo.duration;
            return (
              <div
                key={i}
                style={{
                  width: isActive ? 40 : 12,
                  height: 8,
                  borderRadius: 4,
                  backgroundColor: isActive
                    ? COLORS.primary
                    : isDone
                    ? COLORS.primaryLight
                    : COLORS.lightGray,
                  transition: "all 0.3s",
                }}
              />
            );
          })}
        </div>
      </div>
    </SlideLayout>
  );
};

const DemoCard: React.FC<{
  demo: { title: string; desc: string; startFrame: number; duration: number };
  frame: number;
}> = ({ demo, frame }) => {
  const localFrame = frame - demo.startFrame;

  const opacity = interpolate(
    localFrame,
    [0, 15, demo.duration - 15, demo.duration],
    [0, 1, 1, 0],
    { extrapolateLeft: "clamp", extrapolateRight: "clamp" }
  );

  const scale = interpolate(
    localFrame,
    [0, 20],
    [0.9, 1],
    { extrapolateLeft: "clamp", extrapolateRight: "clamp", easing: Easing.out(Easing.cubic) }
  );

  return (
    <div
      style={{
        opacity,
        transform: `scale(${scale})`,
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        gap: 16,
      }}
    >
      {/* Phone mockup frame */}
      <div
        style={{
          width: 360,
          height: 500,
          borderRadius: 24,
          border: `4px solid ${COLORS.primaryDark}`,
          backgroundColor: COLORS.white,
          display: "flex",
          flexDirection: "column",
          overflow: "hidden",
          boxShadow: "0 8px 24px rgba(0,0,0,0.15)",
        }}
      >
        {/* Phone status bar */}
        <div
          style={{
            height: 24,
            backgroundColor: COLORS.primaryDark,
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
          }}
        >
          <div style={{ width: 60, height: 4, borderRadius: 2, backgroundColor: "rgba(255,255,255,0.3)" }} />
        </div>

        {/* Phone content area — simplified UI mockup */}
        <div
          style={{
            flex: 1,
            display: "flex",
            flexDirection: "column",
            padding: 20,
            gap: 12,
          }}
        >
          <PhoneMockupContent demoTitle={demo.title} />
        </div>
      </div>

      {/* Caption */}
      <div style={{ textAlign: "center" }}>
        <div style={{ fontSize: 24, fontWeight: 600, color: COLORS.primary, fontFamily: "sans-serif" }}>
          {demo.title}
        </div>
        <div style={{ fontSize: 18, color: COLORS.textSecondary, fontFamily: "sans-serif", marginTop: 4 }}>
          {demo.desc}
        </div>
      </div>
    </div>
  );
};

// Simplified phone UI mockup based on which demo is showing
const PhoneMockupContent: React.FC<{ demoTitle: string }> = ({ demoTitle }) => {
  if (demoTitle.includes("Login")) {
    return (
      <>
        <div style={{ fontSize: 24, fontWeight: 700, color: COLORS.primary, textAlign: "center", marginTop: 20 }}>Toko Buku Novel</div>
        <MockInput label="Email" />
        <MockInput label="Kata Sandi" />
        <MockButton label="Masuk" />
      </>
    );
  }
  if (demoTitle.includes("Beranda")) {
    return (
      <>
        <div style={{ fontSize: 18, fontWeight: 600, color: COLORS.primary }}>Beranda</div>
        <div style={{ display: "flex", gap: 8 }}>
          <MockStat label="Buku" value="12" />
          <MockStat label="Transaksi" value="5" />
        </div>
        <MockStat label="Pendapatan" value="Rp 450K" wide />
        <MockButton label="Lihat Buku" small />
      </>
    );
  }
  if (demoTitle.includes("Daftar")) {
    return (
      <>
        <div style={{ fontSize: 18, fontWeight: 600, color: COLORS.primary }}>Daftar Buku</div>
        <div style={{ height: 32, borderRadius: 8, border: `1px solid ${COLORS.lightGray}`, display: "flex", alignItems: "center", paddingLeft: 12, fontSize: 14, color: COLORS.midGray }}>🔍 Cari buku...</div>
        {[1, 2, 3].map((i) => (
          <div key={i} style={{ display: "flex", gap: 8, padding: 8, borderRadius: 8, backgroundColor: COLORS.offWhite }}>
            <div style={{ width: 40, height: 50, borderRadius: 4, backgroundColor: COLORS.primaryLight }} />
            <div style={{ flex: 1 }}>
              <div style={{ fontSize: 13, fontWeight: 600 }}>Laskar Pelangi {i}</div>
              <div style={{ fontSize: 11, color: COLORS.midGray }}>Rp 75.000 · Stok: {5 - i}</div>
            </div>
          </div>
        ))}
      </>
    );
  }
  if (demoTitle.includes("Detail")) {
    return (
      <>
        <div style={{ fontSize: 18, fontWeight: 600, color: COLORS.primary }}>Detail Buku</div>
        <div style={{ width: 80, height: 110, borderRadius: 8, backgroundColor: COLORS.primaryLight, alignSelf: "center" }} />
        <div style={{ fontSize: 16, fontWeight: 700, textAlign: "center" }}>Laskar Pelangi</div>
        <div style={{ fontSize: 13, color: COLORS.midGray, textAlign: "center" }}>Andrea Hirasta</div>
        <div style={{ fontSize: 18, fontWeight: 600, color: COLORS.primary, textAlign: "center" }}>Rp 75.000</div>
        <MockButton label="Beli Sekarang" small />
      </>
    );
  }
  if (demoTitle.includes("Form")) {
    return (
      <>
        <div style={{ fontSize: 18, fontWeight: 600, color: COLORS.primary }}>Tambah Buku</div>
        <MockInput label="Judul" error />
        <MockInput label="Penulis" />
        <MockInput label="Harga" />
        <MockButton label="Simpan" small />
      </>
    );
  }
  if (demoTitle.includes("Transaksi")) {
    return (
      <>
        <div style={{ fontSize: 18, fontWeight: 600, color: COLORS.primary }}>Transaksi</div>
        {[1, 2].map((i) => (
          <div key={i} style={{ display: "flex", justifyContent: "space-between", fontSize: 13, padding: 8, borderRadius: 8, backgroundColor: COLORS.offWhite }}>
            <span>Laskar Pelangi ×{i}</span>
            <span>Rp {75 * i}K</span>
          </div>
        ))}
        <div style={{ borderTop: `1px solid ${COLORS.lightGray}`, paddingTop: 8, display: "flex", justifyContent: "space-between", fontWeight: 700, fontSize: 16 }}>
          <span>Total</span>
          <span style={{ color: COLORS.primary }}>Rp 225K</span>
        </div>
        <MockButton label="Simpan Transaksi" small />
      </>
    );
  }
  // Laporan
  return (
    <>
      <div style={{ fontSize: 18, fontWeight: 600, color: COLORS.primary }}>Laporan</div>
      <MockStat label="Total Pendapatan" value="Rp 450K" wide />
      <MockStat label="Jumlah Transaksi" value="5" wide />
      <div style={{ fontSize: 14, fontWeight: 600, color: COLORS.textDark, marginTop: 8 }}>Transaksi Terbaru:</div>
      {[1, 2, 3].map((i) => (
        <div key={i} style={{ display: "flex", justifyContent: "space-between", fontSize: 12, padding: 6, backgroundColor: COLORS.offWhite, borderRadius: 6 }}>
          <span>2026-11-0{i}</span>
          <span>Rp 75K</span>
        </div>
      ))}
    </>
  );
};

const MockInput: React.FC<{ label: string; error?: boolean; small?: boolean }> = ({ label, error, small }) => (
  <div>
    <div style={{ fontSize: small ? 11 : 12, color: COLORS.textSecondary, marginBottom: 4 }}>{label}</div>
    <div
      style={{
        height: small ? 32 : 40,
        borderRadius: 8,
        border: `1px solid ${error ? COLORS.error : COLORS.lightGray}`,
        display: "flex",
        alignItems: "center",
        paddingLeft: 12,
        fontSize: 14,
        color: COLORS.midGray,
      }}
    >
      {error ? "⚠ " + label + " wajib diisi" : ""}
    </div>
  </div>
);

const MockButton: React.FC<{ label: string; small?: boolean }> = ({ label, small }) => (
  <div
    style={{
      height: small ? 36 : 44,
      borderRadius: 8,
      backgroundColor: COLORS.primary,
      color: COLORS.white,
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
      fontSize: small ? 14 : 16,
      fontWeight: 600,
      fontFamily: "sans-serif",
      marginTop: 4,
    }}
  >
    {label}
  </div>
);

const MockStat: React.FC<{ label: string; value: string; wide?: boolean }> = ({ label, value, wide }) => (
  <div
    style={{
      flex: wide ? "1" : "1",
      padding: 12,
      borderRadius: 8,
      backgroundColor: COLORS.primaryLight,
      color: COLORS.white,
      textAlign: "center",
    }}
  >
    <div style={{ fontSize: 11, opacity: 0.8 }}>{label}</div>
    <div style={{ fontSize: 18, fontWeight: 700 }}>{value}</div>
  </div>
);
