"""
Auditory Mismatch Negativity
======================

MMN / Auditory oddball paradigm stimulus presentation.

This version is for use in the alcohol/Sentia EEG studyusing the Emotiv Epoc Flex EEG system - uses Lab Streaming Layer
to communicate markers [as integers] to emotivPRO recording suite, although LabRecorder would also work.

AS2022
"""

from time import time
from optparse import OptionParser

# alex add - force PTB
from psychopy import prefs
prefs.hardware['audioLib'] = ['PTB']

import numpy as np
from pandas import DataFrame
from psychopy import visual, core, event, sound
from pylsl import StreamInfo, StreamOutlet, local_clock




parser = OptionParser()
parser.add_option("-d", "--duration",
                  dest="duration", type='int', default=400,
                  help="duration of the recording in seconds.")

(options, args) = parser.parse_args()

# Create markers stream outlet
info = StreamInfo('MMN_Markers', 'Markers', 1, 0, 'int32', 'myuidw43536')
outlet = StreamOutlet(info)

input('LSL outlet opened, connect to it in EmotivPRO, then press to continue')

markernames = [1, 2]
start = time()

# Set up trial parameters
n_trials = 2010
iti = 0.3
soa = 0.2
jitter = 0.2
record_duration = np.float32(options.duration)

# Initialize stimuli
#aud1 = sound.Sound('C', octave=5, sampleRate=44100, secs=0.2, bits=8)
aud1 = sound.Sound('C', octave=5, sampleRate=44100, secs=0.2)
aud1.setVolume(0.8)
#aud2 = sound.Sound('D', octave=6, sampleRate=44100, secs=0.2, bits=8)
aud2 = sound.Sound('D', octave=6, sampleRate=44100, secs=0.2)
aud2.setVolume(0.8)
auds = [aud1, aud2]

# Setup trial list
sound_ind = np.random.binomial(1, 0.25, n_trials)
trials = DataFrame(dict(sound_ind=sound_ind, timestamp=np.zeros(n_trials)))

# Setup graphics
mywin = visual.Window([1920, 1080], monitor='testMonitor', units='deg',
                      fullscr=False)
fixation = visual.GratingStim(win=mywin, size=0.2, pos=[0, 0], sf=0,
                              rgb=[1, 0, 0])
fixation.setAutoDraw(True)
mywin.flip()

for ii, trial in trials.iterrows():
    # Intertrial interval
    core.wait(iti + np.random.rand() * jitter)

    # Select and play sound
    ind = trials['sound_ind'].iloc[ii]
    auds[ind].play()

    # Send marker
    timestamp = local_clock()
    outlet.push_sample([markernames[ind]])

    # offset
    core.wait(soa)
    if len(event.getKeys()) > 0 or (time() - start) > record_duration:
        break
    event.clearEvents()

# Cleanup
mywin.close()
