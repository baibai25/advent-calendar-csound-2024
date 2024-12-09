convert_hello_csound_wav_to_mp3:
	csound hello.csd
	ffmpeg -i ../output/hello_csound.wav -codec:a libmp3lame -b:a 192k ../output/hello_csound.mp3
	rm ../output/hello_csound.wav
	echo "hello_csound.mp3 created"
