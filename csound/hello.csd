<CsoundSynthesizer>
<CsOptions>
-odac -o ../output/hello_csound.wav -W
</CsOptions>
<CsInstruments>
sr = 44100 ; sampling rate
kr = 4410 ; control rate
ksamps = 32 ;number of samples in a control period (sr/kr)
nchnls = 2 ;output channeli
0dbfs = 1 ;sets value of 0 decibels

instr 1
    a1 oscil p4, p5, 1
    out a1
endin

</CsInstruments>
<CsScore>
; f: function number, load-time, table-size, GEN
; sine wave
f1 0 4096 10 1

; i: instrument number, Start-time, Duration, Amplitude
i1 0.0 0.4 0.5 261.63 ; C4
i1 0.5 0.4 0.5 261.63 ; C4
i1 1.0 0.4 0.5 392.00 ; G4
i1 1.5 0.4 0.5 392.00 ; G4

i1 2.0 0.4 0.5 440.00 ; A4
i1 2.5 0.4 0.5 440.00 ; A4
i1 3.0 0.9 0.5 392.00 ; G4

i1 4.0 0.4 0.5 349.23 ; F4
i1 4.5 0.4 0.5 349.23 ; F4
i1 5.0 0.4 0.5 329.63 ; E4
i1 5.5 0.4 0.5 329.63 ; E4

i1 6.0 0.4 0.5 293.66 ; D4
i1 6.5 0.4 0.5 293.66 ; D4
i1 7.0 0.9 1.0 261.63 ; C4
e
</CsScore>
</CsoundSynthesizer>
