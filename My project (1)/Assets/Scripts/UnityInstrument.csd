<Cabbage>
form caption("Untitled") size(450, 300), guiMode("queue") pluginId("def1")

hslider bounds(118, 18, 54, 63) channel("attack") range(0.01, 0.5, 0.1, 1, 0.001) text("Attack") colour(255, 255, 255, 255) outlineColour(255, 255, 255, 255)
hslider bounds(118, 82, 54, 63) channel("release") range(0.1, 4, 0.4, 1, 0.1) text("Decay") colour(255, 255, 255, 255) outlineColour(255, 255, 255, 255)

button bounds(36, 42, 80, 40) channel("trigger")

hslider bounds(46, 162, 150, 64) channel("freq") range(0, 1000, 400, 1, 0.001)
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d 
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 2
0dbfs  = 1

ga1		init	0
ga2		init	0
ga3 	init 	0
ga4 	init	0

turnon 20
turnon 21

instr Trig
    kTrig chnget "trigger"
    if changed(kTrig) == 1 then 
        event "i", "Synth", 0, 0.9
      endif
endin


instr Synth
   //aEnv expon 1, p3, 0.001
   kfilt chnget "cutoff"
   aEnv adsr chnget:i("attack"), 0.2, 0.5, chnget:i("release")
   aSig oscili aEnv, chnget:i("freq")
   ares = rezzy(aSig, kfilt, 1)
 outs ares,ares
 endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>100</x>
 <y>100</y>
 <width>320</width>
 <height>240</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="background">
  <r>240</r>
  <g>240</g>
  <b>240</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
