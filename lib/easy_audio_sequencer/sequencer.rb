require 'easy_audio'

module EasyAudioSequencer

  class Sequencer
    def initialize(stream: EasyAudio::EasyStream.new(amp: 0.8, frame_size: 4096, latency: 12.0), bpm: 120)
      srand
      @stream = stream
      @stream.fn = method(:next_frame)
      @scene = nil
      @scenes = {}
      @rendered_scenes = {}
      @keyframes = {}
      @tracks = []
      @bpm = bpm.to_f
      @sample = 0
      @kf = 0
      @samples_per_bar = (@stream.sample_rate * 60) / @bpm
    end

    def next_frame
      if @keyframes[@kf.to_i]
        @scene = @keyframes[@kf.to_i]
      end
      @kf += 1

      if @rendered_scenes[@scene] && @rendered_scenes[@scene][@sample.to_i]
        result = @rendered_scenes[@scene][@sample.to_i]
      else
        result = calculate_frame(@scene, @sample.to_i)
      end

      @sample = (@sample + 1) % @samples_per_bar.to_i
      result
    end

    def add_scene(name = nil, tracks)
      @scenes[name.to_s || 'default'] = tracks.map do |track|
        track.map {|t| Sound === t ? t : t ? Sound.new(&t) : nil }
      end
    end

    def calculate_frame(name, i)
      @rendered_scenes[name] ||= {}
      total = 0.0
      @scenes[name].each do |track|
        q = @samples_per_bar.to_i / track.length
        n = (i / q).to_i
        step = (i.to_f / @stream.sample_rate) % 1.0
        total += track[n] ? track[n].next_frame(i % q, step) : 0.0
      end
      @rendered_scenes[name][i] = total
    end

    def render_scenes
      @rendered_scenes = {}
      @keyframes.values.uniq.each do |name|
        reader, writer = IO.pipe
        fork do
          reader.close
          data = @samples_per_bar.to_i.times.map do |i|
            calculate_frame(name, i)
          end
          writer.puts(Marshal.dump(data))
        end

        writer.close
        data = Marshal.load(reader.read)
        @rendered_scenes[name] = data
      end
    end

    def play(scenes: ['16:default'])
      @sample = 0
      @kf = 0
      @keyframes = {}

      last_frame = 0
      scenes.each do |scene|
        bars, name = *scene.split(':')
        @keyframes[last_frame] = name.to_s
        last_frame += (bars.to_i * @samples_per_bar).to_i
      end

      puts "Rendering scenes in background..."
      Thread.new { render_scenes }

      puts "Starting audio..."
      @stream.start
      sleep(last_frame.to_f / @stream.sample_rate)
      sleep 0.1 while @kf < last_frame
    end
  end

end



