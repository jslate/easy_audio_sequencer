module EasyAudioSequencer
  module Instruments

    SINE = -> { Math.sin(2 * Math::PI * step) * 0.8 }
    SQUARE = -> { step < 0.5 ? -0.8 : 0.8 }
    TRIANGLE = -> { (1 - 4 * (step.round - step).abs) * 0.55 }
    SAW = -> { 2 * (step - step.round) * 0.8 }

    NOISE = -> { rand - 0.5 }

    EXP_FALLOFF  = -> { [(1 / (frame * 0.002)), 1.0].min }
    EXP_FALLOFF2 = -> { [(1 / (frame * 0.005)), 1.0].min }
    LIN_FALLOFF  = -> { (50000.0 - @frame) / 50000.0 }

    SNARE = -> { e(EXP_FALLOFF) * e(NOISE) * 0.8 }
    BASSDRUM = -> { [1.0,e(EXP_FALLOFF2) * e(NOISE) * 0.1 + e(SINE) * 2 * e(EXP_FALLOFF)].min }
    HIHAT = -> { e(NOISE) * 0.3 * e(EXP_FALLOFF2) + e(SQUARE) * 0.1 * e(EXP_FALLOFF2) }

    LEAD = -> { e(TRIANGLE) * e(EXP_FALLOFF) }
    LEAD2 = -> { e(SAW) * Math.sin(step * 4.0) * 0.2 * fr(SINE,2*freq*Math.tan(step*0.005)) * 0.4 + e(NOISE) * 0.05 }
    SQUARELEAD = -> { e(SQUARE) * 0.4 * e(EXP_FALLOFF) }
    SQUARELEAD2 = -> { e(SQUARE) * 0.4 * e(EXP_FALLOFF2) }
    PHASED = -> { fr(SINE, Math.sin(@step / 4.0) * (freq / 2.0)) * 0.01 * [1.0,frame.to_f/50000.0].max }

  end
end