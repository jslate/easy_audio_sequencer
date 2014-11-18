# EasyAudioSequencer

I took the sample sequencer code from lsegal's easy_audio gem and created a gem out of it.

https://github.com/lsegal/easy_audio/

## Installation

Add this line to your application's Gemfile:

    gem 'easy_audio_sequencer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easy_audio_sequencer

## Usage

    require 'easy_audio'
    require 'easy_audio_sequencer'

    SNARE         = EasyAudioSequencer::Instruments::SNARE
    BASSDRUM      = EasyAudioSequencer::Instruments::BASSDRUM
    LEAD          = EasyAudioSequencer::Instruments::LEAD
    LEAD2         = EasyAudioSequencer::Instruments::LEAD2
    TRIANGLE      = EasyAudioSequencer::Instruments::TRIANGLE
    SQUARELEAD    = EasyAudioSequencer::Instruments::SQUARELEAD
    SINE          = EasyAudioSequencer::Instruments::SINE
    HIHAT         = EasyAudioSequencer::Instruments::HIHAT
    PHASED        = EasyAudioSequencer::Instruments::PHASED
    EXP_FALLOFF2  = EasyAudioSequencer::Instruments::EXP_FALLOFF2

    s = EasyAudioSequencer::Sequencer.new bpm: 43
    s.add_scene :A, [
      [nil, nil, SNARE, nil],
      [EasyAudioSequencer.sn(BASSDRUM, 20), nil, nil, nil],
      [nil, EasyAudioSequencer.sn(SQUARELEAD, 46)] * 4,
      [EasyAudioSequencer.sn(LEAD, 51), nil, nil, EasyAudioSequencer.sn(TRIANGLE,49)],
      [nil, EasyAudioSequencer.sn(SINE,20), nil, nil] * 2,
    ]
    s.add_scene :A2, [
      [nil, nil, SNARE, nil],
      [EasyAudioSequencer.sn(BASSDRUM, 20), nil, nil, nil],
      [nil, EasyAudioSequencer.sn(SQUARELEAD, 46)] * 4,
      [EasyAudioSequencer.sn(LEAD, 51), nil, nil, EasyAudioSequencer.sn(TRIANGLE,54)],
      [nil, EasyAudioSequencer.sn(SINE,26), nil, nil] * 2,
    ]
    s.add_scene :B, [
      [EasyAudioSequencer.sn(HIHAT, 70), nil, nil, nil, EasyAudioSequencer.sn(HIHAT, 70), nil, EasyAudioSequencer.sn(HIHAT, 70), nil] * 2,
      [nil, nil, SNARE, nil],
      [EasyAudioSequencer.sn(BASSDRUM, 20), nil, nil, nil, SNARE, nil, EasyAudioSequencer.sn(BASSDRUM, 20), nil],
      [nil, EasyAudioSequencer.sn(SQUARELEAD, 42)] * 4,
      [EasyAudioSequencer.sn(LEAD, 51), nil, nil, EasyAudioSequencer.sn(TRIANGLE,49)],
      [nil, EasyAudioSequencer.sn(SINE,23), nil, nil] * 2,
    ]
    s.add_scene :C, [
      [EasyAudioSequencer.sn(HIHAT, 70), nil, nil, nil, EasyAudioSequencer.sn(HIHAT, 70), nil, EasyAudioSequencer.sn(HIHAT, 70), nil] * 2,
      [nil, nil, nil, nil, nil, SNARE, nil, nil, nil, nil],
      [nil, EasyAudioSequencer.sn(SQUARELEAD, 49), nil, EasyAudioSequencer.sn(SQUARELEAD, 49), nil, nil, nil, EasyAudioSequencer.sn(-> { e(TRIANGLE) * 0.5 }, 54)],
      [EasyAudioSequencer.sn(BASSDRUM, 20), nil, nil, nil, nil, nil, EasyAudioSequencer.sn(BASSDRUM, 20), nil],
      [EasyAudioSequencer.sn(LEAD, 46), EasyAudioSequencer.sn(LEAD, 46), nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, EasyAudioSequencer.sn(TRIANGLE,42)],
      [nil, nil, nil, nil, EasyAudioSequencer.sn(LEAD2,59), EasyAudioSequencer.sn(LEAD2,59), nil, nil],
      [EasyAudioSequencer.sn(SINE,18)],
      [EasyAudioSequencer.sn(PHASED,20)]
    ]
    s.add_scene :D, [
      [nil, EasyAudioSequencer.sn(SQUARELEAD, 46)] * 4,
      [EasyAudioSequencer.sn(LEAD, 51), nil, nil, EasyAudioSequencer.sn(TRIANGLE,49)],
    ]
    s.add_scene :D2, [
      [nil, EasyAudioSequencer.sn(SQUARELEAD, 46)] * 4,
      [EasyAudioSequencer.sn(TRIANGLE, 51), nil, nil, EasyAudioSequencer.sn(TRIANGLE,46)],
    ]
    s.add_scene :D3, [
      [nil, EasyAudioSequencer.sn(SQUARELEAD, 46)] * 4,
      [EasyAudioSequencer.sn(TRIANGLE, 42), nil, nil, nil],
    ]
    s.add_scene :D4, [
      [nil, EasyAudioSequencer.sn(SQUARELEAD, 46)] * 4,
    ]

    s.add_scene :D5, [
      [nil, EasyAudioSequencer.sn(-> { e(SQUARELEAD) * e(EXP_FALLOFF2) }, 46)] * 4,
      [EasyAudioSequencer.sn(-> { e(SQUARELEAD) * e(EXP_FALLOFF2) }, 46), nil, nil, nil, nil, nil, nil, nil]
    ]

    # Play!
    s.play scenes: %w(
      2:D5
      1:A 1:A2 2:B 4:C
      1:A 1:A2 2:B 4:C
      1:D 1:D2 1:D3 1:D4
    )

## Contributing

1. Fork it ( http://github.com/<my-github-username>/easy_audio_sequencer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
