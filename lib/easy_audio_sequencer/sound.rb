module EasyAudioSequencer

  class Sound
    def initialize(freq: 1, &block)
      @freq = freq
      @fn = block
      @frame = 0
      @step = 0
    end

    attr_accessor :frame, :step, :freq

    def next_frame(frame, step)
      @frame, @step = frame, step
      calculate_step
      instance_exec(&@fn)
    end

    def calculate_step
      @step = (step * @freq.to_f) % 1.0
    end

    def e(fn = nil, &block)
      instance_exec(&(fn || block))
    end

    def f(fn = nil, note, &block)
      orig_freq, orig_step = @freq, @step
      @freq = freq_for_note(note)
      calculate_step
      result = e(fn || block)
      @freq = orig_freq
      @step = orig_step
      result
    end

    def fr(fn = nil, freq, &block)
      orig_freq, orig_step = @freq, @step
      @freq = freq
      calculate_step
      result = e(fn || block)
      @freq = orig_freq
      @step = orig_step
      result
    end
  end

end