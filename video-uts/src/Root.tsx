import React from "react";
import { Composition, Series, staticFile, Audio } from "remotion";
import { COLORS, SCENE_DURATIONS, TOTAL_FRAMES, VIDEO } from "./theme";

import { Scene01Pembuka } from "./scenes/Scene01_Pembuka";
import { Scene02Masalah } from "./scenes/Scene02_Masalah";
import { Scene03Target } from "./scenes/Scene03_Target";
import { Scene04Scope } from "./scenes/Scene04_Scope";
import { Scene05Rancangan } from "./scenes/Scene05_Rancangan";
import { Scene06Demo } from "./scenes/Scene06_Demo";
import { Scene07Penutup } from "./scenes/Scene07_Penutup";

// Main composition — all 7 scenes in sequence
export const UTSVideo: React.FC = () => {
  return (
    <Series>
      <Series.Sequence durationInFrames={SCENE_DURATIONS.scene01}>
        <Scene01Pembuka />
      </Series.Sequence>
      <Series.Sequence durationInFrames={SCENE_DURATIONS.scene02}>
        <Scene02Masalah />
      </Series.Sequence>
      <Series.Sequence durationInFrames={SCENE_DURATIONS.scene03}>
        <Scene03Target />
      </Series.Sequence>
      <Series.Sequence durationInFrames={SCENE_DURATIONS.scene04}>
        <Scene04Scope />
      </Series.Sequence>
      <Series.Sequence durationInFrames={SCENE_DURATIONS.scene05}>
        <Scene05Rancangan />
      </Series.Sequence>
      <Series.Sequence durationInFrames={SCENE_DURATIONS.scene06}>
        <Scene06Demo />
      </Series.Sequence>
      <Series.Sequence durationInFrames={SCENE_DURATIONS.scene07}>
        <Scene07Penutup />
      </Series.Sequence>
    </Series>
  );
};

// Remotion register compositions
export const RemotionRoot: React.FC = () => {
  return (
    <>
      <Composition
        id="UTSVideo"
        component={UTSVideo}
        durationInFrames={TOTAL_FRAMES}
        fps={VIDEO.fps}
        width={VIDEO.width}
        height={VIDEO.height}
      />
    </>
  );
};
