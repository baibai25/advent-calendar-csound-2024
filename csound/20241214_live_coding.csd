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
giKick ftgen 1, 0, 0, 1, "../samples/kick.wav", 0, 4, 1
giSnare ftgen 2, 0, 0, 1, "../samples/snare.wav", 0, 4, 1
giMelody ftgen 3, 0, 0, 1, "../samples/melody.aiff", 0, 4, 1

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
    if ibeat % 4 == 0 then
        /* kick */
        ;schedule "_kick", .0, .3
        ibassNote[] fillarray 43, 41, 39, 41
        ibass = ibassNote[ int(ibeat / 16) % lenarray(ibassNote) ]

        /* bass */
        ;schedule "_bass", 0, .8, cpsmidinn(ibass)
    endif

    /* hihat */
    if ibeat % 1 == 0 then
        ;schedule "_hihat", .0, random(.03, .13)
    endif

    /* snare */
    if ibeat % 8 == 3 then
        ;schedule "_snare", .1, .2
    endif

    /* pad */
    if ibeat % 8 == 0 then
        ipadNote[] fillarray 67, 65, 63, 65
        ipad = ipadNote[ int(ibeat / 16) % lenarray(ipadNote) ]
        ;schedule "_pad", .0, 1.0, cpsmidinn(ipad)
    endif

    /* melody */
    if ibeat % 32 == 0 then
        ;schedule "_melody", .0, 6
    endif
endin

instr _kick
    aindx line .0, p3, ftsr(giKick)*p3
    asig table aindx, giKick
    asig = asig*.8
    outs asig, asig
endin

instr _snare
    aindx line .0, p3, ftsr(giSnare)*p3
    asig table aindx, giSnare
    asig = asig*.6
    outs asig, asig
endin

instr _hihat
    asig noise line:a(.25, p3, .0), .0
    asig = asig*.6
    outs asig, asig
endin

instr _bass
    kfreq linseg p4+100, p3*.04, p4, p3*.8, p4
    asig foscil line:k(0.1, p3, 0)*1.2, kfreq, 1, 0.5, oscil:k(0.5, 1.3)+0.7
    asig = asig*1.8
    outs asig, asig
endin

instr _pad
    kenv linseg .0, p3*.2, 1, p3*.6, 1, p3*.2, .0
    al = reson(noise(0.007*kenv,0.0), p4, 0.8) * 0.007
    ar = reson(noise(0.007*kenv,0.0), p4+2, 0.8) * 0.007
    outs al, ar
endin

instr _melody
    aindx line .0, p3, ftsr(giMelody)*p3
    asig table aindx, giMelody
    asig = asig*.2
    outs asig, asig
endin

</CsInstruments>

<CsScore>
</CsScore>

</CsoundSynthesizer>
