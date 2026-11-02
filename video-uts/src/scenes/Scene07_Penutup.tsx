import React from "react";
import { AbsoluteFill, Audio, staticFile, useCurrentFrame, interpolate, Easing } from "remotion";
import { COLORS } from "../theme";

export const Scene07Penutup: React.FC = () => {
  const frame = useCurrentFrame();

  const roadmap = [
    { week: "Minggu 9", task: "Migrasi Firestore", delay: 15 },
    { week: "Minggu 10", task: "Firebase Auth", delay: 30 },
    { week: "Minggu 11", task: "Fitur Should (Lupa Sandi, Profil)", delay: 45 },
    { week: "Minggu 12", task: "Optimasi responsif web", delay: 60 },
    { week: "Minggu 15", task: "Deploy Firebase Hosting", delay: 75 },
  ];

  const closingOpacity = interpolate(frame, [120, 160], [0, 1], {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
  });

  const closingScale = interpolate(frame, [120, 160], [0.8, 1], {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
    easing: Easing.out(Easing.cubic),
  });

  const fadeOut = interpolate(frame, [1050, 1125], [1, 0], {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
  });

  return (
    <AbsoluteFill
      style={{
        background: `linear-gradient(135deg, ${COLORS.primaryDark} 0%, ${COLORS.primary} 100%)`,
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
        opacity: fadeOut,
      }}
    >
      <Audio src={staticFile("audio/scene07.mp3")} />

      {/* Roadmap */}
      <div style={{ position: "absolute", top: 100, left: 0, right: 0, opacity: interpolate(frame, [0, 120], [1, 0], {
        extrapolateLeft: "clamp",
        extrapolateRight: "clamp",
      }) }}>
        <div style={{ fontSize: 28, fontWeight: 600, color: COLORS.white, textAlign: "center", marginBottom: 30 }}>
          Rencana Pengembangan Lanjutan
        </div>
        <div style={{ display: "flex", flexDirection: "column", gap: 12, alignItems: "center" }}>
          {roadmap.map((item) => (
            <div
              key={item.week}
              style={{
                display: "flex",
                gap: 16,
                alignItems: "center",
                opacity: interpolate(frame, [item.delay, item.delay + 20], [0, 1], {
                  extrapolateLeft: "clamp",
                  extrapolateRight: "clamp",
                }),
                transform: `translateX(${interpolate(frame, [item.delay, item.delay + 20], [-50, 0], {
                  extrapolateLeft: "clamp",
                  extrapolateRight: "clamp",
                })}px)`,
              }}
            >
              <div
                style={{
                  padding: "6px 16px",
                  borderRadius: 8,
                  backgroundColor: COLORS.primaryLight,
                  color: COLORS.white,
                  fontSize: 16,
                  fontWeight: 600,
                  fontFamily: "sans-serif",
                  minWidth: 120,
                  textAlign: "center",
                }}
              >
                {item.week}
              </div>
              <div style={{ fontSize: 18, color: COLORS.white, fontFamily: "sans-serif" }}>
                {item.task}
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Closing text */}
      <div
        style={{
          opacity: closingOpacity,
          transform: `scale(${closingScale})`,
          textAlign: "center",
        }}
      >
        <div style={{ fontSize: 80, marginBottom: 20 }}>📚</div>
        <div style={{ fontSize: 48, fontWeight: 700, color: COLORS.white, fontFamily: "sans-serif" }}>
          Terima Kasih
        </div>
        <div style={{ fontSize: 24, color: "rgba(255,255,255,0.8)", fontFamily: "sans-serif", marginTop: 16 }}>
          Annisa Asti Indriyani — 2301550007
        </div>
        <div style={{ fontSize: 18, color: "rgba(255,255,255,0.6)", fontFamily: "sans-serif", marginTop: 8 }}>
          Toko Buku Novel — MAWAD — Kelas A1
        </div>
      </div>
    </AbsoluteFill>
  );
};
