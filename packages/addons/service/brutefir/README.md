# BruteFIR

https://www.ludd.ltu.se/~torger/brutefir.html


## Architecture

BruteFIR will be started as an system-wide service, managed by systemd. It receives and send its audio-data by named pipes.


BruteFIR service setup:

        # create required pipes as configured for BruteFIR
        mkfifo <:path_to_brutefir_input_pipe>
        mkfifo <:path_to_brutefir_output_pipe_highpass>
        mkfifo <:path_to_brutefir_output_pipe_lowpass>

        # enable and start BruteFIR
        systemctl enable brutefir.service
        systemctl start brutefir.service

        
BruteFIR configuration:

        logic: "cli" { port: 3000; };

        coeff "<:highpass_coeffs>" {
                filename: "/path/to/highpass.coeff";
        };

        coeff "<:lowpass_coeffs>" {
                filename: "/path/to/lowpass.coeff";
        };

        input "left", "right" {
                device: "file" { path: "<:path_to_brutefir_input_pipe>"; };
                sample: "S16_LE";
                channels: 2;
        };

        output "<:highpass_output_name>", "<:highpass_filter_name>" {
                device: "file" { path: "<:path_to_brutefir_output_pipe_highpass>"; };
                sample: "S16_LE";
                channels: 2;
        };

        output "<:lowpass_output_name>", "<:highpass_filter_name>" {
                device: "file" { path: "<:path_to_brutefir_output_pipe_lowpass>"; };
                sample: "S16_LE";
                channels: 2;
        };

        filter "<:highpass_filter_name>" {
                inputs: 0/6.0;
                outputs: "<:highpass_output_name>";
                process: 0;
            coeff: "<:highpass_coeffs>";
        };

        filter "<:lowpass_filter_name>" {
                inputs: "right"/6.0;
                outputs: "<:lowpass_output_name>";
                process: 0;
            coeff: "<:lowpass_coeffs>";
        };


## Pulseaudio integration

I'm planning to integrate with pulseaudio by utilizing the modules [module-pipe-sink](https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#index1h3) for sending and [module-pipe-source](https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#index1h3) for receiving audio-data from BruteFIR.


Code sketch:

        # make pulseaudio send audio to brutefir
        pactl load-module module-pipe-sink file=<:path_to_brutefir_socket>
        
        # make pulseaudio to pickup processed audio from brutefir
        pactl load-module module-pipe-source file=<:path_to_brutefir_socket>
