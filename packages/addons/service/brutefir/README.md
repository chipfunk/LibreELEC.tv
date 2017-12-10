# BruteFIR

https://www.ludd.ltu.se/~torger/brutefir.html


## Architecture

BruteFIR will be started as an system-wide service, managed by systemd.


## Pulseaudio integration

I'm planning to integrate with pulseaudio by utilizing the modules [module-pipe-sink](https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#index1h3) for sending and [module-pipe-source](https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#index1h3) for receiving audio-data from BruteFIR.


Code sketch:

        # send audio to brutefir
        pactl load-module module-pipe-sink file=<:path_to_brutefir_socket>
        
        # pickup processed audio from brutefir
        pactl load-module module-pipe-source file=<:path_to_brutefir_socket>
