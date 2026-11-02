import React from "react";
import { AbsoluteFill, useCurrentFrame, interpolate, Easing, Audio, staticFile } from "remotion";
import { COLORS } from "../theme";

export const Scene01Pembuka: React.FC = () => {
  const frame = useCurrentFrame();

  // Animations
  const titleOpacity = interpolate(frame, [0, 30], [0, 1], {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
  });

  const titleScale = interpolate(frame, [0, 30], [0.8, 1], {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
    easing: Easing.out(Easing.cubic),
  });

  const subtitleOpacity = interpolate(frame, [20, 50], [0, 1], {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
  });

  const identityOpacity = interpolate(frame, [40, 70], [0, 1], {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
  });

  const identityTranslateY = interpolate(frame, [40, 70], [30, 0], {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
    easing: Easing.out(Easing.cubic),
  });

  return (
    <AbsoluteFill
      style={{
        background: `linear-gradient(135deg, ${COLORS.primaryDark} 0%, ${COLORS.primary} 100%)`,
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
      }}
    >
      <Audio src={staticFile("audio/scene01.mp3")} />

      {/* Decorative circle */}
      <div
        style={{
          position: "absolute",
          top: -100,
          right: -100,
          width: 400,
          height: 400,
          borderRadius: "50%",
          backgroundColor: "rgba(255,255,255,0.05)",
        }}
      />
      <div
        style={{
          position: "absolute",
          bottom: -150,
          left: -150,
          width: 500,
          height: 500,
          borderRadius: "50%",
          backgroundColor: "rgba(255,255,255,0.03)",
        }}
      />

      {/* Book emoji icon */}
      <div
        style={{
          fontSize: 80,
          marginBottom: 20,
          opacity: titleOpacity,
          transform: `scale(${titleScale})`,
        }}
      >
        📚
      </div>

      {/* Title */}
      <div
        style={{
          fontSize: 72,
          fontWeight: 700,
          color: COLORS.white,
          fontFamily: "sans-serif",
          opacity: titleOpacity,
          transform: `scale(${titleScale})`,
          textAlign: "center",
        }}
      >
        Toko Buku Novel
      </div>

      {/* Subtitle */}
      <div
        style={{
          fontSize: 28,
          color: "rgba(255,255,255,0.8)",
          fontFamily: "sans-serif",
          marginTop: 12,
          opacity: subtitleOpacity,
          textAlign: "center",
        }}
      >
        Aplikasi Kasir & Katalog Toko Buku
      </div>

      {/* Identity */}
      <div
        style={{
          marginTop: 60,
          opacity: identityOpacity,
          transform: `translateY(${identityTranslateY}px)`,
          textAlign: "center",
        }}
      >
        <div style={{ fontSize: 22, color: COLORS.white, fontFamily: "sans-serif", marginBottom: 8 }}>
          Annisa Asti Indriyani — 2301550007
        </div>
        <div style={{ fontSize: 18, color: "rgba(255,255,255,0.7)", fontFamily: "sans-serif" }}>
          MAWAD — Kelas A1 — Semester Ganjil 2026/2027
        </div>
      </div>
    </AbsoluteFill>
  );
};
