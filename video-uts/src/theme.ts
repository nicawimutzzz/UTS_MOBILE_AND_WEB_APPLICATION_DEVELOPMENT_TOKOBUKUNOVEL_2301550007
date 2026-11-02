// Theme constants for UTS Video — Toko Buku Novel
// Matches the Flutter app's style guide

export const COLORS = {
  primary: "#2E7D32",
  primaryDark: "#1B5E20",
  primaryLight: "#4CAF50",
  accent: "#81C784",
  white: "#FFFFFF",
  offWhite: "#F5F5F5",
  lightGray: "#E0E0E0",
  midGray: "#757575",
  darkGray: "#424242",
  textDark: "#212121",
  textSecondary: "#616161",
  textLight: "#FFFFFF",
  error: "#D32F2F",
  warning: "#F57C00",
  info: "#1976D2",
  success: "#388E3C",
  background: "#FAFAFA",
};

export const FONTS = {
  title: "sans-serif",
  body: "sans-serif",
};

export const VIDEO = {
  width: 1920,
  height: 1080,
  fps: 30,
};

// Scene durations in frames (at 30fps) — based on actual TTS audio durations
// Each scene gets audio duration + 30 frames (1s) padding for transitions
export const SCENE_DURATIONS = {
  scene01: 1005,  // 33.5s (32.5s audio + 1s pad)
  scene02: 1416,  // 47.2s (46.2s audio + 1s pad)
  scene03: 1680,  // 56.0s (55.0s audio + 1s pad)
  scene04: 1935,  // 64.5s (63.5s audio + 1s pad)
  scene05: 2496,  // 83.2s (82.2s audio + 1s pad)
  scene06: 1992,  // 66.4s (65.4s audio + 1s pad)
  scene07: 1125,  // 37.5s (36.5s audio + 1s pad)
};

export const TOTAL_FRAMES = Object.values(SCENE_DURATIONS).reduce((a, b) => a + b, 0);
