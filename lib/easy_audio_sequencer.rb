require "easy_audio_sequencer/version"
require "easy_audio_sequencer/sound"
require "easy_audio_sequencer/instruments"
require "easy_audio_sequencer/sequencer"

module EasyAudioSequencer

  def self.freq_for_note(note)
    2.0 ** ((note-49.0)/12.0) * 440.0
  end

  def self.sn(fn, note)
    Sound.new(freq: freq_for_note(note), &fn)
  end

end
