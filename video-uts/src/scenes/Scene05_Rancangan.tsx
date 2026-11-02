import React from "react";
import { AbsoluteFill, Audio, staticFile, useCurrentFrame, interpolate, Img } from "remotion";
import { COLORS } from "../theme";
import { SlideLayout, Card } from "../components/SlideLayout";

export const Scene05Rancangan: React.FC = () => {
  const frame = useCurrentFrame();

  const collections = [
    {
      name: "books",
      fields: ["judul: String", "penulis: String", "kategori: String", "harga: Number", "stok: Number"],
      delay: 200,
    },
    {
      name: "transactions",
      fields: ["items: Array", "total: Number", "tanggal: Timestamp", "userId: String"],
      delay: 260,
    },
    {
      name: "users",
      fields: ["nama: String", "email: String", "peran: String"],
      delay: 320,
    },
    {
      name: "categories",
      fields: ["nama: String", "color: String"],
      delay: 380,
    },
  ];

  const techStack = ["Flutter + Dart", "Provider", "Firebase", "Firestore", "GitHub", "Figma"];

  return (
    <SlideLayout title="Rancangan: Wireframe & Database">
      <Audio src={staticFile("audio/scene05.mp3")} />

      <div style={{ display: "flex", gap: 30, marginTop: 10, flex: 1 }}>
        {/* Left: Wireframe info */}
        <div style={{ flex: 1, display: "flex", flexDirection: "column", gap: 16 }}>
          <div style={{ fontSize: 22, fontWeight: 600, color: COLORS.primary, fontFamily: "sans-serif" }}>
            Wireframe Figma
          </div>

          <Card startFrame={30}>
            <div style={{ fontSize: 18, color: COLORS.textDark, fontFamily: "sans-serif", lineHeight: 1.6 }}>
              <div style={{ marginBottom: 8 }}>📱 <strong>7 frame mobile</strong> + 2 keadaan (galat, kosong)</div>
              <div style={{ marginBottom: 8 }}>💻 <strong>2 frame web</strong> dengan sidebar</div>
              <div style={{ marginBottom: 8 }}>🎨 Style guide: <strong>#2E7D32</strong>, Poppins, tombol 48px</div>
              <div style={{ marginTop: 12, padding: "8px 12px", backgroundColor: COLORS.primaryLight, borderRadius: 8, color: COLORS.white, fontSize: 20, fontWeight: 600, textAlign: "center" }}>
                Nilai: 98/100 (tertinggi sekelas)
              </div>
            </div>
          </Card>

          {/* Tech Stack */}
          <div style={{ fontSize: 22, fontWeight: 600, color: COLORS.primary, fontFamily: "sans-serif", marginTop: 8 }}>
            Tech Stack
          </div>
          <div style={{ display: "flex", flexWrap: "wrap", gap: 10 }}>
            {techStack.map((tech, i) => (
              <div
                key={tech}
                style={{
                  padding: "8px 16px",
                  borderRadius: 8,
                  backgroundColor: COLORS.primaryDark,
                  color: COLORS.white,
                  fontSize: 16,
                  fontWeight: 500,
                  fontFamily: "sans-serif",
                  opacity: interpolate(frame, [450 + i * 15, 465 + i * 15], [0, 1], {
                    extrapolateLeft: "clamp",
                    extrapolateRight: "clamp",
                  }),
                }}
              >
                {tech}
              </div>
            ))}
          </div>
        </div>

        {/* Right: Database schema */}
        <div style={{ flex: 1, display: "flex", flexDirection: "column", gap: 12 }}>
          <div style={{ fontSize: 22, fontWeight: 600, color: COLORS.primary, fontFamily: "sans-serif" }}>
            Rancangan Database Firestore
          </div>

          {collections.map((col) => (
            <div
              key={col.name}
              style={{
                opacity: interpolate(frame, [col.delay, col.delay + 20], [0, 1], {
                  extrapolateLeft: "clamp",
                  extrapolateRight: "clamp",
                }),
                transform: `translateX(${interpolate(frame, [col.delay, col.delay + 20], [50, 0], {
                  extrapolateLeft: "clamp",
                  extrapolateRight: "clamp",
                })}px)`,
              }}
            >
              <Card startFrame={col.delay} padding={16}>
                <div
                  style={{
                    fontSize: 18,
                    fontWeight: 600,
                    color: COLORS.primaryDark,
                    fontFamily: "monospace",
                    marginBottom: 8,
                  }}
                >
                  📦 {col.name}
                </div>
                <div style={{ display: "flex", flexDirection: "column", gap: 4 }}>
                  {col.fields.map((field) => (
                    <div
                      key={field}
                      style={{
                        fontSize: 15,
                        color: COLORS.textSecondary,
                        fontFamily: "monospace",
                        paddingLeft: 20,
                      }}
                    >
                      └─ {field}
                    </div>
                  ))}
                </div>
              </Card>
            </div>
          ))}

          {/* Repository pattern note */}
          <div
            style={{
              marginTop: 8,
              padding: "12px 16px",
              borderRadius: 8,
              backgroundColor: "rgba(46,125,50,0.1)",
              border: `1px solid ${COLORS.primary}`,
              fontSize: 16,
              color: COLORS.primaryDark,
              fontFamily: "sans-serif",
              opacity: interpolate(frame, [460, 490], [0, 1], {
                extrapolateLeft: "clamp",
                extrapolateRight: "clamp",
              }),
            }}
          >
            <strong>Repository Pattern</strong> — local-first sekarang, migrasi ke Firestore tanpa mengubah UI
          </div>
        </div>
      </div>
    </SlideLayout>
  );
};
