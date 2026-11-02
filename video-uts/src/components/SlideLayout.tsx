import React from "react";
import { AbsoluteFill, useCurrentFrame, interpolate, Easing } from "remotion";
import { COLORS } from "../theme";

// Slide layout with green header bar and footer
export const SlideLayout: React.FC<{
  children: React.ReactNode;
  title?: string;
  bgColor?: string;
}> = ({ children, title, bgColor }) => {
  const frame = useCurrentFrame();

  const headerHeight = 80;
  const footerHeight = 50;

  return (
    <AbsoluteFill style={{ backgroundColor: bgColor || COLORS.background }}>
      {/* Header bar */}
      <div
        style={{
          position: "absolute",
          top: 0,
          left: 0,
          right: 0,
          height: headerHeight,
          background: `linear-gradient(135deg, ${COLORS.primaryDark}, ${COLORS.primary})`,
          display: "flex",
          alignItems: "center",
          paddingLeft: 60,
          paddingRight: 60,
        }}
      >
        {title && (
          <span
            style={{
              color: COLORS.white,
              fontSize: 28,
              fontWeight: 600,
              fontFamily: "sans-serif",
            }}
          >
            {title}
          </span>
        )}
      </div>

      {/* Content area */}
      <div
        style={{
          position: "absolute",
          top: headerHeight + 20,
          left: 60,
          right: 60,
          bottom: footerHeight + 10,
          display: "flex",
          flexDirection: "column",
        }}
      >
        {children}
      </div>

      {/* Footer */}
      <div
        style={{
          position: "absolute",
          bottom: 0,
          left: 0,
          right: 0,
          height: footerHeight,
          backgroundColor: COLORS.primaryDark,
          display: "flex",
          alignItems: "center",
          justifyContent: "space-between",
          paddingLeft: 60,
          paddingRight: 60,
        }}
      >
        <span style={{ color: COLORS.white, fontSize: 14, fontFamily: "sans-serif" }}>
          Toko Buku Novel — UTS MAWAD
        </span>
        <span style={{ color: COLORS.white, fontSize: 14, fontFamily: "sans-serif" }}>
          Annisa Asti Indriyani — 2301550007
        </span>
      </div>
    </AbsoluteFill>
  );
};

// Animated text that fades in word by word
export const AnimatedText: React.FC<{
  text: string;
  startFrame?: number;
  fontSize?: number;
  color?: string;
  fontWeight?: number;
  maxWidth?: number;
  lineHeight?: number;
  textAlign?: "left" | "center" | "right";
}> = ({
  text,
  startFrame = 0,
  fontSize = 24,
  color = COLORS.textDark,
  fontWeight = 400,
  maxWidth = 1800,
  lineHeight = 1.6,
  textAlign = "left",
}) => {
  const frame = useCurrentFrame();

  const words = text.split(" ");
  const wordsPerFrame = 2.5; // show ~2.5 words per frame
  const visibleWords = Math.max(0, Math.floor((frame - startFrame) * wordsPerFrame));

  const opacity = interpolate(
    frame,
    [startFrame, startFrame + 15],
    [0, 1],
    { extrapolateLeft: "clamp", extrapolateRight: "clamp" }
  );

  const displayText = words.slice(0, visibleWords).join(" ");

  return (
    <div
      style={{
        fontSize,
        color,
        fontWeight,
        fontFamily: "sans-serif",
        maxWidth,
        lineHeight,
        textAlign,
        opacity,
      }}
    >
      {displayText}
      {visibleWords < words.length && visibleWords > 0 && (
        <span style={{ opacity: 0.5 }}>...</span>
      )}
    </div>
  );
};

// Bullet point with slide-in animation
export const BulletPoint: React.FC<{
  text: string;
  index: number;
  startFrame?: number;
  icon?: string;
  color?: string;
}> = ({ text, index, startFrame = 0, icon = "•", color }) => {
  const frame = useCurrentFrame();
  const delay = startFrame + index * 15;

  const translateX = interpolate(
    frame,
    [delay, delay + 20],
    [-100, 0],
    { extrapolateLeft: "clamp", extrapolateRight: "clamp", easing: Easing.out(Easing.cubic) }
  );

  const opacity = interpolate(
    frame,
    [delay, delay + 15],
    [0, 1],
    { extrapolateLeft: "clamp", extrapolateRight: "clamp" }
  );

  return (
    <div
      style={{
        display: "flex",
        alignItems: "flex-start",
        gap: 12,
        opacity,
        transform: `translateX(${translateX}px)`,
        marginBottom: 16,
      }}
    >
      <span
        style={{
          fontSize: 24,
          fontWeight: 700,
          color: color || COLORS.primary,
          minWidth: 30,
          fontFamily: "sans-serif",
        }}
      >
        {icon}
      </span>
      <span
        style={{
          fontSize: 22,
          color: COLORS.textDark,
          fontFamily: "sans-serif",
          lineHeight: 1.5,
        }}
      >
        {text}
      </span>
    </div>
  );
};

// Card component for tables and info boxes
export const Card: React.FC<{
  children: React.ReactNode;
  padding?: number;
  startFrame?: number;
}> = ({ children, padding = 24, startFrame = 0 }) => {
  const frame = useCurrentFrame();

  const opacity = interpolate(
    frame,
    [startFrame, startFrame + 20],
    [0, 1],
    { extrapolateLeft: "clamp", extrapolateRight: "clamp" }
  );

  const scale = interpolate(
    frame,
    [startFrame, startFrame + 20],
    [0.95, 1],
    { extrapolateLeft: "clamp", extrapolateRight: "clamp", easing: Easing.out(Easing.cubic) }
  );

  return (
    <div
      style={{
        backgroundColor: COLORS.white,
        borderRadius: 12,
        padding,
        boxShadow: "0 2px 8px rgba(0,0,0,0.1)",
        border: `1px solid ${COLORS.lightGray}`,
        opacity,
        transform: `scale(${scale})`,
      }}
    >
      {children}
    </div>
  );
};

// Progress bar at bottom showing video progress
export const ProgressBar: React.FC<{ totalFrames: number }> = ({ totalFrames }) => {
  const frame = useCurrentFrame();
  const progress = frame / totalFrames;

  return (
    <div
      style={{
        position: "absolute",
        bottom: 50,
        left: 0,
        right: 0,
        height: 4,
        backgroundColor: "rgba(255,255,255,0.2)",
      }}
    >
      <div
        style={{
          width: `${progress * 100}%`,
          height: "100%",
          backgroundColor: COLORS.primaryLight,
        }}
      />
    </div>
  );
};
