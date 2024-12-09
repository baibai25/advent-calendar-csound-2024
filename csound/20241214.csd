<CsoundSynthesizer>
<CsOptions>
-odac -m4
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1.0
seed 0

gkBpm init (128 / 60) * 4
giSin ftgen 1, 0, 1024, 10, 1
giKick ftgen 1, 0, 0, 1, "../samples/kick1.aif", 0, 4, 1
giMelody ftgen 2, 0, 0, 1, "../samples/melody.aiff", 0, 4, 1

schedule "clock", 0, -1

instr clock
    ktrig metro gkBpm
    kcount init 0
    if ktrig == 1 then
        schedulek "schedule", .0, .1, kcount
        kcount += 1
    endif
endin

instr schedule
    ibeat = p4
    if ibeat % 1 == 0 then
        schedule "_hihat", .0, random(.03, .13)
    endif

    if ibeat % 4 == 0 then
        schedule "_kick", .0, .3
        ibassNote[] fillarray -7, -5, -3, -5
        ibass = ibassNote[ int(ibeat / 16) % lenarray(ibassNote) ]
        schedule "_bass", 0, 1.0, cpsmidinn(ibass + 46)
    endif

    ; if ibeat % 4 == 2 then
    ;     schedule "_snare", .0, .15
    ; endif

    ; コーラス的な高いコード

    if ibeat % 32 == 0 then
        schedule "_melody", .0, 6
    endif
endin


instr _kick
    aindx line .0, p3, ftsr(giKick)*p3
    asig table aindx, giKick
    asig = asig*.7
    outs asig, asig
endin

instr _hihat
    asig noise line:a(.25, p3, .0), .0
    asig = asig*.7
    outs asig, asig
endin

instr _bass
    kfreq linseg p4+100, p3*.04, p4, p3*.8, p4
    asig foscil line:k(0.1, p3, 0)*1.2, kfreq, 1, 0.5, oscil:k(0.5, 1.3)+0.7
    asig = asig*1.7
    outs asig, asig
endin

instr _melody
    aindx line .0, p3, ftsr(giMelody)*p3
    asig table aindx, giMelody
    asig = asig*.7
    outs asig, asig
endin


</CsInstruments>

<CsScore>

</CsScore>
</CsoundSynthesizer>
