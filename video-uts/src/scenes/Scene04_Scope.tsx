import React from "react";
import { AbsoluteFill, Audio, staticFile, useCurrentFrame, interpolate } from "remotion";
import { COLORS } from "../theme";
import { SlideLayout, Card } from "../components/SlideLayout";

export const Scene04Scope: React.FC = () => {
  const frame = useCurrentFrame();

  const moscowData = [
    { priority: "Must", color: COLORS.error, items: "Kelola buku (CRUD), Transaksi, Stok otomatis, Responsif", delay: 15 },
    { priority: "Should", color: COLORS.warning, items: "Laporan penjualan, Login email-password", delay: 45 },
    { priority: "Could", color: COLORS.info, items: "Pre-order, Wishlist", delay: 75 },
    { priority: "Won't", color: COLORS.midGray, items: "Payment gateway, OTP telepon", delay: 105 },
  ];

  const sitemapPages = [
    "Login", "Beranda", "Daftar Buku", "Detail Buku",
    "Transaksi", "Konfirmasi", "Form Buku", "Laporan", "Register"
  ];

  return (
    <SlideLayout title="Scope: Prioritas MoSCoW">
      <Audio src={staticFile("audio/scene04.mp3")} />

      <div style={{ display: "flex", gap: 30, marginTop: 10, flex: 1 }}>
        {/* Left: MoSCoW table */}
        <div style={{ flex: 1 }}>
          <div style={{ fontSize: 22, fontWeight: 600, color: COLORS.primary, fontFamily: "sans-serif", marginBottom: 16 }}>
            Kebutuhan Fungsional
          </div>

          <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
            {moscowData.map((row) => (
              <div
                key={row.priority}
                style={{
                  display: "flex",
                  gap: 16,
                  opacity: interpolate(frame, [row.delay, row.delay + 20], [0, 1], {
                    extrapolateLeft: "clamp",
                    extrapolateRight: "clamp",
                  }),
                  transform: `translateX(${interpolate(frame, [row.delay, row.delay + 20], [-50, 0], {
                    extrapolateLeft: "clamp",
                    extrapolateRight: "clamp",
                  })}px)`,
                }}
              >
                <div
                  style={{
                    width: 100,
                    height: 44,
                    borderRadius: 8,
                    backgroundColor: row.color,
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                    color: COLORS.white,
                    fontSize: 18,
                    fontWeight: 600,
                    fontFamily: "sans-serif",
                    flexShrink: 0,
                  }}
                >
                  {row.priority}
                </div>
                <div
                  style={{
                    fontSize: 18,
                    color: COLORS.textDark,
                    fontFamily: "sans-serif",
                    lineHeight: 1.4,
                    paddingTop: 8,
                  }}
                >
                  {row.items}
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Right: Sitemap */}
        <div style={{ flex: 1 }}>
          <div style={{ fontSize: 22, fontWeight: 600, color: COLORS.primary, fontFamily: "sans-serif", marginBottom: 16 }}>
            Sitemap — 9 Halaman
          </div>

          <Card startFrame={140}>
            {/* Navigation flow */}
            <div style={{ display: "flex", flexDirection: "column", gap: 10 }}>
              {/* Login → Beranda */}
              <div style={{ display: "flex", alignItems: "center", gap: 8 }}>
                <PageBox label="Login" delay={150} frame={frame} />
                <Arrow />
                <PageBox label="Beranda" delay={165} frame={frame} />
              </div>

              {/* Bottom Nav 4 tabs */}
              <div style={{ display: "flex", gap: 8, marginLeft: 130 }}>
                <PageBox label="Buku" delay={180} frame={frame} small />
                <PageBox label="Transaksi" delay={195} frame={frame} small />
                <PageBox label="Laporan" delay={210} frame={frame} small />
                <PageBox label="Form" delay={225} frame={frame} small />
              </div>

              {/* Sub pages */}
              <div style={{ display: "flex", gap: 8, marginLeft: 130, flexWrap: "wrap" }}>
                <PageBox label="Detail" delay={240} frame={frame} small />
                <PageBox label="Konfirmasi" delay={255} frame={frame} small />
                <PageBox label="Register" delay={270} frame={frame} small />
              </div>

              {/* Nav label */}
              <div style={{ fontSize: 16, color: COLORS.textSecondary, fontFamily: "sans-serif", marginTop: 8, textAlign: "center" }}>
                Bottom Navigation Bar — 4 tab utama
              </div>
            </div>
          </Card>

          {/* Priority explanation */}
          <div
            style={{
              marginTop: 20,
              fontSize: 18,
              color: COLORS.textDark,
              fontFamily: "sans-serif",
              lineHeight: 1.5,
              opacity: interpolate(frame, [300, 330], [0, 1], {
                extrapolateLeft: "clamp",
                extrapolateRight: "clamp",
              }),
            }}
          >
            <strong style={{ color: COLORS.primary }}>Fitur Must diprioritaskan</strong> karena
            merupakan alur bisnis inti toko buku.
          </div>
        </div>
      </div>
    </SlideLayout>
  );
};

// Helper components
const PageBox: React.FC<{ label: string; delay: number; frame: number; small?: boolean }> = ({
  label,
  delay,
  frame,
  small,
}) => {
  const opacity = interpolate(frame, [delay, delay + 15], [0, 1], {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
  });

  return (
    <div
      style={{
        padding: small ? "6px 12px" : "8px 16px",
        borderRadius: 8,
        backgroundColor: COLORS.primary,
        color: COLORS.white,
        fontSize: small ? 14 : 16,
        fontWeight: 500,
        fontFamily: "sans-serif",
        opacity,
        whiteSpace: "nowrap",
      }}
    >
      {label}
    </div>
  );
};

const Arrow: React.FC = () => (
  <span style={{ fontSize: 20, color: COLORS.midGray }}>→</span>
);
