import React from "react";
import { AbsoluteFill, Audio, staticFile, useCurrentFrame, interpolate } from "remotion";
import { COLORS } from "../theme";
import { SlideLayout, BulletPoint, Card } from "../components/SlideLayout";

export const Scene02Masalah: React.FC = () => {
  const frame = useCurrentFrame();

  const highlightOpacity = interpolate(frame, [120, 150], [0, 1], {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
  });

  return (
    <SlideLayout title="Masalah yang Diselesaikan">
      <Audio src={staticFile("audio/scene02.mp3")} />

      <div style={{ display: "flex", flexDirection: "column", gap: 20, marginTop: 20 }}>
        <BulletPoint
          text="Pencatatan transaksi masih manual dengan buku catatan"
          index={0}
          startFrame={15}
          icon="✕"
          color={COLORS.error}
        />
        <BulletPoint
          text="Stok buku sulit dipantau, sering tidak terbarui"
          index={1}
          startFrame={30}
          icon="✕"
          color={COLORS.error}
        />
        <BulletPoint
          text="Laporan penjualan membutuhkan waktu lama"
          index={2}
          startFrame={45}
          icon="✕"
          color={COLORS.error}
        />
        <BulletPoint
          text="Data mudah hilang dan rentan kesalahan"
          index={3}
          startFrame={60}
          icon="✕"
          color={COLORS.error}
        />

        {/* Highlight box */}
        <div
          style={{
            marginTop: 30,
            opacity: highlightOpacity,
          }}
        >
          <Card startFrame={120}>
            <div style={{ display: "flex", alignItems: "center", gap: 16 }}>
              <span style={{ fontSize: 40 }}>⚠️</span>
              <div>
                <div style={{ fontSize: 20, fontWeight: 600, color: COLORS.primary, fontFamily: "sans-serif" }}>
                  Akibatnya:
                </div>
                <div style={{ fontSize: 22, color: COLORS.textDark, fontFamily: "sans-serif", marginTop: 4 }}>
                  Pegawai toko kesulitan melayani pembeli dengan cepat
                </div>
              </div>
            </div>
          </Card>
        </div>

        {/* Solution hint */}
        <div
          style={{
            marginTop: 20,
            opacity: interpolate(frame, [200, 230], [0, 1], {
              extrapolateLeft: "clamp",
              extrapolateRight: "clamp",
            }),
          }}
        >
          <div
            style={{
              fontSize: 20,
              color: COLORS.primary,
              fontFamily: "sans-serif",
              fontWeight: 500,
            }}
          >
            Solusi: aplikasi yang mencatat transaksi, kelola stok, dan buat laporan secara digital
          </div>
        </div>
      </div>
    </SlideLayout>
  );
};
